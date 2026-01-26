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
import 'calendar_day_entry.dart' as _i2;
import 'package:resonate_server_client/src/protocol/protocol.dart' as _i3;

/// Calendar month data (DTO).
abstract class CalendarMonth implements _i1.SerializableModel {
  CalendarMonth._({
    required this.year,
    required this.month,
    required this.entries,
  });

  factory CalendarMonth({
    required int year,
    required int month,
    required Map<int, _i2.CalendarDayEntry> entries,
  }) = _CalendarMonthImpl;

  factory CalendarMonth.fromJson(Map<String, dynamic> jsonSerialization) {
    return CalendarMonth(
      year: jsonSerialization['year'] as int,
      month: jsonSerialization['month'] as int,
      entries: _i3.Protocol().deserialize<Map<int, _i2.CalendarDayEntry>>(
        jsonSerialization['entries'],
      ),
    );
  }

  int year;

  int month;

  Map<int, _i2.CalendarDayEntry> entries;

  /// Returns a shallow copy of this [CalendarMonth]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CalendarMonth copyWith({
    int? year,
    int? month,
    Map<int, _i2.CalendarDayEntry>? entries,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CalendarMonth',
      'year': year,
      'month': month,
      'entries': entries.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CalendarMonthImpl extends CalendarMonth {
  _CalendarMonthImpl({
    required int year,
    required int month,
    required Map<int, _i2.CalendarDayEntry> entries,
  }) : super._(
         year: year,
         month: month,
         entries: entries,
       );

  /// Returns a shallow copy of this [CalendarMonth]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CalendarMonth copyWith({
    int? year,
    int? month,
    Map<int, _i2.CalendarDayEntry>? entries,
  }) {
    return CalendarMonth(
      year: year ?? this.year,
      month: month ?? this.month,
      entries:
          entries ??
          this.entries.map(
            (
              key0,
              value0,
            ) => MapEntry(
              key0,
              value0.copyWith(),
            ),
          ),
    );
  }
}
