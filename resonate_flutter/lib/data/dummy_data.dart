import 'package:flutter/material.dart';
import 'models/models.dart';

/// Dummy data for the frontend
/// Replace with API calls when backend is ready

class DummyData {
  // Current logged in user
  static User currentUser = User(
    id: 'user_001',
    email: 'shawki@example.com',
    name: 'Shawki',
    avatarUrl: null,
    createdAt: DateTime(2025, 12, 1),
    totalCheckins: 42,
    currentStreak: 7,
    averageMood: 0.68,
  );
  
  // User settings
  static UserSettings userSettings = UserSettings(
    userId: 'user_001',
    reminderTime: const TimeOfDay(hour: 9, minute: 0),
    reminderEnabled: true,
    darkMode: false,
    uiLanguage: 'en',
    voiceLanguage: 'en',
    privacyLevel: 'full',
    notificationsEnabled: true,
  );
  
  // Available tags
  static List<Tag> tags = [
    const Tag(id: 'tag_1', name: 'Work', color: '#EF4444', usageCount: 15),
    const Tag(id: 'tag_2', name: 'Family', color: '#F59E0B', usageCount: 8),
    const Tag(id: 'tag_3', name: 'Exercise', color: '#10B981', usageCount: 12),
    const Tag(id: 'tag_4', name: 'Social', color: '#3B82F6', usageCount: 6),
    const Tag(id: 'tag_5', name: 'Health', color: '#EC4899', usageCount: 4),
    const Tag(id: 'tag_6', name: 'Travel', color: '#8B5CF6', usageCount: 2),
  ];
  
  // Generate voice entries for the past 30 days
  static List<VoiceEntry> generateVoiceEntries() {
    final now = DateTime.now();
    final entries = <VoiceEntry>[];
    
    final moodData = [
      {'score': 0.72, 'label': 'positive', 'emoji': '😊', 'topic': 'work', 'emotions': ['hopeful', 'excited'], 'transcript': 'Had a great meeting today, feeling hopeful about the project'},
      {'score': 0.45, 'label': 'neutral', 'emoji': '😐', 'topic': 'general', 'emotions': ['calm'], 'transcript': 'Just a regular day, nothing special happened'},
      {'score': 0.82, 'label': 'very_positive', 'emoji': '😊', 'topic': 'family', 'emotions': ['joy', 'love'], 'transcript': 'Spent time with family, feeling so grateful'},
      {'score': 0.35, 'label': 'low', 'emoji': '😔', 'topic': 'work', 'emotions': ['stressed', 'tired'], 'transcript': 'Deadline pressure is getting to me'},
      {'score': 0.68, 'label': 'positive', 'emoji': '🙂', 'topic': 'exercise', 'emotions': ['energetic'], 'transcript': 'Great workout session this morning'},
      {'score': 0.55, 'label': 'neutral', 'emoji': '😐', 'topic': 'general', 'emotions': ['thoughtful'], 'transcript': 'Thinking about future plans'},
      {'score': 0.78, 'label': 'positive', 'emoji': '😊', 'topic': 'social', 'emotions': ['happy', 'connected'], 'transcript': 'Met up with old friends, such good times'},
      {'score': 0.42, 'label': 'neutral', 'emoji': '😐', 'topic': 'health', 'emotions': ['concerned'], 'transcript': 'Need to focus on sleep schedule'},
      {'score': 0.88, 'label': 'very_positive', 'emoji': '😊', 'topic': 'work', 'emotions': ['proud', 'accomplished'], 'transcript': 'Finally completed the big project!'},
      {'score': 0.25, 'label': 'low', 'emoji': '😔', 'topic': 'general', 'emotions': ['lonely', 'sad'], 'transcript': 'Missing my friends from back home'},
    ];
    
    for (int i = 0; i < 25; i++) {
      final dayOffset = i;
      final date = now.subtract(Duration(days: dayOffset));
      
      // Skip some days randomly (no entry)
      if (i == 3 || i == 10 || i == 17 || i == 23) continue;
      
      final data = moodData[i % moodData.length];
      final score = (data['score'] as double) + (i % 5 - 2) * 0.05;
      
      entries.add(VoiceEntry(
        id: 'entry_${i.toString().padLeft(3, '0')}',
        userId: 'user_001',
        recordedAt: DateTime(date.year, date.month, date.day, 9 + (i % 12), (i * 7) % 60),
        language: i % 5 == 0 ? 'bn' : 'en',
        durationSeconds: 25.0 + (i % 10),
        pitchMean: 130.0 + (i % 30),
        pitchStd: 20.0 + (i % 15),
        energyMean: 0.06 + (score * 0.05),
        tempo: 100.0 + (i % 40),
        silenceRatio: 0.1 + (1 - score) * 0.1,
        transcript: data['transcript'] as String,
        emotionKeywords: ['good', 'feeling', 'today'],
        sentimentScore: score - 0.5,
        detectedEmotions: (data['emotions'] as List<String>),
        topicContext: data['topic'] as String,
        acousticMoodScore: score - 0.05,
        semanticMoodScore: score + 0.03,
        finalMoodScore: score.clamp(0.0, 1.0),
        moodLabel: data['label'] as String,
        confidence: 0.85 + (i % 10) * 0.01,
        signalAlignment: 0.8 + (i % 15) * 0.01,
        note: i % 3 == 0 ? 'Added a personal note here' : null,
        tags: i % 4 == 0 ? [Tag(id: 'tag_$i', name: data['topic'] as String, color: '#8B7CF6')] : [],
        privacyLevel: 'full',
      ));
    }
    
    return entries.reversed.toList();
  }
  
  static List<VoiceEntry> voiceEntries = generateVoiceEntries();
  
  // Get today's entry
  static VoiceEntry? get todayEntry {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    try {
      return voiceEntries.firstWhere(
        (e) => DateTime(e.recordedAt.year, e.recordedAt.month, e.recordedAt.day) == today,
      );
    } catch (_) {
      return null;
    }
  }
  
  // Get this week's entries
  static List<VoiceEntry> get weekEntries {
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));
    return voiceEntries.where((e) => e.recordedAt.isAfter(weekAgo)).toList();
  }
  
  // Get entry for a specific date
  static VoiceEntry? getEntryForDate(DateTime date) {
    final targetDate = DateTime(date.year, date.month, date.day);
    try {
      return voiceEntries.firstWhere(
        (e) => DateTime(e.recordedAt.year, e.recordedAt.month, e.recordedAt.day) == targetDate,
      );
    } catch (_) {
      return null;
    }
  }
  
  // Insights
  static List<Insight> insights = [
    Insight(
      id: 'insight_001',
      userId: 'user_001',
      insightText: 'Your voice energy has been consistently higher in the mornings. Your most positive entries were on days you tagged "exercise". Consider morning workouts to boost your mood throughout the day.',
      insightType: 'weekly_summary',
      generatedAt: DateTime.now().subtract(const Duration(days: 1)),
      isRead: false,
    ),
    Insight(
      id: 'insight_002',
      userId: 'user_001',
      insightText: 'We noticed your energy levels drop on Monday mornings. This is common after weekends. Try a quick 5-minute energizing routine before your first check-in.',
      insightType: 'pattern_alert',
      generatedAt: DateTime.now().subtract(const Duration(days: 3)),
      isRead: true,
    ),
    Insight(
      id: 'insight_003',
      userId: 'user_001',
      insightText: 'Congratulations! You have completed 7 days of consistent check-ins. Keep up the great work!',
      insightType: 'achievement',
      generatedAt: DateTime.now().subtract(const Duration(days: 5)),
      isRead: true,
    ),
    Insight(
      id: 'insight_004',
      userId: 'user_001',
      insightText: 'Your most positive entries mention "family" and "friends". Social connections seem to boost your mood significantly.',
      insightType: 'tip',
      generatedAt: DateTime.now().subtract(const Duration(days: 7)),
      isRead: true,
    ),
  ];
  
  // Mood patterns
  static List<MoodPattern> patterns = [
    MoodPattern(
      id: 'pattern_001',
      patternType: 'weekly',
      description: 'Energy peaks on Tuesdays and Thursdays',
      confidence: 0.85,
      detectedAt: DateTime(2026, 1, 20),
    ),
    MoodPattern(
      id: 'pattern_002',
      patternType: 'time_of_day',
      description: 'Lower mood after 8pm consistently',
      confidence: 0.78,
      detectedAt: DateTime(2026, 1, 18),
    ),
    MoodPattern(
      id: 'pattern_003',
      patternType: 'tag_correlation',
      description: 'Exercise tags correlate with 23% higher mood scores',
      confidence: 0.92,
      detectedAt: DateTime(2026, 1, 15),
    ),
  ];
  
  // Weekly mood averages for charts
  static List<Map<String, dynamic>> weeklyMoodData = [
    {'day': 'Mon', 'score': 0.45, 'hasEntry': true},
    {'day': 'Tue', 'score': 0.72, 'hasEntry': true},
    {'day': 'Wed', 'score': 0.68, 'hasEntry': true},
    {'day': 'Thu', 'score': 0.55, 'hasEntry': true},
    {'day': 'Fri', 'score': 0.78, 'hasEntry': true},
    {'day': 'Sat', 'score': 0.82, 'hasEntry': true},
    {'day': 'Sun', 'score': 0.0, 'hasEntry': false},
  ];
  
  // Monthly trend data
  static List<Map<String, dynamic>> monthlyTrendData = List.generate(30, (index) {
    final score = 0.4 + (index % 7) * 0.08 + (index / 30) * 0.1;
    return {
      'day': index + 1,
      'score': score.clamp(0.0, 1.0),
      'hasEntry': index != 5 && index != 12 && index != 19,
    };
  });
}
