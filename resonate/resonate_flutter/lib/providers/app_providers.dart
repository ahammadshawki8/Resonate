import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/models.dart';
import '../data/dummy_data.dart';

/// Auth State
enum AuthStatus { initial, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final User? user;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  Future<void> checkAuthStatus() async {
    // Simulate checking stored auth
    await Future.delayed(const Duration(milliseconds: 500));
    // For demo, start as unauthenticated
    state = state.copyWith(status: AuthStatus.unauthenticated);
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    await Future.delayed(const Duration(seconds: 1));

    // Simulate login success
    state = state.copyWith(
      status: AuthStatus.authenticated,
      user: DummyData.currentUser,
      isLoading: false,
    );
    return true;
  }

  Future<bool> signup(String name, String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    await Future.delayed(const Duration(seconds: 1));

    // Create new user
    final newUser = User(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      name: name,
      createdAt: DateTime.now(),
      totalCheckins: 0,
      currentStreak: 0,
      averageMood: 0.0,
    );

    state = state.copyWith(
      status: AuthStatus.authenticated,
      user: newUser,
      isLoading: false,
    );
    return true;
  }

  void logout() {
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  void updateUser(User user) {
    state = state.copyWith(user: user);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

// Convenience provider to get the current user
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authProvider).user;
});

// Provider to check if user is authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).status == AuthStatus.authenticated;
});

/// Voice Entries State
class EntriesNotifier extends StateNotifier<List<VoiceEntry>> {
  EntriesNotifier() : super(DummyData.generateVoiceEntries());

  void addEntry(VoiceEntry entry) {
    state = [entry, ...state];
  }

  void updateEntry(String id, VoiceEntry entry) {
    state = state.map((e) => e.id == id ? entry : e).toList();
  }

  void deleteEntry(String id) {
    state = state.where((e) => e.id != id).toList();
  }

  VoiceEntry? getEntryById(String id) {
    try {
      return state.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  VoiceEntry? getTodayEntry() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    try {
      return state.firstWhere(
        (e) =>
            DateTime(e.recordedAt.year, e.recordedAt.month, e.recordedAt.day) ==
            today,
      );
    } catch (_) {
      return null;
    }
  }

  List<VoiceEntry> getWeekEntries() {
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));
    return state.where((e) => e.recordedAt.isAfter(weekAgo)).toList();
  }

  VoiceEntry? getEntryForDate(DateTime date) {
    final targetDate = DateTime(date.year, date.month, date.day);
    try {
      return state.firstWhere(
        (e) =>
            DateTime(e.recordedAt.year, e.recordedAt.month, e.recordedAt.day) ==
            targetDate,
      );
    } catch (_) {
      return null;
    }
  }

  void clearAll() {
    state = [];
  }

  List<Map<String, dynamic>> getWeeklyMoodData() {
    final now = DateTime.now();
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final result = <Map<String, dynamic>>[];

    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final entry = getEntryForDate(date);
      final dayIndex = date.weekday - 1;
      result.add({
        'day': days[dayIndex],
        'score': entry?.finalMoodScore ?? 0.0,
        'hasEntry': entry != null,
      });
    }

    return result;
  }
}

final entriesProvider =
    StateNotifierProvider<EntriesNotifier, List<VoiceEntry>>((ref) {
  return EntriesNotifier();
});

/// Insights State
class InsightsNotifier extends StateNotifier<List<Insight>> {
  InsightsNotifier() : super(DummyData.insights);

  void markAsRead(String id) {
    state =
        state.map((i) => i.id == id ? i.copyWith(isRead: true) : i).toList();
  }

  void markAllAsRead() {
    state = state.map((i) => i.copyWith(isRead: true)).toList();
  }

  void addInsight(Insight insight) {
    state = [insight, ...state];
  }

  void clearAll() {
    state = [];
  }

  int get unreadCount => state.where((i) => !i.isRead).length;
}

final insightsProvider =
    StateNotifierProvider<InsightsNotifier, List<Insight>>((ref) {
  return InsightsNotifier();
});

/// User Settings State
class SettingsNotifier extends StateNotifier<UserSettings> {
  SettingsNotifier() : super(DummyData.userSettings);

  void updateReminderTime(TimeOfDay time) {
    state = state.copyWith(reminderTime: time);
  }

  void setReminderTime(TimeOfDay time) {
    state = state.copyWith(reminderTime: time);
  }

  void toggleReminders(bool enabled) {
    state = state.copyWith(reminderEnabled: enabled);
  }

  void toggleDarkMode(bool enabled) {
    state = state.copyWith(darkMode: enabled);
  }

  void toggleNotifications(bool enabled) {
    state = state.copyWith(notificationsEnabled: enabled);
  }

  void setVoiceLanguage(String language) {
    state = state.copyWith(voiceLanguage: language);
  }

  void setPrivacyLevel(String level) {
    state = state.copyWith(privacyLevel: level);
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, UserSettings>((ref) {
  return SettingsNotifier();
});

/// Tags State
final tagsProvider = StateProvider<List<Tag>>((ref) => DummyData.tags);

/// Patterns State
final patternsProvider =
    StateProvider<List<MoodPattern>>((ref) => DummyData.patterns);

/// Recording State
class RecordingState {
  final bool isRecording;
  final bool isAnalyzing;
  final int durationSeconds;
  final String language;
  final List<double> waveformData;

  const RecordingState({
    this.isRecording = false,
    this.isAnalyzing = false,
    this.durationSeconds = 0,
    this.language = 'en',
    this.waveformData = const [],
  });

  RecordingState copyWith({
    bool? isRecording,
    bool? isAnalyzing,
    int? durationSeconds,
    String? language,
    List<double>? waveformData,
  }) {
    return RecordingState(
      isRecording: isRecording ?? this.isRecording,
      isAnalyzing: isAnalyzing ?? this.isAnalyzing,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      language: language ?? this.language,
      waveformData: waveformData ?? this.waveformData,
    );
  }
}

class RecordingNotifier extends StateNotifier<RecordingState> {
  RecordingNotifier() : super(const RecordingState());

  void startRecording() {
    state = state.copyWith(
      isRecording: true,
      durationSeconds: 0,
      waveformData: [],
    );
  }

  void updateDuration(int seconds) {
    state = state.copyWith(durationSeconds: seconds);
  }

  void addWaveformData(List<double> data) {
    state = state.copyWith(waveformData: [...state.waveformData, ...data]);
  }

  void stopRecording() {
    state = state.copyWith(isRecording: false);
  }

  void startAnalyzing() {
    state = state.copyWith(isAnalyzing: true);
  }

  void finishAnalyzing() {
    state = state.copyWith(isAnalyzing: false);
  }

  void setLanguage(String language) {
    state = state.copyWith(language: language);
  }

  void reset() {
    state = const RecordingState();
  }
}

final recordingProvider =
    StateNotifierProvider<RecordingNotifier, RecordingState>((ref) {
  return RecordingNotifier();
});

/// Last Analysis Result (to pass between screens)
class AnalysisResult {
  final double moodScore;
  final String moodLabel;
  final String transcript;
  final List<String>
      emotions; // Simple emotion names for backward compatibility
  final List<Emotion>
      detailedEmotions; // Rich emotion data with emoji, intensity, etc.
  final PersonalizedResponse?
      personalizedResponse; // Personalized response based on emotions
  final double confidence;
  final double acousticScore;
  final double semanticScore;
  final String language;
  final double duration;

  const AnalysisResult({
    required this.moodScore,
    required this.moodLabel,
    required this.transcript,
    required this.emotions,
    this.detailedEmotions = const [],
    this.personalizedResponse,
    required this.confidence,
    required this.acousticScore,
    required this.semanticScore,
    required this.language,
    required this.duration,
  });
}

final analysisResultProvider = StateProvider<AnalysisResult?>((ref) => null);

/// Journal Entries Provider
class JournalNotifier extends StateNotifier<List<JournalEntry>> {
  JournalNotifier() : super([]);

  void addEntry(JournalEntry entry) {
    state = [entry, ...state];
  }

  void deleteEntry(String id) {
    state = state.where((e) => e.id != id).toList();
  }
}

final journalProvider = StateNotifierProvider<JournalNotifier, List<JournalEntry>>((ref) {
  return JournalNotifier();
});

/// Gratitude Entries Provider
class GratitudeNotifier extends StateNotifier<List<GratitudeEntry>> {
  GratitudeNotifier() : super([]);

  void addEntry(GratitudeEntry entry) {
    state = [entry, ...state];
  }

  void deleteEntry(String id) {
    state = state.where((e) => e.id != id).toList();
  }
}

final gratitudeProvider = StateNotifierProvider<GratitudeNotifier, List<GratitudeEntry>>((ref) {
  return GratitudeNotifier();
});

/// Onboarding completion state
final hasSeenOnboardingProvider = StateProvider<bool>((ref) => false);

/// Selected date for calendar
final selectedCalendarDateProvider = StateProvider<DateTime?>((ref) => null);

/// Selected trend period
final selectedTrendPeriodProvider = StateProvider<String>((ref) => 'Week');
