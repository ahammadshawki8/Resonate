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

/// Daily mood data for charts (DTO).
abstract class DailyMoodData implements _i1.SerializableModel {
  DailyMoodData._({
    required this.day,
    required this.score,
    required this.hasEntry,
  });

  factory DailyMoodData({
    required String day,
    required double score,
    required bool hasEntry,
  }) = _DailyMoodDataImpl;

  factory DailyMoodData.fromJson(Map<String, dynamic> jsonSerialization) {
    return DailyMoodData(
      day: jsonSerialization['day'] as String,
      score: (jsonSerialization['score'] as num).toDouble(),
      hasEntry: jsonSerialization['hasEntry'] as bool,
    );
  }

  String day;

  double score;

  bool hasEntry;

  /// Returns a shallow copy of this [DailyMoodData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DailyMoodData copyWith({
    String? day,
    double? score,
    bool? hasEntry,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DailyMoodData',
      'day': day,
      'score': score,
      'hasEntry': hasEntry,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DailyMoodDataImpl extends DailyMoodData {
  _DailyMoodDataImpl({
    required String day,
    required double score,
    required bool hasEntry,
  }) : super._(
         day: day,
         score: score,
         hasEntry: hasEntry,
       );

  /// Returns a shallow copy of this [DailyMoodData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DailyMoodData copyWith({
    String? day,
    double? score,
    bool? hasEntry,
  }) {
    return DailyMoodData(
      day: day ?? this.day,
      score: score ?? this.score,
      hasEntry: hasEntry ?? this.hasEntry,
    );
  }
}
