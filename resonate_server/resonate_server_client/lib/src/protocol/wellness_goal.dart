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

/// Wellness goal for user's wellness journey.
abstract class WellnessGoal implements _i1.SerializableModel {
  WellnessGoal._({
    this.id,
    required this.userProfileId,
    required this.createdAt,
    required this.title,
    required this.emoji,
    required this.isCompleted,
    this.completedAt,
  });

  factory WellnessGoal({
    int? id,
    required int userProfileId,
    required DateTime createdAt,
    required String title,
    required String emoji,
    required bool isCompleted,
    DateTime? completedAt,
  }) = _WellnessGoalImpl;

  factory WellnessGoal.fromJson(Map<String, dynamic> jsonSerialization) {
    return WellnessGoal(
      id: jsonSerialization['id'] as int?,
      userProfileId: jsonSerialization['userProfileId'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      title: jsonSerialization['title'] as String,
      emoji: jsonSerialization['emoji'] as String,
      isCompleted: jsonSerialization['isCompleted'] as bool,
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userProfileId;

  DateTime createdAt;

  String title;

  String emoji;

  bool isCompleted;

  DateTime? completedAt;

  /// Returns a shallow copy of this [WellnessGoal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WellnessGoal copyWith({
    int? id,
    int? userProfileId,
    DateTime? createdAt,
    String? title,
    String? emoji,
    bool? isCompleted,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WellnessGoal',
      if (id != null) 'id': id,
      'userProfileId': userProfileId,
      'createdAt': createdAt.toJson(),
      'title': title,
      'emoji': emoji,
      'isCompleted': isCompleted,
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WellnessGoalImpl extends WellnessGoal {
  _WellnessGoalImpl({
    int? id,
    required int userProfileId,
    required DateTime createdAt,
    required String title,
    required String emoji,
    required bool isCompleted,
    DateTime? completedAt,
  }) : super._(
         id: id,
         userProfileId: userProfileId,
         createdAt: createdAt,
         title: title,
         emoji: emoji,
         isCompleted: isCompleted,
         completedAt: completedAt,
       );

  /// Returns a shallow copy of this [WellnessGoal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WellnessGoal copyWith({
    Object? id = _Undefined,
    int? userProfileId,
    DateTime? createdAt,
    String? title,
    String? emoji,
    bool? isCompleted,
    Object? completedAt = _Undefined,
  }) {
    return WellnessGoal(
      id: id is int? ? id : this.id,
      userProfileId: userProfileId ?? this.userProfileId,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      emoji: emoji ?? this.emoji,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
    );
  }
}
