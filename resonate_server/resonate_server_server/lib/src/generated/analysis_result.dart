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

/// Analysis result from voice processing (DTO).
abstract class AnalysisResult
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AnalysisResult._({
    this.durationSeconds,
    required this.pitchMean,
    required this.pitchStd,
    required this.energyMean,
    required this.tempo,
    required this.silenceRatio,
    this.transcript,
    this.sentimentScore,
    this.detectedEmotions,
    this.emotionKeywords,
    this.topicContext,
    required this.acousticMoodScore,
    this.semanticMoodScore,
    required this.finalMoodScore,
    required this.moodLabel,
    required this.confidence,
    this.signalAlignment,
    required this.language,
  });

  factory AnalysisResult({
    double? durationSeconds,
    required double pitchMean,
    required double pitchStd,
    required double energyMean,
    required double tempo,
    required double silenceRatio,
    String? transcript,
    double? sentimentScore,
    List<String>? detectedEmotions,
    List<String>? emotionKeywords,
    String? topicContext,
    required double acousticMoodScore,
    double? semanticMoodScore,
    required double finalMoodScore,
    required String moodLabel,
    required double confidence,
    double? signalAlignment,
    required String language,
  }) = _AnalysisResultImpl;

  factory AnalysisResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return AnalysisResult(
      durationSeconds: (jsonSerialization['durationSeconds'] as num?)
          ?.toDouble(),
      pitchMean: (jsonSerialization['pitchMean'] as num).toDouble(),
      pitchStd: (jsonSerialization['pitchStd'] as num).toDouble(),
      energyMean: (jsonSerialization['energyMean'] as num).toDouble(),
      tempo: (jsonSerialization['tempo'] as num).toDouble(),
      silenceRatio: (jsonSerialization['silenceRatio'] as num).toDouble(),
      transcript: jsonSerialization['transcript'] as String?,
      sentimentScore: (jsonSerialization['sentimentScore'] as num?)?.toDouble(),
      detectedEmotions: jsonSerialization['detectedEmotions'] == null
          ? null
          : _i2.Protocol().deserialize<List<String>>(
              jsonSerialization['detectedEmotions'],
            ),
      emotionKeywords: jsonSerialization['emotionKeywords'] == null
          ? null
          : _i2.Protocol().deserialize<List<String>>(
              jsonSerialization['emotionKeywords'],
            ),
      topicContext: jsonSerialization['topicContext'] as String?,
      acousticMoodScore: (jsonSerialization['acousticMoodScore'] as num)
          .toDouble(),
      semanticMoodScore: (jsonSerialization['semanticMoodScore'] as num?)
          ?.toDouble(),
      finalMoodScore: (jsonSerialization['finalMoodScore'] as num).toDouble(),
      moodLabel: jsonSerialization['moodLabel'] as String,
      confidence: (jsonSerialization['confidence'] as num).toDouble(),
      signalAlignment: (jsonSerialization['signalAlignment'] as num?)
          ?.toDouble(),
      language: jsonSerialization['language'] as String,
    );
  }

  double? durationSeconds;

  double pitchMean;

  double pitchStd;

  double energyMean;

  double tempo;

  double silenceRatio;

  String? transcript;

  double? sentimentScore;

  List<String>? detectedEmotions;

  List<String>? emotionKeywords;

  String? topicContext;

  double acousticMoodScore;

  double? semanticMoodScore;

  double finalMoodScore;

  String moodLabel;

  double confidence;

  double? signalAlignment;

  String language;

  /// Returns a shallow copy of this [AnalysisResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AnalysisResult copyWith({
    double? durationSeconds,
    double? pitchMean,
    double? pitchStd,
    double? energyMean,
    double? tempo,
    double? silenceRatio,
    String? transcript,
    double? sentimentScore,
    List<String>? detectedEmotions,
    List<String>? emotionKeywords,
    String? topicContext,
    double? acousticMoodScore,
    double? semanticMoodScore,
    double? finalMoodScore,
    String? moodLabel,
    double? confidence,
    double? signalAlignment,
    String? language,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnalysisResult',
      if (durationSeconds != null) 'durationSeconds': durationSeconds,
      'pitchMean': pitchMean,
      'pitchStd': pitchStd,
      'energyMean': energyMean,
      'tempo': tempo,
      'silenceRatio': silenceRatio,
      if (transcript != null) 'transcript': transcript,
      if (sentimentScore != null) 'sentimentScore': sentimentScore,
      if (detectedEmotions != null)
        'detectedEmotions': detectedEmotions?.toJson(),
      if (emotionKeywords != null) 'emotionKeywords': emotionKeywords?.toJson(),
      if (topicContext != null) 'topicContext': topicContext,
      'acousticMoodScore': acousticMoodScore,
      if (semanticMoodScore != null) 'semanticMoodScore': semanticMoodScore,
      'finalMoodScore': finalMoodScore,
      'moodLabel': moodLabel,
      'confidence': confidence,
      if (signalAlignment != null) 'signalAlignment': signalAlignment,
      'language': language,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AnalysisResult',
      if (durationSeconds != null) 'durationSeconds': durationSeconds,
      'pitchMean': pitchMean,
      'pitchStd': pitchStd,
      'energyMean': energyMean,
      'tempo': tempo,
      'silenceRatio': silenceRatio,
      if (transcript != null) 'transcript': transcript,
      if (sentimentScore != null) 'sentimentScore': sentimentScore,
      if (detectedEmotions != null)
        'detectedEmotions': detectedEmotions?.toJson(),
      if (emotionKeywords != null) 'emotionKeywords': emotionKeywords?.toJson(),
      if (topicContext != null) 'topicContext': topicContext,
      'acousticMoodScore': acousticMoodScore,
      if (semanticMoodScore != null) 'semanticMoodScore': semanticMoodScore,
      'finalMoodScore': finalMoodScore,
      'moodLabel': moodLabel,
      'confidence': confidence,
      if (signalAlignment != null) 'signalAlignment': signalAlignment,
      'language': language,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AnalysisResultImpl extends AnalysisResult {
  _AnalysisResultImpl({
    double? durationSeconds,
    required double pitchMean,
    required double pitchStd,
    required double energyMean,
    required double tempo,
    required double silenceRatio,
    String? transcript,
    double? sentimentScore,
    List<String>? detectedEmotions,
    List<String>? emotionKeywords,
    String? topicContext,
    required double acousticMoodScore,
    double? semanticMoodScore,
    required double finalMoodScore,
    required String moodLabel,
    required double confidence,
    double? signalAlignment,
    required String language,
  }) : super._(
         durationSeconds: durationSeconds,
         pitchMean: pitchMean,
         pitchStd: pitchStd,
         energyMean: energyMean,
         tempo: tempo,
         silenceRatio: silenceRatio,
         transcript: transcript,
         sentimentScore: sentimentScore,
         detectedEmotions: detectedEmotions,
         emotionKeywords: emotionKeywords,
         topicContext: topicContext,
         acousticMoodScore: acousticMoodScore,
         semanticMoodScore: semanticMoodScore,
         finalMoodScore: finalMoodScore,
         moodLabel: moodLabel,
         confidence: confidence,
         signalAlignment: signalAlignment,
         language: language,
       );

  /// Returns a shallow copy of this [AnalysisResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AnalysisResult copyWith({
    Object? durationSeconds = _Undefined,
    double? pitchMean,
    double? pitchStd,
    double? energyMean,
    double? tempo,
    double? silenceRatio,
    Object? transcript = _Undefined,
    Object? sentimentScore = _Undefined,
    Object? detectedEmotions = _Undefined,
    Object? emotionKeywords = _Undefined,
    Object? topicContext = _Undefined,
    double? acousticMoodScore,
    Object? semanticMoodScore = _Undefined,
    double? finalMoodScore,
    String? moodLabel,
    double? confidence,
    Object? signalAlignment = _Undefined,
    String? language,
  }) {
    return AnalysisResult(
      durationSeconds: durationSeconds is double?
          ? durationSeconds
          : this.durationSeconds,
      pitchMean: pitchMean ?? this.pitchMean,
      pitchStd: pitchStd ?? this.pitchStd,
      energyMean: energyMean ?? this.energyMean,
      tempo: tempo ?? this.tempo,
      silenceRatio: silenceRatio ?? this.silenceRatio,
      transcript: transcript is String? ? transcript : this.transcript,
      sentimentScore: sentimentScore is double?
          ? sentimentScore
          : this.sentimentScore,
      detectedEmotions: detectedEmotions is List<String>?
          ? detectedEmotions
          : this.detectedEmotions?.map((e0) => e0).toList(),
      emotionKeywords: emotionKeywords is List<String>?
          ? emotionKeywords
          : this.emotionKeywords?.map((e0) => e0).toList(),
      topicContext: topicContext is String? ? topicContext : this.topicContext,
      acousticMoodScore: acousticMoodScore ?? this.acousticMoodScore,
      semanticMoodScore: semanticMoodScore is double?
          ? semanticMoodScore
          : this.semanticMoodScore,
      finalMoodScore: finalMoodScore ?? this.finalMoodScore,
      moodLabel: moodLabel ?? this.moodLabel,
      confidence: confidence ?? this.confidence,
      signalAlignment: signalAlignment is double?
          ? signalAlignment
          : this.signalAlignment,
      language: language ?? this.language,
    );
  }
}
