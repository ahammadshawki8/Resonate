import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart' hide UserProfile;
import '../generated/protocol.dart';

/// Endpoint for insights operations.
class InsightEndpoint extends Endpoint {
  static const String _pythonServiceUrl = 'http://localhost:8001';

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

  /// Create a custom insight (e.g., from AI generation).
  Future<Insight> createInsight(
    Session session, {
    required String insightText,
    required String insightType,
  }) async {
    final profileId = await _getProfileId(session);

    final insight = Insight(
      userProfileId: profileId,
      insightText: insightText,
      insightType: insightType,
      generatedAt: DateTime.now(),
      isRead: false,
    );

    return await Insight.db.insertRow(session, insight);
  }

  /// Generate AI-powered insight using Python service.
  Future<Insight> generateAIInsight(Session session) async {
    final profileId = await _getProfileId(session);

    try {
      // Get recent entries (last 10)
      final entries = await VoiceEntry.db.find(
        session,
        where: (t) => t.userProfileId.equals(profileId),
        orderBy: (t) => t.recordedAt,
        orderDescending: true,
        limit: 10,
      );

      if (entries.isEmpty) {
        // Return a welcome insight for first-time users
        return await createInsight(
          session,
          insightText: "🎉 Welcome to Resonate! Start your wellness journey by recording your first voice check-in. We'll analyze your emotions and provide personalized insights.",
          insightType: 'tip',
        );
      }

      // Prepare entry data for Python service
      final entryData = entries.map((e) => {
        'final_mood_score': e.finalMoodScore,
        'detected_emotions': e.detectedEmotions,
        'transcript': e.transcript ?? '',
        'recorded_at': e.recordedAt.toIso8601String(),
      }).toList();

      session.log('Calling Python AI service for insight generation...');

      // Call Python service
      final response = await http.post(
        Uri.parse('$_pythonServiceUrl/insights/generate'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'entries': entryData}),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Python service timeout');
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        
        session.log('AI insight generated successfully: ${data['insight_type']}');

        // Create and save insight
        return await createInsight(
          session,
          insightText: data['insight_text'] as String,
          insightType: data['insight_type'] as String,
        );
      } else {
        session.log('Python service error: ${response.statusCode}', level: LogLevel.warning);
        throw Exception('Python service returned ${response.statusCode}');
      }
    } catch (e) {
      session.log('Error generating AI insight: $e', level: LogLevel.error);
      
      // Fallback to simple insight
      final entryCount = await VoiceEntry.db.count(
        session,
        where: (t) => t.userProfileId.equals(profileId),
      );

      String fallbackText;
      String fallbackType;

      if (entryCount == 1) {
        fallbackText = "🎉 Great start! You've completed your first voice check-in. Consistency is key to understanding your emotional patterns.";
        fallbackType = 'achievement';
      } else if (entryCount < 5) {
        fallbackText = "🔥 You're building momentum with $entryCount check-ins! Keep going to unlock deeper insights.";
        fallbackType = 'achievement';
      } else {
        fallbackText = "📊 You've completed $entryCount check-ins. Keep checking in regularly to track your emotional wellness journey!";
        fallbackType = 'weekly_summary';
      }

      return await createInsight(
        session,
        insightText: fallbackText,
        insightType: fallbackType,
      );
    }
  }
}
