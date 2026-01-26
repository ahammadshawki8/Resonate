/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

/// User settings and preferences.
abstract class UserSettings implements _i1.SerializableModel {
  UserSettings._({
    this.id,
    required this.userProfileId,
    required this.reminderHour,
    required this.reminderMinute,
    required this.reminderEnabled,
    required this.darkMode,
    required this.uiLanguage,
    required this.voiceLanguage,
    required this.privacyLevel,
    required this.notificationsEnabled,
  });

  factory UserSettings({
    int? id,
    required int userProfileId,
    required int reminderHour,
    required int reminderMinute,
    required bool reminderEnabled,
    required bool darkMode,
    required String uiLanguage,
    required String voiceLanguage,
    required String privacyLevel,
    required bool notificationsEnabled,
  }) = _UserSettingsImpl;

  factory UserSettings.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserSettings(
      id: jsonSerialization['id'] as int?,
      userProfileId: jsonSerialization['userProfileId'] as int,
      reminderHour: jsonSerialization['reminderHour'] as int,
      reminderMinute: jsonSerialization['reminderMinute'] as int,
      reminderEnabled: jsonSerialization['reminderEnabled'] as bool,
      darkMode: jsonSerialization['darkMode'] as bool,
      uiLanguage: jsonSerialization['uiLanguage'] as String,
      voiceLanguage: jsonSerialization['voiceLanguage'] as String,
      privacyLevel: jsonSerialization['privacyLevel'] as String,
      notificationsEnabled: jsonSerialization['notificationsEnabled'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userProfileId;

  int reminderHour;

  int reminderMinute;

  bool reminderEnabled;

  bool darkMode;

  String uiLanguage;

  String voiceLanguage;

  String privacyLevel;

  bool notificationsEnabled;

  /// Returns a shallow copy of this [UserSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserSettings copyWith({
    int? id,
    int? userProfileId,
    int? reminderHour,
    int? reminderMinute,
    bool? reminderEnabled,
    bool? darkMode,
    String? uiLanguage,
    String? voiceLanguage,
    String? privacyLevel,
    bool? notificationsEnabled,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserSettings',
      if (id != null) 'id': id,
      'userProfileId': userProfileId,
      'reminderHour': reminderHour,
      'reminderMinute': reminderMinute,
      'reminderEnabled': reminderEnabled,
      'darkMode': darkMode,
      'uiLanguage': uiLanguage,
      'voiceLanguage': voiceLanguage,
      'privacyLevel': privacyLevel,
      'notificationsEnabled': notificationsEnabled,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserSettingsImpl extends UserSettings {
  _UserSettingsImpl({
    int? id,
    required int userProfileId,
    required int reminderHour,
    required int reminderMinute,
    required bool reminderEnabled,
    required bool darkMode,
    required String uiLanguage,
    required String voiceLanguage,
    required String privacyLevel,
    required bool notificationsEnabled,
  }) : super._(
         id: id,
         userProfileId: userProfileId,
         reminderHour: reminderHour,
         reminderMinute: reminderMinute,
         reminderEnabled: reminderEnabled,
         darkMode: darkMode,
         uiLanguage: uiLanguage,
         voiceLanguage: voiceLanguage,
         privacyLevel: privacyLevel,
         notificationsEnabled: notificationsEnabled,
       );

  /// Returns a shallow copy of this [UserSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserSettings copyWith({
    Object? id = _Undefined,
    int? userProfileId,
    int? reminderHour,
    int? reminderMinute,
    bool? reminderEnabled,
    bool? darkMode,
    String? uiLanguage,
    String? voiceLanguage,
    String? privacyLevel,
    bool? notificationsEnabled,
  }) {
    return UserSettings(
      id: id is int? ? id : this.id,
      userProfileId: userProfileId ?? this.userProfileId,
      reminderHour: reminderHour ?? this.reminderHour,
      reminderMinute: reminderMinute ?? this.reminderMinute,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      darkMode: darkMode ?? this.darkMode,
      uiLanguage: uiLanguage ?? this.uiLanguage,
      voiceLanguage: voiceLanguage ?? this.voiceLanguage,
      privacyLevel: privacyLevel ?? this.privacyLevel,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}
