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

/// User profile information (separate from auth user).
abstract class UserProfile implements _i1.SerializableModel {
  UserProfile._({
    this.id,
    required this.authUserId,
    required this.displayName,
    required this.email,
    this.avatarUrl,
    required this.createdAt,
    this.lastLoginAt,
    required this.totalCheckins,
    required this.currentStreak,
    required this.longestStreak,
    required this.averageMood,
  });

  factory UserProfile({
    int? id,
    required _i1.UuidValue authUserId,
    required String displayName,
    required String email,
    String? avatarUrl,
    required DateTime createdAt,
    DateTime? lastLoginAt,
    required int totalCheckins,
    required int currentStreak,
    required int longestStreak,
    required double averageMood,
  }) = _UserProfileImpl;

  factory UserProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserProfile(
      id: jsonSerialization['id'] as int?,
      authUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      displayName: jsonSerialization['displayName'] as String,
      email: jsonSerialization['email'] as String,
      avatarUrl: jsonSerialization['avatarUrl'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      lastLoginAt: jsonSerialization['lastLoginAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastLoginAt'],
            ),
      totalCheckins: jsonSerialization['totalCheckins'] as int,
      currentStreak: jsonSerialization['currentStreak'] as int,
      longestStreak: jsonSerialization['longestStreak'] as int,
      averageMood: (jsonSerialization['averageMood'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.UuidValue authUserId;

  String displayName;

  String email;

  String? avatarUrl;

  DateTime createdAt;

  DateTime? lastLoginAt;

  int totalCheckins;

  int currentStreak;

  int longestStreak;

  double averageMood;

  /// Returns a shallow copy of this [UserProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserProfile copyWith({
    int? id,
    _i1.UuidValue? authUserId,
    String? displayName,
    String? email,
    String? avatarUrl,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    int? totalCheckins,
    int? currentStreak,
    int? longestStreak,
    double? averageMood,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'displayName': displayName,
      'email': email,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      'createdAt': createdAt.toJson(),
      if (lastLoginAt != null) 'lastLoginAt': lastLoginAt?.toJson(),
      'totalCheckins': totalCheckins,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'averageMood': averageMood,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserProfileImpl extends UserProfile {
  _UserProfileImpl({
    int? id,
    required _i1.UuidValue authUserId,
    required String displayName,
    required String email,
    String? avatarUrl,
    required DateTime createdAt,
    DateTime? lastLoginAt,
    required int totalCheckins,
    required int currentStreak,
    required int longestStreak,
    required double averageMood,
  }) : super._(
         id: id,
         authUserId: authUserId,
         displayName: displayName,
         email: email,
         avatarUrl: avatarUrl,
         createdAt: createdAt,
         lastLoginAt: lastLoginAt,
         totalCheckins: totalCheckins,
         currentStreak: currentStreak,
         longestStreak: longestStreak,
         averageMood: averageMood,
       );

  /// Returns a shallow copy of this [UserProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserProfile copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? authUserId,
    String? displayName,
    String? email,
    Object? avatarUrl = _Undefined,
    DateTime? createdAt,
    Object? lastLoginAt = _Undefined,
    int? totalCheckins,
    int? currentStreak,
    int? longestStreak,
    double? averageMood,
  }) {
    return UserProfile(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      avatarUrl: avatarUrl is String? ? avatarUrl : this.avatarUrl,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt is DateTime? ? lastLoginAt : this.lastLoginAt,
      totalCheckins: totalCheckins ?? this.totalCheckins,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      averageMood: averageMood ?? this.averageMood,
    );
  }
}
