import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart' hide UserProfile;
import '../generated/protocol.dart';

/// Endpoint for insights operations.
class InsightEndpoint extends Endpoint {
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

  /// Get all insights for the user.
  Future<List<Insight>> getInsights(Session session, {int? limit}) async {
    final profileId = await _getProfileId(session);

    return await Insight.db.find(
      session,
      where: (t) => t.userProfileId.equals(profileId),
      orderBy: (t) => t.generatedAt,
      orderDescending: true,
      limit: limit,
    );
  }

  /// Get unread insights count.
  Future<int> getUnreadCount(Session session) async {
    final profileId = await _getProfileId(session);

    final insights = await Insight.db.find(
      session,
      where: (t) => t.userProfileId.equals(profileId) & t.isRead.equals(false),
    );

    return insights.length;
  }

  /// Mark an insight as read.
  Future<Insight> markAsRead(Session session, int id) async {
    final profileId = await _getProfileId(session);

    final insight = await Insight.db.findById(session, id);
    if (insight == null || insight.userProfileId != profileId) {
      throw Exception('Insight not found');
    }

    final updated = insight.copyWith(isRead: true);
    return await Insight.db.updateRow(session, updated);
  }

  /// Generate a new insight based on recent entries.
  Future<Insight> generateInsight(Session session) async {
    final profileId = await _getProfileId(session);

    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    final entries = await VoiceEntry.db.find(
      session,
      where: (t) =>
          t.userProfileId.equals(profileId) & (t.recordedAt > weekAgo),
      orderBy: (t) => t.recordedAt,
      orderDescending: true,
    );

    String insightText;
    String insightType;

    if (entries.isEmpty) {
      insightText =
          "Start your wellness journey by recording your first voice check-in!";
      insightType = 'tip';
    } else {
      final avgMood =
          entries.fold<double>(0, (sum, e) => sum + e.finalMoodScore) /
              entries.length;

      if (avgMood >= 0.7) {
        insightText =
            "Great week! Your average mood has been positive. Keep it up!";
        insightType = 'weekly_summary';
      } else if (avgMood >= 0.5) {
        insightText =
            "You've been maintaining a balanced mood this week. Consider trying a breathing exercise!";
        insightType = 'tip';
      } else {
        insightText =
            "I noticed you've been having a challenging week. Consider reaching out to someone you trust.";
        insightType = 'pattern_alert';
      }
    }

    final insight = Insight(
      userProfileId: profileId,
      insightText: insightText,
      insightType: insightType,
      generatedAt: DateTime.now(),
      isRead: false,
    );

    return await Insight.db.insertRow(session, insight);
  }
}
