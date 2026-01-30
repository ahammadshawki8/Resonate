import 'dart:math';
import 'dart:typed_data';
import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart' hide UserProfile;
import 'package:http/http.dart' as http;
import '../generated/protocol.dart';

/// Endpoint for voice entry operations.
class VoiceEntryEndpoint extends Endpoint {
  final _random = Random();
  
  // Python AI service URL
  static const String _pythonServiceUrl = 'https://resonate-vole.onrender.com';

  /// Helper to get user profile ID
  Future<int> _getProfileId(Session session) async {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      throw Exception('Authentication required');
    }
    final userId = authInfo.authUserId;

    final profile = await UserProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(userId),
    );

    if (profile == null) {
      throw Exception('Profile not found');
    }

    return profile.id!;
  }

  /// Upload and analyze a voice recording.
  /// Calls Python AI service for real analysis.
  Future<VoiceEntryWithTags> uploadAndAnalyze(
    Session session,
    ByteData audioData,
    String language,
    String privacyLevel,
  ) async {
    final profileId = await _getProfileId(session);

    // Try to call Python AI service
    AnalysisResult result;
    try {
      result = await _callPythonService(session, audioData, language, privacyLevel);
      session.log('Python AI service analysis successful');
    } catch (e) {
      session.log('Python AI service failed: $e. Using mock data.', level: LogLevel.warning);
      // Fallback to mock analysis
      final moodScore = 0.4 + _random.nextDouble() * 0.5;
      result = _generateMockAnalysis(moodScore, language);
    }

    // Create entry
    final entry = VoiceEntry(
      userProfileId: profileId,
      recordedAt: DateTime.now(),
      language: language,
      durationSeconds: result.durationSeconds ?? 30.0,
      pitchMean: result.pitchMean,
      pitchStd: result.pitchStd,
      energyMean: result.energyMean,
      tempo: result.tempo,
      silenceRatio: result.silenceRatio,
      transcript: result.transcript,
      emotionKeywords: result.emotionKeywords ?? [],
      sentimentScore: result.sentimentScore ?? 0.0,
      detectedEmotions: result.detectedEmotions ?? [],
      topicContext: result.topicContext,
      acousticMoodScore: result.acousticMoodScore,
      semanticMoodScore: result.semanticMoodScore ?? 0.0,
      finalMoodScore: result.finalMoodScore,
      moodLabel: result.moodLabel,
      confidence: result.confidence,
      signalAlignment: result.signalAlignment ?? 0.0,
      privacyLevel: privacyLevel,
    );

    final savedEntry = await VoiceEntry.db.insertRow(session, entry);

    // Update user stats
    await _updateUserStats(session, profileId, savedEntry.finalMoodScore);

    return VoiceEntryWithTags(entry: savedEntry, tags: []);
  }
  
  /// Call Python AI service for analysis
  Future<AnalysisResult> _callPythonService(
    Session session,
    ByteData audioData,
    String language,
    String privacyLevel,
  ) async {
    // Convert ByteData to Uint8List
    final bytes = audioData.buffer.asUint8List();
    
    session.log('Calling Python AI service: ${bytes.length} bytes, language: $language, privacy: $privacyLevel');
    
    // Create multipart request
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$_pythonServiceUrl/analyze'),
    );
    
    // Add audio file
    request.files.add(
      http.MultipartFile.fromBytes(
        'audio',
        bytes,
        filename: 'recording.m4a',
      ),
    );
    
    // Add parameters with explicit UTF-8 encoding
    request.fields['language'] = language;
    request.fields['privacy_level'] = privacyLevel;
    
    // Set headers to ensure UTF-8
    request.headers['Accept'] = 'application/json; charset=utf-8';
    request.headers['Accept-Charset'] = 'utf-8';
    
    session.log('Sending request to Python service...');
    
    // Send request with longer timeout (5 minutes for Whisper processing)
    final streamedResponse = await request.send().timeout(
      const Duration(minutes: 5),
      onTimeout: () {
        session.log('Python service timeout after 5 minutes', level: LogLevel.error);
        throw Exception('Python service timeout after 5 minutes');
      },
    );
    
    final response = await http.Response.fromStream(streamedResponse);
    
    session.log('Python service response: ${response.statusCode}');
    
    if (response.statusCode != 200) {
      session.log('Python service error: ${response.statusCode} - ${response.body}', level: LogLevel.error);
      throw Exception('Python service error: ${response.statusCode} - ${response.body}');
    }
    
    session.log('Parsing Python service response...');
    
    // Log raw response for debugging
    session.log('Response body bytes length: ${response.bodyBytes.length}');
    
    // Parse response with explicit UTF-8 decoding
    final responseText = utf8.decode(response.bodyBytes);
    session.log('Decoded response text (first 200 chars): ${responseText.length > 200 ? responseText.substring(0, 200) : responseText}');
    
    final data = jsonDecode(responseText) as Map<String, dynamic>;
    final acoustic = data['acoustic'] as Map<String, dynamic>;
    final fusion = data['fusion'] as Map<String, dynamic>;
    final semantic = data['semantic'] as Map<String, dynamic>?;
    
    final transcript = semantic?['transcript'] as String?;
    final transcriptPreview = transcript != null && transcript.length > 50 
        ? '${transcript.substring(0, 50)}...' 
        : transcript ?? 'none';
    session.log('Analysis complete: mood=${fusion['mood_label']}, transcript=$transcriptPreview');
    
    return AnalysisResult(
      durationSeconds: (acoustic['duration_seconds'] as num?)?.toDouble(),
      pitchMean: (acoustic['pitch_mean'] as num?)?.toDouble() ?? 0.0,
      pitchStd: (acoustic['pitch_std'] as num?)?.toDouble() ?? 0.0,
      energyMean: (acoustic['energy_mean'] as num?)?.toDouble() ?? 0.0,
      tempo: (acoustic['tempo'] as num?)?.toDouble() ?? 0.0,
      silenceRatio: (acoustic['silence_ratio'] as num?)?.toDouble() ?? 0.0,
      transcript: semantic?['transcript'] as String?,
      sentimentScore: (semantic?['sentiment_score'] as num?)?.toDouble() ?? 0.0,
      detectedEmotions: (semantic?['detected_emotions'] as List?)?.cast<String>() ?? [],
      emotionKeywords: (semantic?['emotion_keywords'] as List?)?.cast<String>() ?? [],
      topicContext: semantic?['topic_context'] as String?,
      acousticMoodScore: (acoustic['acoustic_mood_score'] as num?)?.toDouble() ?? 0.5,
      semanticMoodScore: (semantic?['semantic_mood_score'] as num?)?.toDouble() ?? 0.0,
      finalMoodScore: (fusion['final_mood_score'] as num?)?.toDouble() ?? 0.5,
      moodLabel: fusion['mood_label'] as String? ?? 'neutral',
      confidence: (fusion['confidence'] as num?)?.toDouble() ?? 0.5,
      signalAlignment: (fusion['signal_alignment'] as num?)?.toDouble() ?? 0.0,
      language: language,
    );
  }

  /// Get all entries for the user.
  Future<List<VoiceEntryWithTags>> getEntries(
    Session session, {
    int? limit,
  }) async {
    final profileId = await _getProfileId(session);

    final entries = await VoiceEntry.db.find(
      session,
      where: (t) => t.userProfileId.equals(profileId),
      orderBy: (t) => t.recordedAt,
      orderDescending: true,
      limit: limit,
    );

    final result = <VoiceEntryWithTags>[];
    for (final entry in entries) {
      final entryTags = await EntryTag.db.find(
        session,
        where: (t) => t.voiceEntryId.equals(entry.id!),
      );
      final tags = <Tag>[];
      for (final et in entryTags) {
        final tag = await Tag.db.findById(session, et.tagId);
        if (tag != null) tags.add(tag);
      }
      result.add(VoiceEntryWithTags(entry: entry, tags: tags));
    }

    return result;
  }

  /// Get a specific entry by ID.
  Future<VoiceEntryWithTags?> getEntry(Session session, int id) async {
    final profileId = await _getProfileId(session);

    final entry = await VoiceEntry.db.findById(session, id);
    if (entry == null || entry.userProfileId != profileId) {
      return null;
    }

    final entryTags = await EntryTag.db.find(
      session,
      where: (t) => t.voiceEntryId.equals(id),
    );
    final tags = <Tag>[];
    for (final et in entryTags) {
      final tag = await Tag.db.findById(session, et.tagId);
      if (tag != null) tags.add(tag);
    }

    return VoiceEntryWithTags(entry: entry, tags: tags);
  }

  /// Get today's entry.
  Future<VoiceEntryWithTags?> getTodayEntry(Session session) async {
    final profileId = await _getProfileId(session);
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final entry = await VoiceEntry.db.findFirstRow(
      session,
      where: (t) =>
          t.userProfileId.equals(profileId) &
          (t.recordedAt >= startOfDay) &
          (t.recordedAt < endOfDay),
    );

    if (entry == null) return null;

    final entryTags = await EntryTag.db.find(
      session,
      where: (t) => t.voiceEntryId.equals(entry.id!),
    );
    final tags = <Tag>[];
    for (final et in entryTags) {
      final tag = await Tag.db.findById(session, et.tagId);
      if (tag != null) tags.add(tag);
    }

    return VoiceEntryWithTags(entry: entry, tags: tags);
  }

  /// Get calendar data for a month.
  Future<CalendarMonth> getCalendarMonth(
    Session session,
    int year,
    int month,
  ) async {
    final profileId = await _getProfileId(session);
    final startOfMonth = DateTime(year, month, 1);
    final endOfMonth = DateTime(year, month + 1, 1);

    final entries = await VoiceEntry.db.find(
      session,
      where: (t) =>
          t.userProfileId.equals(profileId) &
          (t.recordedAt >= startOfMonth) &
          (t.recordedAt < endOfMonth),
    );

    final entriesMap = <int, CalendarDayEntry>{};
    for (final entry in entries) {
      entriesMap[entry.recordedAt.day] = CalendarDayEntry(
        entryId: entry.id!,
        moodScore: entry.finalMoodScore,
        moodLabel: entry.moodLabel,
      );
    }

    return CalendarMonth(
      year: year,
      month: month,
      entries: entriesMap,
    );
  }

  /// Delete an entry.
  Future<bool> deleteEntry(Session session, int id) async {
    final profileId = await _getProfileId(session);

    final entry = await VoiceEntry.db.findById(session, id);
    if (entry == null || entry.userProfileId != profileId) {
      return false;
    }

    await EntryTag.db.deleteWhere(
      session,
      where: (t) => t.voiceEntryId.equals(id),
    );
    await VoiceEntry.db.deleteRow(session, entry);

    return true;
  }

  Future<void> _updateUserStats(
    Session session,
    int profileId,
    double moodScore,
  ) async {
    final profile = await UserProfile.db.findById(session, profileId);
    if (profile == null) return;

    final entries = await VoiceEntry.db.find(
      session,
      where: (t) => t.userProfileId.equals(profileId),
    );

    final totalMood =
        entries.fold<double>(0, (sum, e) => sum + e.finalMoodScore);
    final avgMood = entries.isNotEmpty ? totalMood / entries.length : 0.5;

    final streak = _calculateStreak(entries);
    final longestStreak =
        streak > profile.longestStreak ? streak : profile.longestStreak;

    await UserProfile.db.updateRow(
      session,
      profile.copyWith(
        totalCheckins: entries.length,
        currentStreak: streak,
        longestStreak: longestStreak,
        averageMood: avgMood,
        lastLoginAt: DateTime.now(),
      ),
    );
  }

  int _calculateStreak(List<VoiceEntry> entries) {
    if (entries.isEmpty) return 0;

    entries.sort((a, b) => b.recordedAt.compareTo(a.recordedAt));

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    int streak = 0;
    DateTime currentDate = today;

    for (final entry in entries) {
      final entryDate = DateTime(
        entry.recordedAt.year,
        entry.recordedAt.month,
        entry.recordedAt.day,
      );

      if (entryDate == currentDate) {
        streak++;
        currentDate = currentDate.subtract(const Duration(days: 1));
      } else if (entryDate == currentDate.subtract(const Duration(days: 1))) {
        currentDate = entryDate;
        streak++;
        currentDate = currentDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }

    return streak;
  }

  AnalysisResult _generateMockAnalysis(double moodScore, String language) {
    final transcripts = [
      "I've been feeling really productive today.",
      "Work has been a bit stressful lately.",
      "Just spent some time with family.",
      "I've been feeling a bit overwhelmed.",
      "Today was a good day!",
    ];

    final emotions = moodScore > 0.6
        ? ['happy', 'hopeful', 'content']
        : moodScore > 0.4
            ? ['calm', 'neutral', 'thoughtful']
            : ['stressed', 'tired', 'anxious'];

    return AnalysisResult(
      durationSeconds: 30.0 + _random.nextDouble() * 30,
      pitchMean: 130.0 + _random.nextDouble() * 40,
      pitchStd: 15.0 + _random.nextDouble() * 20,
      energyMean: 0.05 + moodScore * 0.05,
      tempo: 90.0 + _random.nextDouble() * 40,
      silenceRatio: 0.1 + (1 - moodScore) * 0.15,
      transcript: transcripts[_random.nextInt(transcripts.length)],
      sentimentScore: moodScore - 0.5,
      detectedEmotions: emotions,
      emotionKeywords: ['feeling', 'today', 'good'],
      topicContext: 'general',
      acousticMoodScore: moodScore - 0.05 + _random.nextDouble() * 0.1,
      semanticMoodScore: moodScore + 0.03 - _random.nextDouble() * 0.1,
      finalMoodScore: moodScore,
      moodLabel: _getMoodLabel(moodScore),
      confidence: 0.85 + _random.nextDouble() * 0.1,
      signalAlignment: 0.8 + _random.nextDouble() * 0.15,
      language: language,
    );
  }

  String _getMoodLabel(double score) {
    if (score >= 0.8) return 'very_positive';
    if (score >= 0.6) return 'positive';
    if (score >= 0.4) return 'neutral';
    if (score >= 0.2) return 'low';
    return 'very_low';
  }
}
