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

/// User statistics summary (DTO).
abstract class UserStats implements _i1.SerializableModel {
  UserStats._({
    required this.totalCheckins,
    required this.currentStreak,
    required this.longestStreak,
    required this.averageMood,
    this.mostCommonMood,
    this.mostUsedTag,
    required this.daysSinceStart,
  });

  factory UserStats({
    required int totalCheckins,
    required int currentStreak,
    required int longestStreak,
    required double averageMood,
    String? mostCommonMood,
    String? mostUsedTag,
    required int daysSinceStart,
  }) = _UserStatsImpl;

  factory UserStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserStats(
      totalCheckins: jsonSerialization['totalCheckins'] as int,
      currentStreak: jsonSerialization['currentStreak'] as int,
      longestStreak: jsonSerialization['longestStreak'] as int,
      averageMood: (jsonSerialization['averageMood'] as num).toDouble(),
      mostCommonMood: jsonSerialization['mostCommonMood'] as String?,
      mostUsedTag: jsonSerialization['mostUsedTag'] as String?,
      daysSinceStart: jsonSerialization['daysSinceStart'] as int,
    );
  }

  int totalCheckins;

  int currentStreak;

  int longestStreak;

  double averageMood;

  String? mostCommonMood;

  String? mostUsedTag;

  int daysSinceStart;

  /// Returns a shallow copy of this [UserStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserStats copyWith({
    int? totalCheckins,
    int? currentStreak,
    int? longestStreak,
    double? averageMood,
    String? mostCommonMood,
    String? mostUsedTag,
    int? daysSinceStart,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserStats',
      'totalCheckins': totalCheckins,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'averageMood': averageMood,
      if (mostCommonMood != null) 'mostCommonMood': mostCommonMood,
      if (mostUsedTag != null) 'mostUsedTag': mostUsedTag,
      'daysSinceStart': daysSinceStart,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserStatsImpl extends UserStats {
  _UserStatsImpl({
    required int totalCheckins,
    required int currentStreak,
    required int longestStreak,
    required double averageMood,
    String? mostCommonMood,
    String? mostUsedTag,
    required int daysSinceStart,
  }) : super._(
         totalCheckins: totalCheckins,
         currentStreak: currentStreak,
         longestStreak: longestStreak,
         averageMood: averageMood,
         mostCommonMood: mostCommonMood,
         mostUsedTag: mostUsedTag,
         daysSinceStart: daysSinceStart,
       );

  /// Returns a shallow copy of this [UserStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserStats copyWith({
    int? totalCheckins,
    int? currentStreak,
    int? longestStreak,
    double? averageMood,
    Object? mostCommonMood = _Undefined,
    Object? mostUsedTag = _Undefined,
    int? daysSinceStart,
  }) {
    return UserStats(
      totalCheckins: totalCheckins ?? this.totalCheckins,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      averageMood: averageMood ?? this.averageMood,
      mostCommonMood: mostCommonMood is String?
          ? mostCommonMood
          : this.mostCommonMood,
      mostUsedTag: mostUsedTag is String? ? mostUsedTag : this.mostUsedTag,
      daysSinceStart: daysSinceStart ?? this.daysSinceStart,
    );
  }
}
