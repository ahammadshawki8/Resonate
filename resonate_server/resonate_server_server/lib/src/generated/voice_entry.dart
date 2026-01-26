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
import 'package:resonate_server_server/src/generated/protocol.dart' as _i2;

/// Voice entry recording with analysis data.
abstract class VoiceEntry
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  VoiceEntry._({
    this.id,
    required this.userProfileId,
    required this.recordedAt,
    required this.language,
    this.audioUrl,
    required this.durationSeconds,
    required this.pitchMean,
    required this.pitchStd,
    required this.energyMean,
    required this.tempo,
    required this.silenceRatio,
    this.transcript,
    required this.emotionKeywords,
    required this.sentimentScore,
    required this.detectedEmotions,
    this.topicContext,
    required this.acousticMoodScore,
    required this.semanticMoodScore,
    required this.finalMoodScore,
    required this.moodLabel,
    required this.confidence,
    required this.signalAlignment,
    this.note,
    required this.privacyLevel,
  });

  factory VoiceEntry({
    int? id,
    required int userProfileId,
    required DateTime recordedAt,
    required String language,
    String? audioUrl,
    required double durationSeconds,
    required double pitchMean,
    required double pitchStd,
    required double energyMean,
    required double tempo,
    required double silenceRatio,
    String? transcript,
    required List<String> emotionKeywords,
    required double sentimentScore,
    required List<String> detectedEmotions,
    String? topicContext,
    required double acousticMoodScore,
    required double semanticMoodScore,
    required double finalMoodScore,
    required String moodLabel,
    required double confidence,
    required double signalAlignment,
    String? note,
    required String privacyLevel,
  }) = _VoiceEntryImpl;

  factory VoiceEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return VoiceEntry(
      id: jsonSerialization['id'] as int?,
      userProfileId: jsonSerialization['userProfileId'] as int,
      recordedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['recordedAt'],
      ),
      language: jsonSerialization['language'] as String,
      audioUrl: jsonSerialization['audioUrl'] as String?,
      durationSeconds: (jsonSerialization['durationSeconds'] as num).toDouble(),
      pitchMean: (jsonSerialization['pitchMean'] as num).toDouble(),
      pitchStd: (jsonSerialization['pitchStd'] as num).toDouble(),
      energyMean: (jsonSerialization['energyMean'] as num).toDouble(),
      tempo: (jsonSerialization['tempo'] as num).toDouble(),
      silenceRatio: (jsonSerialization['silenceRatio'] as num).toDouble(),
      transcript: jsonSerialization['transcript'] as String?,
      emotionKeywords: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['emotionKeywords'],
      ),
      sentimentScore: (jsonSerialization['sentimentScore'] as num).toDouble(),
      detectedEmotions: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['detectedEmotions'],
      ),
      topicContext: jsonSerialization['topicContext'] as String?,
      acousticMoodScore: (jsonSerialization['acousticMoodScore'] as num)
          .toDouble(),
      semanticMoodScore: (jsonSerialization['semanticMoodScore'] as num)
          .toDouble(),
      finalMoodScore: (jsonSerialization['finalMoodScore'] as num).toDouble(),
      moodLabel: jsonSerialization['moodLabel'] as String,
      confidence: (jsonSerialization['confidence'] as num).toDouble(),
      signalAlignment: (jsonSerialization['signalAlignment'] as num).toDouble(),
      note: jsonSerialization['note'] as String?,
      privacyLevel: jsonSerialization['privacyLevel'] as String,
    );
  }

  static final t = VoiceEntryTable();

  static const db = VoiceEntryRepository._();

  @override
  int? id;

  int userProfileId;

  DateTime recordedAt;

  String language;

  String? audioUrl;

  double durationSeconds;

  double pitchMean;

  double pitchStd;

  double energyMean;

  double tempo;

  double silenceRatio;

  String? transcript;

  List<String> emotionKeywords;

  double sentimentScore;

  List<String> detectedEmotions;

  String? topicContext;

  double acousticMoodScore;

  double semanticMoodScore;

  double finalMoodScore;

  String moodLabel;

  double confidence;

  double signalAlignment;

  String? note;

  String privacyLevel;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [VoiceEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  VoiceEntry copyWith({
    int? id,
    int? userProfileId,
    DateTime? recordedAt,
    String? language,
    String? audioUrl,
    double? durationSeconds,
    double? pitchMean,
    double? pitchStd,
    double? energyMean,
    double? tempo,
    double? silenceRatio,
    String? transcript,
    List<String>? emotionKeywords,
    double? sentimentScore,
    List<String>? detectedEmotions,
    String? topicContext,
    double? acousticMoodScore,
    double? semanticMoodScore,
    double? finalMoodScore,
    String? moodLabel,
    double? confidence,
    double? signalAlignment,
    String? note,
    String? privacyLevel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VoiceEntry',
      if (id != null) 'id': id,
      'userProfileId': userProfileId,
      'recordedAt': recordedAt.toJson(),
      'language': language,
      if (audioUrl != null) 'audioUrl': audioUrl,
      'durationSeconds': durationSeconds,
      'pitchMean': pitchMean,
      'pitchStd': pitchStd,
      'energyMean': energyMean,
      'tempo': tempo,
      'silenceRatio': silenceRatio,
      if (transcript != null) 'transcript': transcript,
      'emotionKeywords': emotionKeywords.toJson(),
      'sentimentScore': sentimentScore,
      'detectedEmotions': detectedEmotions.toJson(),
      if (topicContext != null) 'topicContext': topicContext,
      'acousticMoodScore': acousticMoodScore,
      'semanticMoodScore': semanticMoodScore,
      'finalMoodScore': finalMoodScore,
      'moodLabel': moodLabel,
      'confidence': confidence,
      'signalAlignment': signalAlignment,
      if (note != null) 'note': note,
      'privacyLevel': privacyLevel,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VoiceEntry',
      if (id != null) 'id': id,
      'userProfileId': userProfileId,
      'recordedAt': recordedAt.toJson(),
      'language': language,
      if (audioUrl != null) 'audioUrl': audioUrl,
      'durationSeconds': durationSeconds,
      'pitchMean': pitchMean,
      'pitchStd': pitchStd,
      'energyMean': energyMean,
      'tempo': tempo,
      'silenceRatio': silenceRatio,
      if (transcript != null) 'transcript': transcript,
      'emotionKeywords': emotionKeywords.toJson(),
      'sentimentScore': sentimentScore,
      'detectedEmotions': detectedEmotions.toJson(),
      if (topicContext != null) 'topicContext': topicContext,
      'acousticMoodScore': acousticMoodScore,
      'semanticMoodScore': semanticMoodScore,
      'finalMoodScore': finalMoodScore,
      'moodLabel': moodLabel,
      'confidence': confidence,
      'signalAlignment': signalAlignment,
      if (note != null) 'note': note,
      'privacyLevel': privacyLevel,
    };
  }

  static VoiceEntryInclude include() {
    return VoiceEntryInclude._();
  }

  static VoiceEntryIncludeList includeList({
    _i1.WhereExpressionBuilder<VoiceEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VoiceEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VoiceEntryTable>? orderByList,
    VoiceEntryInclude? include,
  }) {
    return VoiceEntryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VoiceEntry.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(VoiceEntry.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VoiceEntryImpl extends VoiceEntry {
  _VoiceEntryImpl({
    int? id,
    required int userProfileId,
    required DateTime recordedAt,
    required String language,
    String? audioUrl,
    required double durationSeconds,
    required double pitchMean,
    required double pitchStd,
    required double energyMean,
    required double tempo,
    required double silenceRatio,
    String? transcript,
    required List<String> emotionKeywords,
    required double sentimentScore,
    required List<String> detectedEmotions,
    String? topicContext,
    required double acousticMoodScore,
    required double semanticMoodScore,
    required double finalMoodScore,
    required String moodLabel,
    required double confidence,
    required double signalAlignment,
    String? note,
    required String privacyLevel,
  }) : super._(
         id: id,
         userProfileId: userProfileId,
         recordedAt: recordedAt,
         language: language,
         audioUrl: audioUrl,
         durationSeconds: durationSeconds,
         pitchMean: pitchMean,
         pitchStd: pitchStd,
         energyMean: energyMean,
         tempo: tempo,
         silenceRatio: silenceRatio,
         transcript: transcript,
         emotionKeywords: emotionKeywords,
         sentimentScore: sentimentScore,
         detectedEmotions: detectedEmotions,
         topicContext: topicContext,
         acousticMoodScore: acousticMoodScore,
         semanticMoodScore: semanticMoodScore,
         finalMoodScore: finalMoodScore,
         moodLabel: moodLabel,
         confidence: confidence,
         signalAlignment: signalAlignment,
         note: note,
         privacyLevel: privacyLevel,
       );

  /// Returns a shallow copy of this [VoiceEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  VoiceEntry copyWith({
    Object? id = _Undefined,
    int? userProfileId,
    DateTime? recordedAt,
    String? language,
    Object? audioUrl = _Undefined,
    double? durationSeconds,
    double? pitchMean,
    double? pitchStd,
    double? energyMean,
    double? tempo,
    double? silenceRatio,
    Object? transcript = _Undefined,
    List<String>? emotionKeywords,
    double? sentimentScore,
    List<String>? detectedEmotions,
    Object? topicContext = _Undefined,
    double? acousticMoodScore,
    double? semanticMoodScore,
    double? finalMoodScore,
    String? moodLabel,
    double? confidence,
    double? signalAlignment,
    Object? note = _Undefined,
    String? privacyLevel,
  }) {
    return VoiceEntry(
      id: id is int? ? id : this.id,
      userProfileId: userProfileId ?? this.userProfileId,
      recordedAt: recordedAt ?? this.recordedAt,
      language: language ?? this.language,
      audioUrl: audioUrl is String? ? audioUrl : this.audioUrl,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      pitchMean: pitchMean ?? this.pitchMean,
      pitchStd: pitchStd ?? this.pitchStd,
      energyMean: energyMean ?? this.energyMean,
      tempo: tempo ?? this.tempo,
      silenceRatio: silenceRatio ?? this.silenceRatio,
      transcript: transcript is String? ? transcript : this.transcript,
      emotionKeywords:
          emotionKeywords ?? this.emotionKeywords.map((e0) => e0).toList(),
      sentimentScore: sentimentScore ?? this.sentimentScore,
      detectedEmotions:
          detectedEmotions ?? this.detectedEmotions.map((e0) => e0).toList(),
      topicContext: topicContext is String? ? topicContext : this.topicContext,
      acousticMoodScore: acousticMoodScore ?? this.acousticMoodScore,
      semanticMoodScore: semanticMoodScore ?? this.semanticMoodScore,
      finalMoodScore: finalMoodScore ?? this.finalMoodScore,
      moodLabel: moodLabel ?? this.moodLabel,
      confidence: confidence ?? this.confidence,
      signalAlignment: signalAlignment ?? this.signalAlignment,
      note: note is String? ? note : this.note,
      privacyLevel: privacyLevel ?? this.privacyLevel,
    );
  }
}

class VoiceEntryUpdateTable extends _i1.UpdateTable<VoiceEntryTable> {
  VoiceEntryUpdateTable(super.table);

  _i1.ColumnValue<int, int> userProfileId(int value) => _i1.ColumnValue(
    table.userProfileId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> recordedAt(DateTime value) =>
      _i1.ColumnValue(
        table.recordedAt,
        value,
      );

  _i1.ColumnValue<String, String> language(String value) => _i1.ColumnValue(
    table.language,
    value,
  );

  _i1.ColumnValue<String, String> audioUrl(String? value) => _i1.ColumnValue(
    table.audioUrl,
    value,
  );

  _i1.ColumnValue<double, double> durationSeconds(double value) =>
      _i1.ColumnValue(
        table.durationSeconds,
        value,
      );

  _i1.ColumnValue<double, double> pitchMean(double value) => _i1.ColumnValue(
    table.pitchMean,
    value,
  );

  _i1.ColumnValue<double, double> pitchStd(double value) => _i1.ColumnValue(
    table.pitchStd,
    value,
  );

  _i1.ColumnValue<double, double> energyMean(double value) => _i1.ColumnValue(
    table.energyMean,
    value,
  );

  _i1.ColumnValue<double, double> tempo(double value) => _i1.ColumnValue(
    table.tempo,
    value,
  );

  _i1.ColumnValue<double, double> silenceRatio(double value) => _i1.ColumnValue(
    table.silenceRatio,
    value,
  );

  _i1.ColumnValue<String, String> transcript(String? value) => _i1.ColumnValue(
    table.transcript,
    value,
  );

  _i1.ColumnValue<List<String>, List<String>> emotionKeywords(
    List<String> value,
  ) => _i1.ColumnValue(
    table.emotionKeywords,
    value,
  );

  _i1.ColumnValue<double, double> sentimentScore(double value) =>
      _i1.ColumnValue(
        table.sentimentScore,
        value,
      );

  _i1.ColumnValue<List<String>, List<String>> detectedEmotions(
    List<String> value,
  ) => _i1.ColumnValue(
    table.detectedEmotions,
    value,
  );

  _i1.ColumnValue<String, String> topicContext(String? value) =>
      _i1.ColumnValue(
        table.topicContext,
        value,
      );

  _i1.ColumnValue<double, double> acousticMoodScore(double value) =>
      _i1.ColumnValue(
        table.acousticMoodScore,
        value,
      );

  _i1.ColumnValue<double, double> semanticMoodScore(double value) =>
      _i1.ColumnValue(
        table.semanticMoodScore,
        value,
      );

  _i1.ColumnValue<double, double> finalMoodScore(double value) =>
      _i1.ColumnValue(
        table.finalMoodScore,
        value,
      );

  _i1.ColumnValue<String, String> moodLabel(String value) => _i1.ColumnValue(
    table.moodLabel,
    value,
  );

  _i1.ColumnValue<double, double> confidence(double value) => _i1.ColumnValue(
    table.confidence,
    value,
  );

  _i1.ColumnValue<double, double> signalAlignment(double value) =>
      _i1.ColumnValue(
        table.signalAlignment,
        value,
      );

  _i1.ColumnValue<String, String> note(String? value) => _i1.ColumnValue(
    table.note,
    value,
  );

  _i1.ColumnValue<String, String> privacyLevel(String value) => _i1.ColumnValue(
    table.privacyLevel,
    value,
  );
}

class VoiceEntryTable extends _i1.Table<int?> {
  VoiceEntryTable({super.tableRelation}) : super(tableName: 'voice_entries') {
    updateTable = VoiceEntryUpdateTable(this);
    userProfileId = _i1.ColumnInt(
      'userProfileId',
      this,
    );
    recordedAt = _i1.ColumnDateTime(
      'recordedAt',
      this,
    );
    language = _i1.ColumnString(
      'language',
      this,
    );
    audioUrl = _i1.ColumnString(
      'audioUrl',
      this,
    );
    durationSeconds = _i1.ColumnDouble(
      'durationSeconds',
      this,
    );
    pitchMean = _i1.ColumnDouble(
      'pitchMean',
      this,
    );
    pitchStd = _i1.ColumnDouble(
      'pitchStd',
      this,
    );
    energyMean = _i1.ColumnDouble(
      'energyMean',
      this,
    );
    tempo = _i1.ColumnDouble(
      'tempo',
      this,
    );
    silenceRatio = _i1.ColumnDouble(
      'silenceRatio',
      this,
    );
    transcript = _i1.ColumnString(
      'transcript',
      this,
    );
    emotionKeywords = _i1.ColumnSerializable<List<String>>(
      'emotionKeywords',
      this,
    );
    sentimentScore = _i1.ColumnDouble(
      'sentimentScore',
      this,
    );
    detectedEmotions = _i1.ColumnSerializable<List<String>>(
      'detectedEmotions',
      this,
    );
    topicContext = _i1.ColumnString(
      'topicContext',
      this,
    );
    acousticMoodScore = _i1.ColumnDouble(
      'acousticMoodScore',
      this,
    );
    semanticMoodScore = _i1.ColumnDouble(
      'semanticMoodScore',
      this,
    );
    finalMoodScore = _i1.ColumnDouble(
      'finalMoodScore',
      this,
    );
    moodLabel = _i1.ColumnString(
      'moodLabel',
      this,
    );
    confidence = _i1.ColumnDouble(
      'confidence',
      this,
    );
    signalAlignment = _i1.ColumnDouble(
      'signalAlignment',
      this,
    );
    note = _i1.ColumnString(
      'note',
      this,
    );
    privacyLevel = _i1.ColumnString(
      'privacyLevel',
      this,
    );
  }

  late final VoiceEntryUpdateTable updateTable;

  late final _i1.ColumnInt userProfileId;

  late final _i1.ColumnDateTime recordedAt;

  late final _i1.ColumnString language;

  late final _i1.ColumnString audioUrl;

  late final _i1.ColumnDouble durationSeconds;

  late final _i1.ColumnDouble pitchMean;

  late final _i1.ColumnDouble pitchStd;

  late final _i1.ColumnDouble energyMean;

  late final _i1.ColumnDouble tempo;

  late final _i1.ColumnDouble silenceRatio;

  late final _i1.ColumnString transcript;

  late final _i1.ColumnSerializable<List<String>> emotionKeywords;

  late final _i1.ColumnDouble sentimentScore;

  late final _i1.ColumnSerializable<List<String>> detectedEmotions;

  late final _i1.ColumnString topicContext;

  late final _i1.ColumnDouble acousticMoodScore;

  late final _i1.ColumnDouble semanticMoodScore;

  late final _i1.ColumnDouble finalMoodScore;

  late final _i1.ColumnString moodLabel;

  late final _i1.ColumnDouble confidence;

  late final _i1.ColumnDouble signalAlignment;

  late final _i1.ColumnString note;

  late final _i1.ColumnString privacyLevel;

  @override
  List<_i1.Column> get columns => [
    id,
    userProfileId,
    recordedAt,
    language,
    audioUrl,
    durationSeconds,
    pitchMean,
    pitchStd,
    energyMean,
    tempo,
    silenceRatio,
    transcript,
    emotionKeywords,
    sentimentScore,
    detectedEmotions,
    topicContext,
    acousticMoodScore,
    semanticMoodScore,
    finalMoodScore,
    moodLabel,
    confidence,
    signalAlignment,
    note,
    privacyLevel,
  ];
}

class VoiceEntryInclude extends _i1.IncludeObject {
  VoiceEntryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => VoiceEntry.t;
}

class VoiceEntryIncludeList extends _i1.IncludeList {
  VoiceEntryIncludeList._({
    _i1.WhereExpressionBuilder<VoiceEntryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(VoiceEntry.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => VoiceEntry.t;
}

class VoiceEntryRepository {
  const VoiceEntryRepository._();

  /// Returns a list of [VoiceEntry]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<VoiceEntry>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<VoiceEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VoiceEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VoiceEntryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<VoiceEntry>(
      where: where?.call(VoiceEntry.t),
      orderBy: orderBy?.call(VoiceEntry.t),
      orderByList: orderByList?.call(VoiceEntry.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [VoiceEntry] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<VoiceEntry?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<VoiceEntryTable>? where,
    int? offset,
    _i1.OrderByBuilder<VoiceEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VoiceEntryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<VoiceEntry>(
      where: where?.call(VoiceEntry.t),
      orderBy: orderBy?.call(VoiceEntry.t),
      orderByList: orderByList?.call(VoiceEntry.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [VoiceEntry] by its [id] or null if no such row exists.
  Future<VoiceEntry?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<VoiceEntry>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [VoiceEntry]s in the list and returns the inserted rows.
  ///
  /// The returned [VoiceEntry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<VoiceEntry>> insert(
    _i1.Session session,
    List<VoiceEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<VoiceEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [VoiceEntry] and returns the inserted row.
  ///
  /// The returned [VoiceEntry] will have its `id` field set.
  Future<VoiceEntry> insertRow(
    _i1.Session session,
    VoiceEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<VoiceEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [VoiceEntry]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<VoiceEntry>> update(
    _i1.Session session,
    List<VoiceEntry> rows, {
    _i1.ColumnSelections<VoiceEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<VoiceEntry>(
      rows,
      columns: columns?.call(VoiceEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VoiceEntry]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<VoiceEntry> updateRow(
    _i1.Session session,
    VoiceEntry row, {
    _i1.ColumnSelections<VoiceEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<VoiceEntry>(
      row,
      columns: columns?.call(VoiceEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VoiceEntry] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<VoiceEntry?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<VoiceEntryUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<VoiceEntry>(
      id,
      columnValues: columnValues(VoiceEntry.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [VoiceEntry]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<VoiceEntry>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<VoiceEntryUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<VoiceEntryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VoiceEntryTable>? orderBy,
    _i1.OrderByListBuilder<VoiceEntryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<VoiceEntry>(
      columnValues: columnValues(VoiceEntry.t.updateTable),
      where: where(VoiceEntry.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VoiceEntry.t),
      orderByList: orderByList?.call(VoiceEntry.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [VoiceEntry]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<VoiceEntry>> delete(
    _i1.Session session,
    List<VoiceEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<VoiceEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [VoiceEntry].
  Future<VoiceEntry> deleteRow(
    _i1.Session session,
    VoiceEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<VoiceEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<VoiceEntry>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<VoiceEntryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<VoiceEntry>(
      where: where(VoiceEntry.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<VoiceEntryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<VoiceEntry>(
      where: where?.call(VoiceEntry.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
