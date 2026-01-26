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

/// Detected mood pattern over time.
abstract class MoodPattern implements _i1.SerializableModel {
  MoodPattern._({
    this.id,
    required this.userProfileId,
    required this.patternType,
    required this.description,
    required this.confidence,
    required this.detectedAt,
  });

  factory MoodPattern({
    int? id,
    required int userProfileId,
    required String patternType,
    required String description,
    required double confidence,
    required DateTime detectedAt,
  }) = _MoodPatternImpl;

  factory MoodPattern.fromJson(Map<String, dynamic> jsonSerialization) {
    return MoodPattern(
      id: jsonSerialization['id'] as int?,
      userProfileId: jsonSerialization['userProfileId'] as int,
      patternType: jsonSerialization['patternType'] as String,
      description: jsonSerialization['description'] as String,
      confidence: (jsonSerialization['confidence'] as num).toDouble(),
      detectedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['detectedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userProfileId;

  String patternType;

  String description;

  double confidence;

  DateTime detectedAt;

  /// Returns a shallow copy of this [MoodPattern]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MoodPattern copyWith({
    int? id,
    int? userProfileId,
    String? patternType,
    String? description,
    double? confidence,
    DateTime? detectedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MoodPattern',
      if (id != null) 'id': id,
      'userProfileId': userProfileId,
      'patternType': patternType,
      'description': description,
      'confidence': confidence,
      'detectedAt': detectedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MoodPatternImpl extends MoodPattern {
  _MoodPatternImpl({
    int? id,
    required int userProfileId,
    required String patternType,
    required String description,
    required double confidence,
    required DateTime detectedAt,
  }) : super._(
         id: id,
         userProfileId: userProfileId,
         patternType: patternType,
         description: description,
         confidence: confidence,
         detectedAt: detectedAt,
       );

  /// Returns a shallow copy of this [MoodPattern]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MoodPattern copyWith({
    Object? id = _Undefined,
    int? userProfileId,
    String? patternType,
    String? description,
    double? confidence,
    DateTime? detectedAt,
  }) {
    return MoodPattern(
      id: id is int? ? id : this.id,
      userProfileId: userProfileId ?? this.userProfileId,
      patternType: patternType ?? this.patternType,
      description: description ?? this.description,
      confidence: confidence ?? this.confidence,
      detectedAt: detectedAt ?? this.detectedAt,
    );
  }
}
