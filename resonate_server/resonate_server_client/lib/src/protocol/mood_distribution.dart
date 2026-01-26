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

/// Mood distribution breakdown (DTO).
abstract class MoodDistribution implements _i1.SerializableModel {
  MoodDistribution._({
    required this.veryPositive,
    required this.positive,
    required this.neutral,
    required this.low,
    required this.veryLow,
    required this.total,
  });

  factory MoodDistribution({
    required int veryPositive,
    required int positive,
    required int neutral,
    required int low,
    required int veryLow,
    required int total,
  }) = _MoodDistributionImpl;

  factory MoodDistribution.fromJson(Map<String, dynamic> jsonSerialization) {
    return MoodDistribution(
      veryPositive: jsonSerialization['veryPositive'] as int,
      positive: jsonSerialization['positive'] as int,
      neutral: jsonSerialization['neutral'] as int,
      low: jsonSerialization['low'] as int,
      veryLow: jsonSerialization['veryLow'] as int,
      total: jsonSerialization['total'] as int,
    );
  }

  int veryPositive;

  int positive;

  int neutral;

  int low;

  int veryLow;

  int total;

  /// Returns a shallow copy of this [MoodDistribution]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MoodDistribution copyWith({
    int? veryPositive,
    int? positive,
    int? neutral,
    int? low,
    int? veryLow,
    int? total,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MoodDistribution',
      'veryPositive': veryPositive,
      'positive': positive,
      'neutral': neutral,
      'low': low,
      'veryLow': veryLow,
      'total': total,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _MoodDistributionImpl extends MoodDistribution {
  _MoodDistributionImpl({
    required int veryPositive,
    required int positive,
    required int neutral,
    required int low,
    required int veryLow,
    required int total,
  }) : super._(
         veryPositive: veryPositive,
         positive: positive,
         neutral: neutral,
         low: low,
         veryLow: veryLow,
         total: total,
       );

  /// Returns a shallow copy of this [MoodDistribution]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MoodDistribution copyWith({
    int? veryPositive,
    int? positive,
    int? neutral,
    int? low,
    int? veryLow,
    int? total,
  }) {
    return MoodDistribution(
      veryPositive: veryPositive ?? this.veryPositive,
      positive: positive ?? this.positive,
      neutral: neutral ?? this.neutral,
      low: low ?? this.low,
      veryLow: veryLow ?? this.veryLow,
      total: total ?? this.total,
    );
  }
}
