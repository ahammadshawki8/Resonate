import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart' hide UserProfile;
import '../generated/protocol.dart';

/// Endpoint for user profile operations.
class UserProfileEndpoint extends Endpoint {
  /// Get the current user's profile. Creates one if it doesn't exist.
  Future<UserProfile> getProfile(Session session) async {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      throw Exception('Authentication required');
    }
    final userId = authInfo.authUserId;

    var profile = await UserProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(userId),
    );

    if (profile == null) {
      // Create new profile with the auth user ID
      // User can update their display name and email later
      profile = UserProfile(
        authUserId: userId,
        displayName: 'User',
        email: '',
        createdAt: DateTime.now(),
        totalCheckins: 0,
        currentStreak: 0,
        longestStreak: 0,
        averageMood: 0.5,
      );
      profile = await UserProfile.db.insertRow(session, profile);

      // Also create default settings
      final settings = UserSettings(
        userProfileId: profile.id!,
        reminderHour: 9,
        reminderMinute: 0,
        reminderEnabled: true,
        darkMode: false,
        uiLanguage: 'en',
        voiceLanguage: 'en',
        privacyLevel: 'full',
        notificationsEnabled: true,
      );
      await UserSettings.db.insertRow(session, settings);
    }

    return profile;
  }

  /// Update the user's profile.
  Future<UserProfile> updateProfile(
    Session session, {
    String? displayName,
    String? email,
    String? avatarUrl,
  }) async {
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

    final updated = profile.copyWith(
      displayName: displayName ?? profile.displayName,
      email: email ?? profile.email,
      avatarUrl: avatarUrl ?? profile.avatarUrl,
    );

    return await UserProfile.db.updateRow(session, updated);
  }

  /// Change the user's password.
  /// Note: This is a placeholder. For production, use Serverpod's built-in password reset flow.
  Future<bool> changePassword(
    Session session, {
    required String oldPassword,
    required String newPassword,
  }) async {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      throw Exception('Authentication required');
    }

    // For now, we'll return a message that password change is not yet implemented
    // In production, you should use Serverpod's email identity provider password reset flow
    session.log('Password change requested but not yet implemented');
    
    // TODO: Implement password change using Serverpod auth
    // This requires accessing the EmailAuth table which is not directly exposed
    // Recommended approach: Use the built-in password reset flow via email
    
    throw Exception('Password change is not yet implemented. Please use the "Forgot Password" feature.');
  }

  /// Get user statistics.
  Future<UserStats> getStats(Session session) async {
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

    // Get all entries to calculate stats
    final entries = await VoiceEntry.db.find(
      session,
      where: (t) => t.userProfileId.equals(profile.id!),
    );

    // Calculate most common mood
    String? mostCommonMood;
    if (entries.isNotEmpty) {
      final moodCounts = <String, int>{};
      for (final entry in entries) {
        moodCounts[entry.moodLabel] = (moodCounts[entry.moodLabel] ?? 0) + 1;
      }
      mostCommonMood =
          moodCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    }

    // Calculate days since start
    final daysSinceStart = entries.isNotEmpty
        ? DateTime.now().difference(entries.last.recordedAt).inDays
        : 0;

    // Get most used tag
    String? mostUsedTag;
    final tags = await Tag.db.find(
      session,
      where: (t) => t.userProfileId.equals(profile.id!),
      orderBy: (t) => t.usageCount,
      orderDescending: true,
      limit: 1,
    );
    if (tags.isNotEmpty) {
      mostUsedTag = tags.first.name;
    }

    return UserStats(
      totalCheckins: profile.totalCheckins,
      currentStreak: profile.currentStreak,
      longestStreak: profile.longestStreak,
      averageMood: profile.averageMood,
      mostCommonMood: mostCommonMood,
      mostUsedTag: mostUsedTag,
      daysSinceStart: daysSinceStart,
    );
  }

  /// Delete the user's account and all data.
  Future<bool> deleteAccount(Session session) async {
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
      return true;
    }

    // Delete all related data
    await VoiceEntry.db
        .deleteWhere(session, where: (t) => t.userProfileId.equals(profile.id!));
    await Insight.db
        .deleteWhere(session, where: (t) => t.userProfileId.equals(profile.id!));
    await Tag.db
        .deleteWhere(session, where: (t) => t.userProfileId.equals(profile.id!));
    await UserSettings.db
        .deleteWhere(session, where: (t) => t.userProfileId.equals(profile.id!));
    await JournalEntry.db
        .deleteWhere(session, where: (t) => t.userProfileId.equals(profile.id!));
    await GratitudeEntry.db
        .deleteWhere(session, where: (t) => t.userProfileId.equals(profile.id!));
    await WellnessGoal.db
        .deleteWhere(session, where: (t) => t.userProfileId.equals(profile.id!));
    await FavoriteContact.db
        .deleteWhere(session, where: (t) => t.userProfileId.equals(profile.id!));
    await MoodPattern.db
        .deleteWhere(session, where: (t) => t.userProfileId.equals(profile.id!));

    // Delete profile
    await UserProfile.db.deleteRow(session, profile);

    return true;
  }
}
