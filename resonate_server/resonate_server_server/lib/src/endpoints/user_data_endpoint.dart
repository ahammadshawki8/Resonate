import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart' hide UserProfile;
import '../generated/protocol.dart';

/// Endpoint for user data operations (export, delete, etc.)
class UserDataEndpoint extends Endpoint {
  /// Helper to get user profile ID
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

  /// Export all user data as a JSON string
  Future<String> exportAllData(Session session) async {
    try {
      final profileId = await _getProfileId(session);
      
      session.log('Exporting all data for user profile: $profileId');

      // Get user profile
      final profile = await UserProfile.db.findById(session, profileId);

      // Get all voice entries
      final voiceEntries = await VoiceEntry.db.find(
        session,
        where: (t) => t.userProfileId.equals(profileId),
        orderBy: (t) => t.recordedAt,
        orderDescending: true,
      );

      // Get all insights
      final insights = await Insight.db.find(
        session,
        where: (t) => t.userProfileId.equals(profileId),
        orderBy: (t) => t.generatedAt,
        orderDescending: true,
      );

      // Get all journals
      final journals = await JournalEntry.db.find(
        session,
        where: (t) => t.userProfileId.equals(profileId),
      );

      // Get all gratitudes
      final gratitudes = await GratitudeEntry.db.find(
        session,
        where: (t) => t.userProfileId.equals(profileId),
      );

      // Get all goals
      final goals = await WellnessGoal.db.find(
        session,
        where: (t) => t.userProfileId.equals(profileId),
      );

      // Get all contacts
      final contacts = await FavoriteContact.db.find(
        session,
        where: (t) => t.userProfileId.equals(profileId),
      );

      session.log('Successfully exported data for user profile: $profileId');

      // Build structured data map
      final exportMap = {
        'export_date': DateTime.now().toIso8601String(),
        'app_version': '1.0.0',
        'user': {
          'id': profile?.id,
          'email': profile?.email,
          'display_name': profile?.displayName,
          'created_at': profile?.createdAt.toIso8601String(),
          'total_checkins': profile?.totalCheckins,
          'current_streak': profile?.currentStreak,
          'average_mood': profile?.averageMood,
        },
        'voice_entries': voiceEntries.map((e) => {
          'id': e.id,
          'recorded_at': e.recordedAt.toIso8601String(),
          'language': e.language,
          'duration_seconds': e.durationSeconds,
          'transcript': e.transcript,
          'emotion_keywords': e.emotionKeywords,
          'sentiment_score': e.sentimentScore,
          'detected_emotions': e.detectedEmotions,
          'topic_context': e.topicContext,
          'acoustic_mood_score': e.acousticMoodScore,
          'semantic_mood_score': e.semanticMoodScore,
          'final_mood_score': e.finalMoodScore,
          'mood_label': e.moodLabel,
          'confidence': e.confidence,
          'note': e.note,
          'privacy_level': e.privacyLevel,
        }).toList(),
        'insights': insights.map((i) => {
          'id': i.id,
          'generated_at': i.generatedAt.toIso8601String(),
          'insight_type': i.insightType,
          'insight_text': i.insightText,
          'is_read': i.isRead,
        }).toList(),
        'journals': journals.map((j) => {
          'id': j.id,
          'content': j.content,
          'prompt': j.prompt,
          'mood_at_time': j.moodAtTime,
        }).toList(),
        'gratitudes': gratitudes.map((g) => {
          'id': g.id,
          'items': g.items,
        }).toList(),
        'goals': goals.map((g) => {
          'id': g.id,
          'title': g.title,
          'emoji': g.emoji,
          'is_completed': g.isCompleted,
          'completed_at': g.completedAt?.toIso8601String(),
        }).toList(),
        'contacts': contacts.map((c) => {
          'id': c.id,
          'name': c.name,
          'emoji': c.emoji,
          'type': c.type,
          'phone': c.phone,
        }).toList(),
      };

      // Convert to JSON string
      return jsonEncode(exportMap);
    } catch (e) {
      session.log('Error exporting user data: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Delete all user data from the database
  /// This includes: voice entries, insights, journals, gratitudes, goals, contacts
  Future<bool> deleteAllData(Session session) async {
    try {
      final profileId = await _getProfileId(session);
      
      session.log('Deleting all data for user profile: $profileId');

      // Delete voice entries
      await VoiceEntry.db.deleteWhere(
        session,
        where: (t) => t.userProfileId.equals(profileId),
      );
      session.log('Deleted voice entries');

      // Delete insights
      await Insight.db.deleteWhere(
        session,
        where: (t) => t.userProfileId.equals(profileId),
      );
      session.log('Deleted insights');

      // Delete journals
      await JournalEntry.db.deleteWhere(
        session,
        where: (t) => t.userProfileId.equals(profileId),
      );
      session.log('Deleted journal entries');

      // Delete gratitudes
      await GratitudeEntry.db.deleteWhere(
        session,
        where: (t) => t.userProfileId.equals(profileId),
      );
      session.log('Deleted gratitude entries');

      // Delete goals
      await WellnessGoal.db.deleteWhere(
        session,
        where: (t) => t.userProfileId.equals(profileId),
      );
      session.log('Deleted wellness goals');

      // Delete contacts
      await FavoriteContact.db.deleteWhere(
        session,
        where: (t) => t.userProfileId.equals(profileId),
      );
      session.log('Deleted favorite contacts');

      // Reset user profile stats
      final profile = await UserProfile.db.findById(session, profileId);
      if (profile != null) {
        profile.totalCheckins = 0;
        profile.currentStreak = 0;
        profile.averageMood = 0.0;
        await UserProfile.db.updateRow(session, profile);
        session.log('Reset user profile stats');
      }

      session.log('Successfully deleted all data for user profile: $profileId');
      return true;
    } catch (e) {
      session.log('Error deleting user data: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Get count of user data (for verification)
  Future<Map<String, int>> getDataCounts(Session session) async {
    try {
      final profileId = await _getProfileId(session);

      final voiceCount = await VoiceEntry.db.count(
        session,
        where: (t) => t.userProfileId.equals(profileId),
      );

      final insightCount = await Insight.db.count(
        session,
        where: (t) => t.userProfileId.equals(profileId),
      );

      final journalCount = await JournalEntry.db.count(
        session,
        where: (t) => t.userProfileId.equals(profileId),
      );

      final gratitudeCount = await GratitudeEntry.db.count(
        session,
        where: (t) => t.userProfileId.equals(profileId),
      );

      final goalCount = await WellnessGoal.db.count(
        session,
        where: (t) => t.userProfileId.equals(profileId),
      );

      final contactCount = await FavoriteContact.db.count(
        session,
        where: (t) => t.userProfileId.equals(profileId),
      );

      return {
        'voice_entries': voiceCount,
        'insights': insightCount,
        'journals': journalCount,
        'gratitudes': gratitudeCount,
        'goals': goalCount,
        'contacts': contactCount,
      };
    } catch (e) {
      session.log('Error getting data counts: $e', level: LogLevel.error);
      rethrow;
    }
  }
}
