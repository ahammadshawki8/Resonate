import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart' hide UserProfile;
import '../generated/protocol.dart';

/// Endpoint for analytics and trends.
class AnalyticsEndpoint extends Endpoint {
  Future<int> _getProfileId(Session session) async {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      throw Exception('Authentication required');
    }
    final userId = authInfo.authUserId;

    final profile = await UserProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(userId),
    );

    if (profile == null) {
      throw Exception('Profile not found');
    }

    return profile.id!;
  }

  /// Get weekly analytics.
  Future<WeeklyAnalytics> getWeeklyAnalytics(Session session) async {
    final profileId = await _getProfileId(session);
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));
    final twoWeeksAgo = now.subtract(const Duration(days: 14));

    final thisWeekEntries = await VoiceEntry.db.find(
      session,
      where: (t) =>
          t.userProfileId.equals(profileId) & (t.recordedAt > weekAgo),
    );

    final lastWeekEntries = await VoiceEntry.db.find(
      session,
      where: (t) =>
          t.userProfileId.equals(profileId) &
          (t.recordedAt > twoWeeksAgo) &
          (t.recordedAt <= weekAgo),
    );

    final thisWeekAvg = thisWeekEntries.isNotEmpty
        ? thisWeekEntries.fold<double>(0, (sum, e) => sum + e.finalMoodScore) /
            thisWeekEntries.length
        : 0.0;

    final lastWeekAvg = lastWeekEntries.isNotEmpty
        ? lastWeekEntries.fold<double>(0, (sum, e) => sum + e.finalMoodScore) /
            lastWeekEntries.length
        : 0.0;

    final moodChange = lastWeekAvg > 0 ? thisWeekAvg - lastWeekAvg : 0.0;

    final dayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final dailyData = <DailyMoodData>[];
    int? bestDay;
    double bestScore = -1;

    for (int i = 0; i < 7; i++) {
      final date = weekStart.add(Duration(days: i));
      final dayStart = DateTime(date.year, date.month, date.day);
      final dayEnd = dayStart.add(const Duration(days: 1));

      final dayEntries = thisWeekEntries.where((e) =>
          e.recordedAt.isAfter(dayStart) && e.recordedAt.isBefore(dayEnd));

      final hasEntry = dayEntries.isNotEmpty;
      final score = hasEntry
          ? dayEntries.fold<double>(0, (sum, e) => sum + e.finalMoodScore) /
              dayEntries.length
          : 0.0;

      if (hasEntry && score > bestScore) {
        bestScore = score;
        bestDay = i;
      }

      dailyData.add(DailyMoodData(
        day: dayLabels[i],
        score: score,
        hasEntry: hasEntry,
      ));
    }

    return WeeklyAnalytics(
      averageMood: thisWeekAvg,
      totalEntries: thisWeekEntries.length,
      moodChange: moodChange,
      bestDay: bestDay,
      dailyData: dailyData,
    );
  }

  /// Get mood distribution for a period.
  Future<MoodDistribution> getMoodDistribution(
    Session session,
    String period,
  ) async {
    final profileId = await _getProfileId(session);
    final now = DateTime.now();

    DateTime startDate;
    switch (period) {
      case 'month':
        startDate = now.subtract(const Duration(days: 30));
        break;
      case '3months':
        startDate = now.subtract(const Duration(days: 90));
        break;
      default:
        startDate = now.subtract(const Duration(days: 7));
    }

    final entries = await VoiceEntry.db.find(
      session,
      where: (t) =>
          t.userProfileId.equals(profileId) & (t.recordedAt > startDate),
    );

    int veryPositive = 0;
    int positive = 0;
    int neutral = 0;
    int low = 0;
    int veryLow = 0;

    for (final entry in entries) {
      final score = entry.finalMoodScore;
      if (score >= 0.8) {
        veryPositive++;
      } else if (score >= 0.6) {
        positive++;
      } else if (score >= 0.4) {
        neutral++;
      } else if (score >= 0.2) {
        low++;
      } else {
        veryLow++;
      }
    }

    return MoodDistribution(
      veryPositive: veryPositive,
      positive: positive,
      neutral: neutral,
      low: low,
      veryLow: veryLow,
      total: entries.length,
    );
  }

  /// Get time of day analysis.
  Future<TimeOfDayAnalysis> getTimeOfDayAnalysis(Session session) async {
    final profileId = await _getProfileId(session);
    final monthAgo = DateTime.now().subtract(const Duration(days: 30));

    final entries = await VoiceEntry.db.find(
      session,
      where: (t) =>
          t.userProfileId.equals(profileId) & (t.recordedAt > monthAgo),
    );

    double morningSum = 0, afternoonSum = 0, eveningSum = 0, nightSum = 0;
    int morningCount = 0, afternoonCount = 0, eveningCount = 0, nightCount = 0;

    for (final entry in entries) {
      final hour = entry.recordedAt.hour;
      final score = entry.finalMoodScore;

      if (hour >= 6 && hour < 12) {
        morningSum += score;
        morningCount++;
      } else if (hour >= 12 && hour < 18) {
        afternoonSum += score;
        afternoonCount++;
      } else if (hour >= 18 && hour < 24) {
        eveningSum += score;
        eveningCount++;
      } else {
        nightSum += score;
        nightCount++;
      }
    }

    final morningAvg = morningCount > 0 ? morningSum / morningCount : 0.0;
    final afternoonAvg =
        afternoonCount > 0 ? afternoonSum / afternoonCount : 0.0;
    final eveningAvg = eveningCount > 0 ? eveningSum / eveningCount : 0.0;
    final nightAvg = nightCount > 0 ? nightSum / nightCount : 0.0;

    String bestTimeOfDay = 'morning';
    double bestAvg = morningAvg;
    if (afternoonAvg > bestAvg) {
      bestAvg = afternoonAvg;
      bestTimeOfDay = 'afternoon';
    }
    if (eveningAvg > bestAvg) {
      bestAvg = eveningAvg;
      bestTimeOfDay = 'evening';
    }
    if (nightAvg > bestAvg) {
      bestTimeOfDay = 'night';
    }

    return TimeOfDayAnalysis(
      morningAvg: morningAvg,
      afternoonAvg: afternoonAvg,
      eveningAvg: eveningAvg,
      nightAvg: nightAvg,
      bestTimeOfDay: bestTimeOfDay,
      morningCount: morningCount,
      afternoonCount: afternoonCount,
      eveningCount: eveningCount,
      nightCount: nightCount,
    );
  }

  /// Get detected mood patterns.
  Future<List<MoodPattern>> getPatterns(Session session) async {
    final profileId = await _getProfileId(session);

    return await MoodPattern.db.find(
      session,
      where: (t) => t.userProfileId.equals(profileId),
      orderBy: (t) => t.detectedAt,
      orderDescending: true,
      limit: 10,
    );
  }
}
