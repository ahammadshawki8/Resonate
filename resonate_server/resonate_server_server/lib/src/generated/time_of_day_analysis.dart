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
import 'package:serverpod/serverpod.dart' as _i1;

/// Time of day analysis (DTO).
abstract class TimeOfDayAnalysis
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  TimeOfDayAnalysis._({
    required this.morningAvg,
    required this.afternoonAvg,
    required this.eveningAvg,
    required this.nightAvg,
    required this.bestTimeOfDay,
    required this.morningCount,
    required this.afternoonCount,
    required this.eveningCount,
    required this.nightCount,
  });

  factory TimeOfDayAnalysis({
    required double morningAvg,
    required double afternoonAvg,
    required double eveningAvg,
    required double nightAvg,
    required String bestTimeOfDay,
    required int morningCount,
    required int afternoonCount,
    required int eveningCount,
    required int nightCount,
  }) = _TimeOfDayAnalysisImpl;

  factory TimeOfDayAnalysis.fromJson(Map<String, dynamic> jsonSerialization) {
    return TimeOfDayAnalysis(
      morningAvg: (jsonSerialization['morningAvg'] as num).toDouble(),
      afternoonAvg: (jsonSerialization['afternoonAvg'] as num).toDouble(),
      eveningAvg: (jsonSerialization['eveningAvg'] as num).toDouble(),
      nightAvg: (jsonSerialization['nightAvg'] as num).toDouble(),
      bestTimeOfDay: jsonSerialization['bestTimeOfDay'] as String,
      morningCount: jsonSerialization['morningCount'] as int,
      afternoonCount: jsonSerialization['afternoonCount'] as int,
      eveningCount: jsonSerialization['eveningCount'] as int,
      nightCount: jsonSerialization['nightCount'] as int,
    );
  }

  double morningAvg;

  double afternoonAvg;

  double eveningAvg;

  double nightAvg;

  String bestTimeOfDay;

  int morningCount;

  int afternoonCount;

  int eveningCount;

  int nightCount;

  /// Returns a shallow copy of this [TimeOfDayAnalysis]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TimeOfDayAnalysis copyWith({
    double? morningAvg,
    double? afternoonAvg,
    double? eveningAvg,
    double? nightAvg,
    String? bestTimeOfDay,
    int? morningCount,
    int? afternoonCount,
    int? eveningCount,
    int? nightCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TimeOfDayAnalysis',
      'morningAvg': morningAvg,
      'afternoonAvg': afternoonAvg,
      'eveningAvg': eveningAvg,
      'nightAvg': nightAvg,
      'bestTimeOfDay': bestTimeOfDay,
      'morningCount': morningCount,
      'afternoonCount': afternoonCount,
      'eveningCount': eveningCount,
      'nightCount': nightCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TimeOfDayAnalysis',
      'morningAvg': morningAvg,
      'afternoonAvg': afternoonAvg,
      'eveningAvg': eveningAvg,
      'nightAvg': nightAvg,
      'bestTimeOfDay': bestTimeOfDay,
      'morningCount': morningCount,
      'afternoonCount': afternoonCount,
      'eveningCount': eveningCount,
      'nightCount': nightCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _TimeOfDayAnalysisImpl extends TimeOfDayAnalysis {
  _TimeOfDayAnalysisImpl({
    required double morningAvg,
    required double afternoonAvg,
    required double eveningAvg,
    required double nightAvg,
    required String bestTimeOfDay,
    required int morningCount,
    required int afternoonCount,
    required int eveningCount,
    required int nightCount,
  }) : super._(
         morningAvg: morningAvg,
         afternoonAvg: afternoonAvg,
         eveningAvg: eveningAvg,
         nightAvg: nightAvg,
         bestTimeOfDay: bestTimeOfDay,
         morningCount: morningCount,
         afternoonCount: afternoonCount,
         eveningCount: eveningCount,
         nightCount: nightCount,
       );

  /// Returns a shallow copy of this [TimeOfDayAnalysis]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TimeOfDayAnalysis copyWith({
    double? morningAvg,
    double? afternoonAvg,
    double? eveningAvg,
    double? nightAvg,
    String? bestTimeOfDay,
    int? morningCount,
    int? afternoonCount,
    int? eveningCount,
    int? nightCount,
  }) {
    return TimeOfDayAnalysis(
      morningAvg: morningAvg ?? this.morningAvg,
      afternoonAvg: afternoonAvg ?? this.afternoonAvg,
      eveningAvg: eveningAvg ?? this.eveningAvg,
      nightAvg: nightAvg ?? this.nightAvg,
      bestTimeOfDay: bestTimeOfDay ?? this.bestTimeOfDay,
      morningCount: morningCount ?? this.morningCount,
      afternoonCount: afternoonCount ?? this.afternoonCount,
      eveningCount: eveningCount ?? this.eveningCount,
      nightCount: nightCount ?? this.nightCount,
    );
  }
}
