import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart' hide UserProfile;
import '../generated/protocol.dart';

/// Endpoint for user settings operations.
class SettingsEndpoint extends Endpoint {
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

  /// Get user settings.
  Future<UserSettings> getSettings(Session session) async {
    final profileId = await _getProfileId(session);

    var settings = await UserSettings.db.findFirstRow(
      session,
      where: (t) => t.userProfileId.equals(profileId),
    );

    if (settings == null) {
      settings = UserSettings(
        userProfileId: profileId,
        reminderHour: 9,
        reminderMinute: 0,
        reminderEnabled: true,
        darkMode: false,
        uiLanguage: 'en',
        voiceLanguage: 'en',
        privacyLevel: 'full',
        notificationsEnabled: true,
      );
      settings = await UserSettings.db.insertRow(session, settings);
    }

    return settings;
  }

  /// Update user settings.
  Future<UserSettings> updateSettings(
    Session session,
    UserSettings settings,
  ) async {
    final profileId = await _getProfileId(session);

    final existing = await UserSettings.db.findFirstRow(
      session,
      where: (t) => t.userProfileId.equals(profileId),
    );

    if (existing == null) {
      final newSettings = settings.copyWith(userProfileId: profileId);
      return await UserSettings.db.insertRow(session, newSettings);
    }

    final updated = settings.copyWith(
      id: existing.id,
      userProfileId: profileId,
    );
    return await UserSettings.db.updateRow(session, updated);
  }

  /// Toggle dark mode.
  Future<UserSettings> toggleDarkMode(Session session, bool enabled) async {
    final profileId = await _getProfileId(session);

    final settings = await UserSettings.db.findFirstRow(
      session,
      where: (t) => t.userProfileId.equals(profileId),
    );

    if (settings == null) {
      throw Exception('Settings not found');
    }

    final updated = settings.copyWith(darkMode: enabled);
    return await UserSettings.db.updateRow(session, updated);
  }

  /// Toggle notifications.
  Future<UserSettings> toggleNotifications(
    Session session,
    bool enabled,
  ) async {
    final profileId = await _getProfileId(session);

    final settings = await UserSettings.db.findFirstRow(
      session,
      where: (t) => t.userProfileId.equals(profileId),
    );

    if (settings == null) {
      throw Exception('Settings not found');
    }

    final updated = settings.copyWith(notificationsEnabled: enabled);
    return await UserSettings.db.updateRow(session, updated);
  }
}
