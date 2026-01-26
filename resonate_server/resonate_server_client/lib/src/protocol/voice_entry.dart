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
import 'package:resonate_server_client/src/protocol/protocol.dart' as _i2;

/// Voice entry recording with analysis data.
abstract class VoiceEntry implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
