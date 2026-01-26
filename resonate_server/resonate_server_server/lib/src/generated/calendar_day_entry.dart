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

/// Calendar day entry data (DTO).
abstract class CalendarDayEntry
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CalendarDayEntry._({
    required this.entryId,
    required this.moodScore,
    required this.moodLabel,
  });

  factory CalendarDayEntry({
    required int entryId,
    required double moodScore,
    required String moodLabel,
  }) = _CalendarDayEntryImpl;

  factory CalendarDayEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return CalendarDayEntry(
      entryId: jsonSerialization['entryId'] as int,
      moodScore: (jsonSerialization['moodScore'] as num).toDouble(),
      moodLabel: jsonSerialization['moodLabel'] as String,
    );
  }

  int entryId;

  double moodScore;

  String moodLabel;

  /// Returns a shallow copy of this [CalendarDayEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CalendarDayEntry copyWith({
    int? entryId,
    double? moodScore,
    String? moodLabel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CalendarDayEntry',
      'entryId': entryId,
      'moodScore': moodScore,
      'moodLabel': moodLabel,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CalendarDayEntry',
      'entryId': entryId,
      'moodScore': moodScore,
      'moodLabel': moodLabel,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CalendarDayEntryImpl extends CalendarDayEntry {
  _CalendarDayEntryImpl({
    required int entryId,
    required double moodScore,
    required String moodLabel,
  }) : super._(
         entryId: entryId,
         moodScore: moodScore,
         moodLabel: moodLabel,
       );

  /// Returns a shallow copy of this [CalendarDayEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CalendarDayEntry copyWith({
    int? entryId,
    double? moodScore,
    String? moodLabel,
  }) {
    return CalendarDayEntry(
      entryId: entryId ?? this.entryId,
      moodScore: moodScore ?? this.moodScore,
      moodLabel: moodLabel ?? this.moodLabel,
    );
  }
}
