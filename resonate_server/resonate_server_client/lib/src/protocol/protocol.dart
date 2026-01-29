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
import 'analysis_result.dart' as _i2;
import 'calendar_day_entry.dart' as _i3;
import 'calendar_month.dart' as _i4;
import 'contact.dart' as _i5;
import 'daily_mood_data.dart' as _i6;
import 'entry_tag.dart' as _i7;
import 'favorite_contact.dart' as _i8;
import 'goal.dart' as _i9;
import 'gratitude_entry.dart' as _i10;
import 'greetings/greeting.dart' as _i11;
import 'insight.dart' as _i12;
import 'journal_entry.dart' as _i13;
import 'mood_distribution.dart' as _i14;
import 'mood_pattern.dart' as _i15;
import 'tag.dart' as _i16;
import 'time_of_day_analysis.dart' as _i17;
import 'user_profile.dart' as _i18;
import 'user_settings.dart' as _i19;
import 'user_stats.dart' as _i20;
import 'voice_entry.dart' as _i21;
import 'voice_entry_with_tags.dart' as _i22;
import 'weekly_analytics.dart' as _i23;
import 'wellness_goal.dart' as _i24;
import 'package:resonate_server_client/src/protocol/mood_pattern.dart' as _i25;
import 'package:resonate_server_client/src/protocol/insight.dart' as _i26;
import 'package:resonate_server_client/src/protocol/tag.dart' as _i27;
import 'package:resonate_server_client/src/protocol/voice_entry_with_tags.dart'
    as _i28;
import 'package:resonate_server_client/src/protocol/journal_entry.dart' as _i29;
import 'package:resonate_server_client/src/protocol/gratitude_entry.dart'
    as _i30;
import 'package:resonate_server_client/src/protocol/wellness_goal.dart' as _i31;
import 'package:resonate_server_client/src/protocol/favorite_contact.dart'
    as _i32;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i33;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i34;
export 'analysis_result.dart';
export 'calendar_day_entry.dart';
export 'calendar_month.dart';
export 'contact.dart';
export 'daily_mood_data.dart';
export 'entry_tag.dart';
export 'favorite_contact.dart';
export 'goal.dart';
export 'gratitude_entry.dart';
export 'greetings/greeting.dart';
export 'insight.dart';
export 'journal_entry.dart';
export 'mood_distribution.dart';
export 'mood_pattern.dart';
export 'tag.dart';
export 'time_of_day_analysis.dart';
export 'user_profile.dart';
export 'user_settings.dart';
export 'user_stats.dart';
export 'voice_entry.dart';
export 'voice_entry_with_tags.dart';
export 'weekly_analytics.dart';
export 'wellness_goal.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.AnalysisResult) {
      return _i2.AnalysisResult.fromJson(data) as T;
    }
    if (t == _i3.CalendarDayEntry) {
      return _i3.CalendarDayEntry.fromJson(data) as T;
    }
    if (t == _i4.CalendarMonth) {
      return _i4.CalendarMonth.fromJson(data) as T;
    }
    if (t == _i5.Contact) {
      return _i5.Contact.fromJson(data) as T;
    }
    if (t == _i6.DailyMoodData) {
      return _i6.DailyMoodData.fromJson(data) as T;
    }
    if (t == _i7.EntryTag) {
      return _i7.EntryTag.fromJson(data) as T;
    }
    if (t == _i8.FavoriteContact) {
      return _i8.FavoriteContact.fromJson(data) as T;
    }
    if (t == _i9.Goal) {
      return _i9.Goal.fromJson(data) as T;
    }
    if (t == _i10.GratitudeEntry) {
      return _i10.GratitudeEntry.fromJson(data) as T;
    }
    if (t == _i11.Greeting) {
      return _i11.Greeting.fromJson(data) as T;
    }
    if (t == _i12.Insight) {
      return _i12.Insight.fromJson(data) as T;
    }
    if (t == _i13.JournalEntry) {
      return _i13.JournalEntry.fromJson(data) as T;
    }
    if (t == _i14.MoodDistribution) {
      return _i14.MoodDistribution.fromJson(data) as T;
    }
    if (t == _i15.MoodPattern) {
      return _i15.MoodPattern.fromJson(data) as T;
    }
    if (t == _i16.Tag) {
      return _i16.Tag.fromJson(data) as T;
    }
    if (t == _i17.TimeOfDayAnalysis) {
      return _i17.TimeOfDayAnalysis.fromJson(data) as T;
    }
    if (t == _i18.UserProfile) {
      return _i18.UserProfile.fromJson(data) as T;
    }
    if (t == _i19.UserSettings) {
      return _i19.UserSettings.fromJson(data) as T;
    }
    if (t == _i20.UserStats) {
      return _i20.UserStats.fromJson(data) as T;
    }
    if (t == _i21.VoiceEntry) {
      return _i21.VoiceEntry.fromJson(data) as T;
    }
    if (t == _i22.VoiceEntryWithTags) {
      return _i22.VoiceEntryWithTags.fromJson(data) as T;
    }
    if (t == _i23.WeeklyAnalytics) {
      return _i23.WeeklyAnalytics.fromJson(data) as T;
    }
    if (t == _i24.WellnessGoal) {
      return _i24.WellnessGoal.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AnalysisResult?>()) {
      return (data != null ? _i2.AnalysisResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.CalendarDayEntry?>()) {
      return (data != null ? _i3.CalendarDayEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.CalendarMonth?>()) {
      return (data != null ? _i4.CalendarMonth.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Contact?>()) {
      return (data != null ? _i5.Contact.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.DailyMoodData?>()) {
      return (data != null ? _i6.DailyMoodData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.EntryTag?>()) {
      return (data != null ? _i7.EntryTag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.FavoriteContact?>()) {
      return (data != null ? _i8.FavoriteContact.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Goal?>()) {
      return (data != null ? _i9.Goal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.GratitudeEntry?>()) {
      return (data != null ? _i10.GratitudeEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.Greeting?>()) {
      return (data != null ? _i11.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.Insight?>()) {
      return (data != null ? _i12.Insight.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.JournalEntry?>()) {
      return (data != null ? _i13.JournalEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.MoodDistribution?>()) {
      return (data != null ? _i14.MoodDistribution.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.MoodPattern?>()) {
      return (data != null ? _i15.MoodPattern.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.Tag?>()) {
      return (data != null ? _i16.Tag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.TimeOfDayAnalysis?>()) {
      return (data != null ? _i17.TimeOfDayAnalysis.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.UserProfile?>()) {
      return (data != null ? _i18.UserProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.UserSettings?>()) {
      return (data != null ? _i19.UserSettings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.UserStats?>()) {
      return (data != null ? _i20.UserStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.VoiceEntry?>()) {
      return (data != null ? _i21.VoiceEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.VoiceEntryWithTags?>()) {
      return (data != null ? _i22.VoiceEntryWithTags.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.WeeklyAnalytics?>()) {
      return (data != null ? _i23.WeeklyAnalytics.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.WellnessGoal?>()) {
      return (data != null ? _i24.WellnessGoal.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == Map<int, _i3.CalendarDayEntry>) {
      return Map.fromEntries(
            (data as List).map(
              (e) => MapEntry(
                deserialize<int>(e['k']),
                deserialize<_i3.CalendarDayEntry>(e['v']),
              ),
            ),
          )
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i16.Tag>) {
      return (data as List).map((e) => deserialize<_i16.Tag>(e)).toList() as T;
    }
    if (t == List<_i6.DailyMoodData>) {
      return (data as List)
              .map((e) => deserialize<_i6.DailyMoodData>(e))
              .toList()
          as T;
    }
    if (t == List<_i25.MoodPattern>) {
      return (data as List)
              .map((e) => deserialize<_i25.MoodPattern>(e))
              .toList()
          as T;
    }
    if (t == List<_i26.Insight>) {
      return (data as List).map((e) => deserialize<_i26.Insight>(e)).toList()
          as T;
    }
    if (t == List<_i27.Tag>) {
      return (data as List).map((e) => deserialize<_i27.Tag>(e)).toList() as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)),
          )
          as T;
    }
    if (t == List<_i28.VoiceEntryWithTags>) {
      return (data as List)
              .map((e) => deserialize<_i28.VoiceEntryWithTags>(e))
              .toList()
          as T;
    }
    if (t == List<_i29.JournalEntry>) {
      return (data as List)
              .map((e) => deserialize<_i29.JournalEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i30.GratitudeEntry>) {
      return (data as List)
              .map((e) => deserialize<_i30.GratitudeEntry>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i31.WellnessGoal>) {
      return (data as List)
              .map((e) => deserialize<_i31.WellnessGoal>(e))
              .toList()
          as T;
    }
    if (t == List<_i32.FavoriteContact>) {
      return (data as List)
              .map((e) => deserialize<_i32.FavoriteContact>(e))
              .toList()
          as T;
    }
    try {
      return _i33.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i34.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AnalysisResult => 'AnalysisResult',
      _i3.CalendarDayEntry => 'CalendarDayEntry',
      _i4.CalendarMonth => 'CalendarMonth',
      _i5.Contact => 'Contact',
      _i6.DailyMoodData => 'DailyMoodData',
      _i7.EntryTag => 'EntryTag',
      _i8.FavoriteContact => 'FavoriteContact',
      _i9.Goal => 'Goal',
      _i10.GratitudeEntry => 'GratitudeEntry',
      _i11.Greeting => 'Greeting',
      _i12.Insight => 'Insight',
      _i13.JournalEntry => 'JournalEntry',
      _i14.MoodDistribution => 'MoodDistribution',
      _i15.MoodPattern => 'MoodPattern',
      _i16.Tag => 'Tag',
      _i17.TimeOfDayAnalysis => 'TimeOfDayAnalysis',
      _i18.UserProfile => 'UserProfile',
      _i19.UserSettings => 'UserSettings',
      _i20.UserStats => 'UserStats',
      _i21.VoiceEntry => 'VoiceEntry',
      _i22.VoiceEntryWithTags => 'VoiceEntryWithTags',
      _i23.WeeklyAnalytics => 'WeeklyAnalytics',
      _i24.WellnessGoal => 'WellnessGoal',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'resonate_server.',
        '',
      );
    }

    switch (data) {
      case _i2.AnalysisResult():
        return 'AnalysisResult';
      case _i3.CalendarDayEntry():
        return 'CalendarDayEntry';
      case _i4.CalendarMonth():
        return 'CalendarMonth';
      case _i5.Contact():
        return 'Contact';
      case _i6.DailyMoodData():
        return 'DailyMoodData';
      case _i7.EntryTag():
        return 'EntryTag';
      case _i8.FavoriteContact():
        return 'FavoriteContact';
      case _i9.Goal():
        return 'Goal';
      case _i10.GratitudeEntry():
        return 'GratitudeEntry';
      case _i11.Greeting():
        return 'Greeting';
      case _i12.Insight():
        return 'Insight';
      case _i13.JournalEntry():
        return 'JournalEntry';
      case _i14.MoodDistribution():
        return 'MoodDistribution';
      case _i15.MoodPattern():
        return 'MoodPattern';
      case _i16.Tag():
        return 'Tag';
      case _i17.TimeOfDayAnalysis():
        return 'TimeOfDayAnalysis';
      case _i18.UserProfile():
        return 'UserProfile';
      case _i19.UserSettings():
        return 'UserSettings';
      case _i20.UserStats():
        return 'UserStats';
      case _i21.VoiceEntry():
        return 'VoiceEntry';
      case _i22.VoiceEntryWithTags():
        return 'VoiceEntryWithTags';
      case _i23.WeeklyAnalytics():
        return 'WeeklyAnalytics';
      case _i24.WellnessGoal():
        return 'WellnessGoal';
    }
    className = _i33.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i34.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AnalysisResult') {
      return deserialize<_i2.AnalysisResult>(data['data']);
    }
    if (dataClassName == 'CalendarDayEntry') {
      return deserialize<_i3.CalendarDayEntry>(data['data']);
    }
    if (dataClassName == 'CalendarMonth') {
      return deserialize<_i4.CalendarMonth>(data['data']);
    }
    if (dataClassName == 'Contact') {
      return deserialize<_i5.Contact>(data['data']);
    }
    if (dataClassName == 'DailyMoodData') {
      return deserialize<_i6.DailyMoodData>(data['data']);
    }
    if (dataClassName == 'EntryTag') {
      return deserialize<_i7.EntryTag>(data['data']);
    }
    if (dataClassName == 'FavoriteContact') {
      return deserialize<_i8.FavoriteContact>(data['data']);
    }
    if (dataClassName == 'Goal') {
      return deserialize<_i9.Goal>(data['data']);
    }
    if (dataClassName == 'GratitudeEntry') {
      return deserialize<_i10.GratitudeEntry>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i11.Greeting>(data['data']);
    }
    if (dataClassName == 'Insight') {
      return deserialize<_i12.Insight>(data['data']);
    }
    if (dataClassName == 'JournalEntry') {
      return deserialize<_i13.JournalEntry>(data['data']);
    }
    if (dataClassName == 'MoodDistribution') {
      return deserialize<_i14.MoodDistribution>(data['data']);
    }
    if (dataClassName == 'MoodPattern') {
      return deserialize<_i15.MoodPattern>(data['data']);
    }
    if (dataClassName == 'Tag') {
      return deserialize<_i16.Tag>(data['data']);
    }
    if (dataClassName == 'TimeOfDayAnalysis') {
      return deserialize<_i17.TimeOfDayAnalysis>(data['data']);
    }
    if (dataClassName == 'UserProfile') {
      return deserialize<_i18.UserProfile>(data['data']);
    }
    if (dataClassName == 'UserSettings') {
      return deserialize<_i19.UserSettings>(data['data']);
    }
    if (dataClassName == 'UserStats') {
      return deserialize<_i20.UserStats>(data['data']);
    }
    if (dataClassName == 'VoiceEntry') {
      return deserialize<_i21.VoiceEntry>(data['data']);
    }
    if (dataClassName == 'VoiceEntryWithTags') {
      return deserialize<_i22.VoiceEntryWithTags>(data['data']);
    }
    if (dataClassName == 'WeeklyAnalytics') {
      return deserialize<_i23.WeeklyAnalytics>(data['data']);
    }
    if (dataClassName == 'WellnessGoal') {
      return deserialize<_i24.WellnessGoal>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i33.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i34.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i33.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i34.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
