import 'package:flutter/material.dart';

class VoiceEntry {
  final String id;
  final String userId;
  final DateTime recordedAt;
  final String language;
  final String? audioUrl;
  final double durationSeconds;

  // Acoustic Features
  final double pitchMean;
  final double pitchStd;
  final double energyMean;
  final double tempo;
  final double silenceRatio;

  // Semantic Features
  final String? transcript;
  final List<String> emotionKeywords;
  final double? sentimentScore;
  final List<String> detectedEmotions;
  final String? topicContext;

  // Mood Scores
  final double acousticMoodScore;
  final double? semanticMoodScore;
  final double finalMoodScore;
  final String moodLabel;
  final double confidence;
  final double? signalAlignment;

  // User Input
  final String? note;
  final List<Tag> tags;
  final String privacyLevel;

  const VoiceEntry({
    required this.id,
    required this.userId,
    required this.recordedAt,
    this.language = 'en',
    this.audioUrl,
    required this.durationSeconds,
    required this.pitchMean,
    required this.pitchStd,
    required this.energyMean,
    required this.tempo,
    required this.silenceRatio,
    this.transcript,
    this.emotionKeywords = const [],
    this.sentimentScore,
    this.detectedEmotions = const [],
    this.topicContext,
    required this.acousticMoodScore,
    this.semanticMoodScore,
    required this.finalMoodScore,
    required this.moodLabel,
    required this.confidence,
    this.signalAlignment,
    this.note,
    this.tags = const [],
    this.privacyLevel = 'full',
  });

  // Get emoji based on mood score
  String get moodEmoji {
    if (finalMoodScore > 0.75) return '😊';
    if (finalMoodScore > 0.55) return '🙂';
    if (finalMoodScore > 0.45) return '😐';
    if (finalMoodScore > 0.25) return '😔';
    return '😢';
  }

  // Get mood display name
  String get moodDisplayName {
    if (finalMoodScore > 0.75) return 'Very Positive';
    if (finalMoodScore > 0.55) return 'Positive';
    if (finalMoodScore > 0.45) return 'Neutral';
    if (finalMoodScore > 0.25) return 'Low';
    return 'Very Low';
  }

  // Create a copy with updated values
  VoiceEntry copyWith({
    String? id,
    String? userId,
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
    List<Tag>? tags,
    String? privacyLevel,
  }) {
    return VoiceEntry(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      recordedAt: recordedAt ?? this.recordedAt,
      language: language ?? this.language,
      audioUrl: audioUrl ?? this.audioUrl,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      pitchMean: pitchMean ?? this.pitchMean,
      pitchStd: pitchStd ?? this.pitchStd,
      energyMean: energyMean ?? this.energyMean,
      tempo: tempo ?? this.tempo,
      silenceRatio: silenceRatio ?? this.silenceRatio,
      transcript: transcript ?? this.transcript,
      emotionKeywords: emotionKeywords ?? this.emotionKeywords,
      sentimentScore: sentimentScore ?? this.sentimentScore,
      detectedEmotions: detectedEmotions ?? this.detectedEmotions,
      topicContext: topicContext ?? this.topicContext,
      acousticMoodScore: acousticMoodScore ?? this.acousticMoodScore,
      semanticMoodScore: semanticMoodScore ?? this.semanticMoodScore,
      finalMoodScore: finalMoodScore ?? this.finalMoodScore,
      moodLabel: moodLabel ?? this.moodLabel,
      confidence: confidence ?? this.confidence,
      signalAlignment: signalAlignment ?? this.signalAlignment,
      note: note ?? this.note,
      tags: tags ?? this.tags,
      privacyLevel: privacyLevel ?? this.privacyLevel,
    );
  }
}

class User {
  final String id;
  final String email;
  final String name;
  final String? avatarUrl;
  final DateTime createdAt;
  final int totalCheckins;
  final int currentStreak;
  final double averageMood;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.avatarUrl,
    required this.createdAt,
    this.totalCheckins = 0,
    this.currentStreak = 0,
    this.averageMood = 0.5,
  });
}

class Insight {
  final String id;
  final String userId;
  final String insightText;
  final String insightType;
  final DateTime generatedAt;
  final bool isRead;

  const Insight({
    required this.id,
    required this.userId,
    required this.insightText,
    required this.insightType,
    required this.generatedAt,
    this.isRead = false,
  });

  Insight copyWith({
    String? id,
    String? userId,
    String? insightText,
    String? insightType,
    DateTime? generatedAt,
    bool? isRead,
  }) {
    return Insight(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      insightText: insightText ?? this.insightText,
      insightType: insightType ?? this.insightType,
      generatedAt: generatedAt ?? this.generatedAt,
      isRead: isRead ?? this.isRead,
    );
  }

  // Get icon based on insight type
  String get icon {
    switch (insightType) {
      case 'weekly_summary':
        return '📊';
      case 'pattern_alert':
        return '🔍';
      case 'tip':
        return '💡';
      case 'achievement':
        return '🏆';
      default:
        return '✨';
    }
  }
}

class MoodPattern {
  final String id;
  final String patternType;
  final String description;
  final double confidence;
  final DateTime detectedAt;

  const MoodPattern({
    required this.id,
    required this.patternType,
    required this.description,
    required this.confidence,
    required this.detectedAt,
  });
}

class Tag {
  final String id;
  final String name;
  final String color;
  final int usageCount;

  const Tag({
    required this.id,
    required this.name,
    required this.color,
    this.usageCount = 0,
  });
}

class UserSettings {
  final String userId;
  final TimeOfDay reminderTime;
  final bool reminderEnabled;
  final bool darkMode;
  final String uiLanguage;
  final String voiceLanguage;
  final String privacyLevel;
  final bool notificationsEnabled;

  const UserSettings({
    required this.userId,
    this.reminderTime = const TimeOfDay(hour: 9, minute: 0),
    this.reminderEnabled = true,
    this.darkMode = false,
    this.uiLanguage = 'en',
    this.voiceLanguage = 'en',
    this.privacyLevel = 'full',
    this.notificationsEnabled = true,
  });

  UserSettings copyWith({
    String? userId,
    TimeOfDay? reminderTime,
    bool? reminderEnabled,
    bool? darkMode,
    String? uiLanguage,
    String? voiceLanguage,
    String? privacyLevel,
    bool? notificationsEnabled,
  }) {
    return UserSettings(
      userId: userId ?? this.userId,
      reminderTime: reminderTime ?? this.reminderTime,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      darkMode: darkMode ?? this.darkMode,
      uiLanguage: uiLanguage ?? this.uiLanguage,
      voiceLanguage: voiceLanguage ?? this.voiceLanguage,
      privacyLevel: privacyLevel ?? this.privacyLevel,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}

/// Specific emotion detected from voice analysis
class Emotion {
  final String name;
  final String emoji;
  final double intensity; // 0.0 to 1.0
  final EmotionCategory category;
  final Color color;

  const Emotion({
    required this.name,
    required this.emoji,
    required this.intensity,
    required this.category,
    required this.color,
  });
}

/// Emotion categories for grouping
enum EmotionCategory {
  joy, // Happy, Excited, Content, Grateful, Hopeful
  calm, // Relaxed, Peaceful, Serene, Mindful
  energy, // Energetic, Motivated, Confident, Enthusiastic
  sadness, // Sad, Lonely, Disappointed, Melancholic
  anxiety, // Anxious, Worried, Stressed, Nervous, Overwhelmed
  anger, // Frustrated, Irritated, Annoyed
  neutral, // Neutral, Reflective, Contemplative
}

/// Pre-defined emotions library
class EmotionLibrary {
  static const List<Emotion> allEmotions = [
    // Joy emotions
    Emotion(
        name: 'Happy',
        emoji: '😊',
        intensity: 0.0,
        category: EmotionCategory.joy,
        color: Color(0xFFFFD93D)),
    Emotion(
        name: 'Excited',
        emoji: '🤩',
        intensity: 0.0,
        category: EmotionCategory.joy,
        color: Color(0xFFFF6B6B)),
    Emotion(
        name: 'Content',
        emoji: '😌',
        intensity: 0.0,
        category: EmotionCategory.joy,
        color: Color(0xFF98D8AA)),
    Emotion(
        name: 'Grateful',
        emoji: '🙏',
        intensity: 0.0,
        category: EmotionCategory.joy,
        color: Color(0xFFDDA0DD)),
    Emotion(
        name: 'Hopeful',
        emoji: '✨',
        intensity: 0.0,
        category: EmotionCategory.joy,
        color: Color(0xFFFFE5B4)),
    Emotion(
        name: 'Joyful',
        emoji: '😄',
        intensity: 0.0,
        category: EmotionCategory.joy,
        color: Color(0xFFFFD700)),
    Emotion(
        name: 'Proud',
        emoji: '😤',
        intensity: 0.0,
        category: EmotionCategory.joy,
        color: Color(0xFFE6A8D7)),
    Emotion(
        name: 'Loving',
        emoji: '🥰',
        intensity: 0.0,
        category: EmotionCategory.joy,
        color: Color(0xFFFF8FAB)),

    // Calm emotions
    Emotion(
        name: 'Calm',
        emoji: '😇',
        intensity: 0.0,
        category: EmotionCategory.calm,
        color: Color(0xFF7DD3C0)),
    Emotion(
        name: 'Relaxed',
        emoji: '😎',
        intensity: 0.0,
        category: EmotionCategory.calm,
        color: Color(0xFF87CEEB)),
    Emotion(
        name: 'Peaceful',
        emoji: '☮️',
        intensity: 0.0,
        category: EmotionCategory.calm,
        color: Color(0xFFB5EAD7)),
    Emotion(
        name: 'Serene',
        emoji: '🧘',
        intensity: 0.0,
        category: EmotionCategory.calm,
        color: Color(0xFFE2F0CB)),
    Emotion(
        name: 'Mindful',
        emoji: '🪷',
        intensity: 0.0,
        category: EmotionCategory.calm,
        color: Color(0xFFDCD0FF)),

    // Energy emotions
    Emotion(
        name: 'Energetic',
        emoji: '⚡',
        intensity: 0.0,
        category: EmotionCategory.energy,
        color: Color(0xFFFFE66D)),
    Emotion(
        name: 'Motivated',
        emoji: '💪',
        intensity: 0.0,
        category: EmotionCategory.energy,
        color: Color(0xFFFF9F43)),
    Emotion(
        name: 'Confident',
        emoji: '😏',
        intensity: 0.0,
        category: EmotionCategory.energy,
        color: Color(0xFFFECA57)),
    Emotion(
        name: 'Enthusiastic',
        emoji: '🔥',
        intensity: 0.0,
        category: EmotionCategory.energy,
        color: Color(0xFFFF6348)),
    Emotion(
        name: 'Determined',
        emoji: '🎯',
        intensity: 0.0,
        category: EmotionCategory.energy,
        color: Color(0xFFE74C3C)),

    // Sadness emotions
    Emotion(
        name: 'Sad',
        emoji: '😢',
        intensity: 0.0,
        category: EmotionCategory.sadness,
        color: Color(0xFF74B9FF)),
    Emotion(
        name: 'Lonely',
        emoji: '😔',
        intensity: 0.0,
        category: EmotionCategory.sadness,
        color: Color(0xFFA29BFE)),
    Emotion(
        name: 'Disappointed',
        emoji: '😞',
        intensity: 0.0,
        category: EmotionCategory.sadness,
        color: Color(0xFF636E72)),
    Emotion(
        name: 'Melancholic',
        emoji: '🥀',
        intensity: 0.0,
        category: EmotionCategory.sadness,
        color: Color(0xFF81ECEC)),
    Emotion(
        name: 'Down',
        emoji: '😿',
        intensity: 0.0,
        category: EmotionCategory.sadness,
        color: Color(0xFFB2BEC3)),

    // Anxiety emotions
    Emotion(
        name: 'Anxious',
        emoji: '😰',
        intensity: 0.0,
        category: EmotionCategory.anxiety,
        color: Color(0xFFFDCB6E)),
    Emotion(
        name: 'Worried',
        emoji: '😟',
        intensity: 0.0,
        category: EmotionCategory.anxiety,
        color: Color(0xFFE17055)),
    Emotion(
        name: 'Stressed',
        emoji: '😫',
        intensity: 0.0,
        category: EmotionCategory.anxiety,
        color: Color(0xFFD63031)),
    Emotion(
        name: 'Nervous',
        emoji: '😬',
        intensity: 0.0,
        category: EmotionCategory.anxiety,
        color: Color(0xFFFAB1A0)),
    Emotion(
        name: 'Overwhelmed',
        emoji: '🤯',
        intensity: 0.0,
        category: EmotionCategory.anxiety,
        color: Color(0xFFFF7675)),
    Emotion(
        name: 'Uncertain',
        emoji: '🤔',
        intensity: 0.0,
        category: EmotionCategory.anxiety,
        color: Color(0xFFDFE6E9)),

    // Anger emotions
    Emotion(
        name: 'Frustrated',
        emoji: '😤',
        intensity: 0.0,
        category: EmotionCategory.anger,
        color: Color(0xFFE74C3C)),
    Emotion(
        name: 'Irritated',
        emoji: '😒',
        intensity: 0.0,
        category: EmotionCategory.anger,
        color: Color(0xFFE55039)),
    Emotion(
        name: 'Annoyed',
        emoji: '🙄',
        intensity: 0.0,
        category: EmotionCategory.anger,
        color: Color(0xFFEB4D4B)),
    Emotion(
        name: 'Angry',
        emoji: '😠',
        intensity: 0.0,
        category: EmotionCategory.anger,
        color: Color(0xFFC0392B)),

    // Neutral emotions
    Emotion(
        name: 'Neutral',
        emoji: '😐',
        intensity: 0.0,
        category: EmotionCategory.neutral,
        color: Color(0xFFBDC3C7)),
    Emotion(
        name: 'Reflective',
        emoji: '🤔',
        intensity: 0.0,
        category: EmotionCategory.neutral,
        color: Color(0xFF95A5A6)),
    Emotion(
        name: 'Contemplative',
        emoji: '💭',
        intensity: 0.0,
        category: EmotionCategory.neutral,
        color: Color(0xFF7F8C8D)),
    Emotion(
        name: 'Tired',
        emoji: '😴',
        intensity: 0.0,
        category: EmotionCategory.neutral,
        color: Color(0xFFD5DBDB)),
  ];

  /// Get emotions based on mood score - simulates voice analysis
  static List<Emotion> getEmotionsForMoodScore(double moodScore,
      {int count = 3}) {
    List<Emotion> candidates = [];

    if (moodScore >= 0.8) {
      // Very positive - joy and energy emotions
      candidates = allEmotions
          .where((e) =>
              e.category == EmotionCategory.joy ||
              e.category == EmotionCategory.energy)
          .toList();
    } else if (moodScore >= 0.6) {
      // Positive - joy, calm emotions
      candidates = allEmotions
          .where((e) =>
              e.category == EmotionCategory.joy ||
              e.category == EmotionCategory.calm)
          .toList();
    } else if (moodScore >= 0.45) {
      // Neutral - calm and neutral emotions
      candidates = allEmotions
          .where((e) =>
              e.category == EmotionCategory.neutral ||
              e.category == EmotionCategory.calm)
          .toList();
    } else if (moodScore >= 0.3) {
      // Low - sadness and anxiety emotions
      candidates = allEmotions
          .where((e) =>
              e.category == EmotionCategory.sadness ||
              e.category == EmotionCategory.anxiety)
          .toList();
    } else {
      // Very low - sadness, anxiety, anger
      candidates = allEmotions
          .where((e) =>
              e.category == EmotionCategory.sadness ||
              e.category == EmotionCategory.anxiety ||
              e.category == EmotionCategory.anger)
          .toList();
    }

    // Shuffle and take count
    candidates.shuffle();
    final selected = candidates.take(count).toList();

    // Create new instances with random intensity
    return selected
        .map((e) => Emotion(
              name: e.name,
              emoji: e.emoji,
              intensity: 0.5 + (moodScore * 0.5), // Scale with mood
              category: e.category,
              color: e.color,
            ))
        .toList();
  }

  /// Get a single emotion by name
  static Emotion? getByName(String name) {
    try {
      return allEmotions
          .firstWhere((e) => e.name.toLowerCase() == name.toLowerCase());
    } catch (_) {
      return null;
    }
  }
}

/// Quick action the user can take
class QuickAction {
  final String id;
  final String label;
  final String emoji;
  final String
      actionType; // 'breathing', 'journal', 'music', 'call', 'gratitude', 'walk', 'meditate'
  final Color color;

  const QuickAction({
    required this.id,
    required this.label,
    required this.emoji,
    required this.actionType,
    required this.color,
  });
}

/// Personalized response based on detected emotions
class PersonalizedResponse {
  final String headline;
  final String message;
  final String emoji;
  final List<String> suggestions;
  final List<QuickAction> quickActions;
  final Color accentColor;

  const PersonalizedResponse({
    required this.headline,
    required this.message,
    required this.emoji,
    required this.suggestions,
    required this.quickActions,
    required this.accentColor,
  });

  /// Generate a personalized response based on emotions and mood
  static PersonalizedResponse generate(
      List<Emotion> emotions, double moodScore) {
    if (emotions.isEmpty) {
      return _neutralResponse();
    }

    // Find the dominant emotion category
    final categoryCount = <EmotionCategory, int>{};
    for (final emotion in emotions) {
      categoryCount[emotion.category] =
          (categoryCount[emotion.category] ?? 0) + 1;
    }

    EmotionCategory dominant = EmotionCategory.neutral;
    int maxCount = 0;
    categoryCount.forEach((category, count) {
      if (count > maxCount) {
        maxCount = count;
        dominant = category;
      }
    });

    // Get primary emotion for emoji
    final primaryEmotion = emotions.first;

    switch (dominant) {
      case EmotionCategory.joy:
        return PersonalizedResponse(
          headline: "You're radiating positivity! ✨",
          message:
              "It's wonderful to hear the joy in your voice. These positive feelings are worth celebrating. Consider sharing this energy with someone you care about.",
          emoji: primaryEmotion.emoji,
          suggestions: [
            "Share this moment with a loved one",
            "Write down what made you feel this way",
            "Take a photo to remember this feeling",
            "Pay it forward with a kind gesture",
          ],
          quickActions: [
            const QuickAction(
                id: 'gratitude',
                label: 'Gratitude Journal',
                emoji: '🙏',
                actionType: 'gratitude',
                color: Color(0xFFDDA0DD)),
            const QuickAction(
                id: 'journal',
                label: 'Journal',
                emoji: '📓',
                actionType: 'journal',
                color: Color(0xFF7DD3C0)),
            const QuickAction(
                id: 'music',
                label: 'Happy Music',
                emoji: '🎵',
                actionType: 'music',
                color: Color(0xFFFFD93D)),
          ],
          accentColor: const Color(0xFFFFD93D),
        );

      case EmotionCategory.calm:
        return PersonalizedResponse(
          headline: "A peaceful moment 🧘",
          message:
              "You sound centered and at peace. This calm state of mind is precious. Take a moment to fully embrace this tranquility.",
          emoji: primaryEmotion.emoji,
          suggestions: [
            "Practice mindful breathing to deepen this calm",
            "Do some gentle stretching",
            "Enjoy a warm cup of tea",
            "Write in your journal about this peaceful moment",
          ],
          quickActions: [
            const QuickAction(
                id: 'breathing',
                label: 'Deep Breathing',
                emoji: '🌬️',
                actionType: 'breathing',
                color: Color(0xFF7DD3C0)),
            const QuickAction(
                id: 'journal',
                label: 'Journal',
                emoji: '📓',
                actionType: 'journal',
                color: Color(0xFF87CEEB)),
            const QuickAction(
                id: 'meditate',
                label: 'Meditate',
                emoji: '🧘',
                actionType: 'meditate',
                color: Color(0xFFDCD0FF)),
          ],
          accentColor: const Color(0xFF7DD3C0),
        );

      case EmotionCategory.energy:
        return PersonalizedResponse(
          headline: "You're on fire! 🔥",
          message:
              "Your energy and motivation are coming through loud and clear. This is the perfect time to tackle something meaningful or start that project you've been thinking about.",
          emoji: primaryEmotion.emoji,
          suggestions: [
            "Channel this energy into a goal",
            "Go for a energizing workout",
            "Start that project you've been postponing",
            "Connect with others who inspire you",
          ],
          quickActions: [
            const QuickAction(
                id: 'goals',
                label: 'Set a Goal',
                emoji: '🎯',
                actionType: 'goals',
                color: Color(0xFFFF9F43)),
            const QuickAction(
                id: 'workout',
                label: 'Quick Workout',
                emoji: '💪',
                actionType: 'workout',
                color: Color(0xFFE74C3C)),
            const QuickAction(
                id: 'music',
                label: 'Energizing Music',
                emoji: '🎵',
                actionType: 'music',
                color: Color(0xFFFECA57)),
          ],
          accentColor: const Color(0xFFFF9F43),
        );

      case EmotionCategory.sadness:
        return PersonalizedResponse(
          headline: "I hear you 💙",
          message:
              "It sounds like you're going through a difficult time. Remember, it's okay to feel sad - these feelings are valid and they will pass. You don't have to face this alone.",
          emoji: primaryEmotion.emoji,
          suggestions: [
            "Take three deep, slow breaths",
            "Reach out to someone you trust",
            "Go for a gentle walk outside",
            "Listen to music that comforts you",
            "Write down your thoughts",
          ],
          quickActions: [
            const QuickAction(
                id: 'breathing',
                label: 'Breathing Exercise',
                emoji: '🌬️',
                actionType: 'breathing',
                color: Color(0xFF74B9FF)),
            const QuickAction(
                id: 'call',
                label: 'Call Someone',
                emoji: '📞',
                actionType: 'call',
                color: Color(0xFFA29BFE)),
            const QuickAction(
                id: 'music',
                label: 'Calming Music',
                emoji: '🎵',
                actionType: 'music',
                color: Color(0xFF81ECEC)),
            const QuickAction(
                id: 'workout',
                label: 'Gentle Walk',
                emoji: '🚶',
                actionType: 'workout',
                color: Color(0xFF98D8AA)),
          ],
          accentColor: const Color(0xFF74B9FF),
        );

      case EmotionCategory.anxiety:
        return PersonalizedResponse(
          headline: "Let's slow down together 🌿",
          message:
              "I can sense some tension in your voice. That's completely understandable - life can be overwhelming. Let's take a moment to ground yourself and find some calm.",
          emoji: primaryEmotion.emoji,
          suggestions: [
            "Try the 4-7-8 breathing technique",
            "Name 5 things you can see around you",
            "Drink a glass of water slowly",
            "Step outside for fresh air",
            "Unclench your jaw and relax your shoulders",
          ],
          quickActions: [
            const QuickAction(
                id: 'breathing',
                label: '4-7-8 Breathing',
                emoji: '🌬️',
                actionType: 'breathing',
                color: Color(0xFFFDCB6E)),
            const QuickAction(
                id: 'music',
                label: 'Calm Sounds',
                emoji: '🎶',
                actionType: 'music',
                color: Color(0xFF98D8AA)),
            const QuickAction(
                id: 'meditate',
                label: '5-Min Calm',
                emoji: '🧘',
                actionType: 'meditate',
                color: Color(0xFFDCD0FF)),
            const QuickAction(
                id: 'journal',
                label: 'Write It Out',
                emoji: '📝',
                actionType: 'journal',
                color: Color(0xFF87CEEB)),
          ],
          accentColor: const Color(0xFFFDCB6E),
        );

      case EmotionCategory.anger:
        return PersonalizedResponse(
          headline: "Your feelings matter 💪",
          message:
              "I can hear some frustration coming through. It's healthy to acknowledge these feelings rather than suppress them. Let's find a constructive way to process this energy.",
          emoji: primaryEmotion.emoji,
          suggestions: [
            "Take 10 deep breaths before reacting",
            "Do some physical exercise to release tension",
            "Write down what's bothering you",
            "Step away from the situation briefly",
            "Talk to someone you trust",
          ],
          quickActions: [
            const QuickAction(
                id: 'breathing',
                label: 'Cool Down',
                emoji: '❄️',
                actionType: 'breathing',
                color: Color(0xFF74B9FF)),
            const QuickAction(
                id: 'workout',
                label: 'Release Energy',
                emoji: '🏃',
                actionType: 'workout',
                color: Color(0xFFE74C3C)),
            const QuickAction(
                id: 'journal',
                label: 'Vent Journal',
                emoji: '📝',
                actionType: 'journal',
                color: Color(0xFFEB4D4B)),
          ],
          accentColor: const Color(0xFFE74C3C),
        );

      case EmotionCategory.neutral:
        return _neutralResponse();
    }
  }

  static PersonalizedResponse _neutralResponse() {
    return const PersonalizedResponse(
      headline: "A moment of reflection 💭",
      message:
          "You seem to be in a contemplative state. This is a good time for self-reflection or simply being present in the moment.",
      emoji: "💭",
      suggestions: [
        "Take a mindful moment",
        "Write down your current thoughts",
        "Plan something you're looking forward to",
        "Practice gratitude for small things",
      ],
      quickActions: [
        QuickAction(
            id: 'journal',
            label: 'Reflect',
            emoji: '📓',
            actionType: 'journal',
            color: Color(0xFF95A5A6)),
        QuickAction(
            id: 'gratitude',
            label: 'Gratitude',
            emoji: '🙏',
            actionType: 'gratitude',
            color: Color(0xFFDDA0DD)),
        QuickAction(
            id: 'breathing',
            label: 'Be Present',
            emoji: '🧘',
            actionType: 'breathing',
            color: Color(0xFF7DD3C0)),
      ],
      accentColor: Color(0xFF95A5A6),
    );
  }
}

// Journal Entry Model
class JournalEntry {
  final String id;
  final DateTime createdAt;
  final String content;
  final String prompt;
  final String? moodAtTime; // Optional mood context

  const JournalEntry({
    required this.id,
    required this.createdAt,
    required this.content,
    required this.prompt,
    this.moodAtTime,
  });

  JournalEntry copyWith({
    String? id,
    DateTime? createdAt,
    String? content,
    String? prompt,
    String? moodAtTime,
  }) {
    return JournalEntry(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      content: content ?? this.content,
      prompt: prompt ?? this.prompt,
      moodAtTime: moodAtTime ?? this.moodAtTime,
    );
  }
}

// Gratitude Entry Model
class GratitudeEntry {
  final String id;
  final DateTime createdAt;
  final List<String> items; // The 3 gratitude items

  const GratitudeEntry({
    required this.id,
    required this.createdAt,
    required this.items,
  });

  GratitudeEntry copyWith({
    String? id,
    DateTime? createdAt,
    List<String>? items,
  }) {
    return GratitudeEntry(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      items: items ?? this.items,
    );
  }
}

// Wellness Goal Model
class WellnessGoal {
  final String id;
  final DateTime createdAt;
  final String title;
  final String emoji;
  final bool isCompleted;
  final DateTime? completedAt;

  const WellnessGoal({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.emoji,
    this.isCompleted = false,
    this.completedAt,
  });

  WellnessGoal copyWith({
    String? id,
    DateTime? createdAt,
    String? title,
    String? emoji,
    bool? isCompleted,
    DateTime? completedAt,
  }) {
    return WellnessGoal(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      emoji: emoji ?? this.emoji,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}

// Favorite Contact Model
class FavoriteContact {
  final String id;
  final DateTime createdAt;
  final String name;
  final String emoji;
  final String type; // Family, Friend, Professional, etc.
  final String? phone;

  const FavoriteContact({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.emoji,
    required this.type,
    this.phone,
  });

  FavoriteContact copyWith({
    String? id,
    DateTime? createdAt,
    String? name,
    String? emoji,
    String? type,
    String? phone,
  }) {
    return FavoriteContact(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      type: type ?? this.type,
      phone: phone ?? this.phone,
    );
  }
}
