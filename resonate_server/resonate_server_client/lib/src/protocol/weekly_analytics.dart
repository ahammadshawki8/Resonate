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
import 'daily_mood_data.dart' as _i2;
import 'package:resonate_server_client/src/protocol/protocol.dart' as _i3;

/// Weekly analytics summary (DTO, not stored in DB).
abstract class WeeklyAnalytics implements _i1.SerializableModel {
  WeeklyAnalytics._({
    required this.averageMood,
    required this.totalEntries,
    required this.moodChange,
    this.bestDay,
    required this.dailyData,
  });

  factory WeeklyAnalytics({
    required double averageMood,
    required int totalEntries,
    required double moodChange,
    int? bestDay,
    required List<_i2.DailyMoodData> dailyData,
  }) = _WeeklyAnalyticsImpl;

  factory WeeklyAnalytics.fromJson(Map<String, dynamic> jsonSerialization) {
    return WeeklyAnalytics(
      averageMood: (jsonSerialization['averageMood'] as num).toDouble(),
      totalEntries: jsonSerialization['totalEntries'] as int,
      moodChange: (jsonSerialization['moodChange'] as num).toDouble(),
      bestDay: jsonSerialization['bestDay'] as int?,
      dailyData: _i3.Protocol().deserialize<List<_i2.DailyMoodData>>(
        jsonSerialization['dailyData'],
      ),
    );
  }

  double averageMood;

  int totalEntries;

  double moodChange;

  int? bestDay;

  List<_i2.DailyMoodData> dailyData;

  /// Returns a shallow copy of this [WeeklyAnalytics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WeeklyAnalytics copyWith({
    double? averageMood,
    int? totalEntries,
    double? moodChange,
    int? bestDay,
    List<_i2.DailyMoodData>? dailyData,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WeeklyAnalytics',
      'averageMood': averageMood,
      'totalEntries': totalEntries,
      'moodChange': moodChange,
      if (bestDay != null) 'bestDay': bestDay,
      'dailyData': dailyData.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WeeklyAnalyticsImpl extends WeeklyAnalytics {
  _WeeklyAnalyticsImpl({
    required double averageMood,
    required int totalEntries,
    required double moodChange,
    int? bestDay,
    required List<_i2.DailyMoodData> dailyData,
  }) : super._(
         averageMood: averageMood,
         totalEntries: totalEntries,
         moodChange: moodChange,
         bestDay: bestDay,
         dailyData: dailyData,
       );

  /// Returns a shallow copy of this [WeeklyAnalytics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WeeklyAnalytics copyWith({
    double? averageMood,
    int? totalEntries,
    double? moodChange,
    Object? bestDay = _Undefined,
    List<_i2.DailyMoodData>? dailyData,
  }) {
    return WeeklyAnalytics(
      averageMood: averageMood ?? this.averageMood,
      totalEntries: totalEntries ?? this.totalEntries,
      moodChange: moodChange ?? this.moodChange,
      bestDay: bestDay is int? ? bestDay : this.bestDay,
      dailyData:
          dailyData ?? this.dailyData.map((e0) => e0.copyWith()).toList(),
    );
  }
}
