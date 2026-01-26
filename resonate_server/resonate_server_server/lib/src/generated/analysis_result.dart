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
    required this.pitchMean,
    required this.pitchStd,
    required this.energyMean,
    required this.tempo,
    required this.silenceRatio,
    this.transcript,
    required this.sentimentScore,
    required this.detectedEmotions,
    required this.emotionKeywords,
    this.topicContext,
    required this.acousticMoodScore,
    required this.semanticMoodScore,
    required this.finalMoodScore,
    required this.moodLabel,
    required this.confidence,
    required this.signalAlignment,
    required this.language,
  });

  factory AnalysisResult({
    required double pitchMean,
    required double pitchStd,
    required double energyMean,
    required double tempo,
    required double silenceRatio,
    String? transcript,
    required double sentimentScore,
    required List<String> detectedEmotions,
    required List<String> emotionKeywords,
    String? topicContext,
    required double acousticMoodScore,
    required double semanticMoodScore,
    required double finalMoodScore,
    required String moodLabel,
    required double confidence,
    required double signalAlignment,
    required String language,
  }) = _AnalysisResultImpl;

  factory AnalysisResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return AnalysisResult(
      pitchMean: (jsonSerialization['pitchMean'] as num).toDouble(),
      pitchStd: (jsonSerialization['pitchStd'] as num).toDouble(),
      energyMean: (jsonSerialization['energyMean'] as num).toDouble(),
      tempo: (jsonSerialization['tempo'] as num).toDouble(),
      silenceRatio: (jsonSerialization['silenceRatio'] as num).toDouble(),
      transcript: jsonSerialization['transcript'] as String?,
      sentimentScore: (jsonSerialization['sentimentScore'] as num).toDouble(),
      detectedEmotions: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['detectedEmotions'],
      ),
      emotionKeywords: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['emotionKeywords'],
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
      language: jsonSerialization['language'] as String,
    );
  }

  double pitchMean;

  double pitchStd;

  double energyMean;

  double tempo;

  double silenceRatio;

  String? transcript;

  double sentimentScore;

  List<String> detectedEmotions;

  List<String> emotionKeywords;

  String? topicContext;

  double acousticMoodScore;

  double semanticMoodScore;

  double finalMoodScore;

  String moodLabel;

  double confidence;

  double signalAlignment;

  String language;

  /// Returns a shallow copy of this [AnalysisResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AnalysisResult copyWith({
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
      'pitchMean': pitchMean,
      'pitchStd': pitchStd,
      'energyMean': energyMean,
      'tempo': tempo,
      'silenceRatio': silenceRatio,
      if (transcript != null) 'transcript': transcript,
      'sentimentScore': sentimentScore,
      'detectedEmotions': detectedEmotions.toJson(),
      'emotionKeywords': emotionKeywords.toJson(),
      if (topicContext != null) 'topicContext': topicContext,
      'acousticMoodScore': acousticMoodScore,
      'semanticMoodScore': semanticMoodScore,
      'finalMoodScore': finalMoodScore,
      'moodLabel': moodLabel,
      'confidence': confidence,
      'signalAlignment': signalAlignment,
      'language': language,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AnalysisResult',
      'pitchMean': pitchMean,
      'pitchStd': pitchStd,
      'energyMean': energyMean,
      'tempo': tempo,
      'silenceRatio': silenceRatio,
      if (transcript != null) 'transcript': transcript,
      'sentimentScore': sentimentScore,
      'detectedEmotions': detectedEmotions.toJson(),
      'emotionKeywords': emotionKeywords.toJson(),
      if (topicContext != null) 'topicContext': topicContext,
      'acousticMoodScore': acousticMoodScore,
      'semanticMoodScore': semanticMoodScore,
      'finalMoodScore': finalMoodScore,
      'moodLabel': moodLabel,
      'confidence': confidence,
      'signalAlignment': signalAlignment,
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
    required double pitchMean,
    required double pitchStd,
    required double energyMean,
    required double tempo,
    required double silenceRatio,
    String? transcript,
    required double sentimentScore,
    required List<String> detectedEmotions,
    required List<String> emotionKeywords,
    String? topicContext,
    required double acousticMoodScore,
    required double semanticMoodScore,
    required double finalMoodScore,
    required String moodLabel,
    required double confidence,
    required double signalAlignment,
    required String language,
  }) : super._(
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
    double? pitchMean,
    double? pitchStd,
    double? energyMean,
    double? tempo,
    double? silenceRatio,
    Object? transcript = _Undefined,
    double? sentimentScore,
    List<String>? detectedEmotions,
    List<String>? emotionKeywords,
    Object? topicContext = _Undefined,
    double? acousticMoodScore,
    double? semanticMoodScore,
    double? finalMoodScore,
    String? moodLabel,
    double? confidence,
    double? signalAlignment,
    String? language,
  }) {
    return AnalysisResult(
      pitchMean: pitchMean ?? this.pitchMean,
      pitchStd: pitchStd ?? this.pitchStd,
      energyMean: energyMean ?? this.energyMean,
      tempo: tempo ?? this.tempo,
      silenceRatio: silenceRatio ?? this.silenceRatio,
      transcript: transcript is String? ? transcript : this.transcript,
      sentimentScore: sentimentScore ?? this.sentimentScore,
      detectedEmotions:
          detectedEmotions ?? this.detectedEmotions.map((e0) => e0).toList(),
      emotionKeywords:
          emotionKeywords ?? this.emotionKeywords.map((e0) => e0).toList(),
      topicContext: topicContext is String? ? topicContext : this.topicContext,
      acousticMoodScore: acousticMoodScore ?? this.acousticMoodScore,
      semanticMoodScore: semanticMoodScore ?? this.semanticMoodScore,
      finalMoodScore: finalMoodScore ?? this.finalMoodScore,
      moodLabel: moodLabel ?? this.moodLabel,
      confidence: confidence ?? this.confidence,
      signalAlignment: signalAlignment ?? this.signalAlignment,
      language: language ?? this.language,
    );
  }
}
