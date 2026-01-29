import '../core/services/auth_service.dart';
import '../core/services/notification_service.dart';
import '../data/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/models.dart';


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
    state = state.copyWith(isLoading: true);
    final isSignedIn = AuthService.instance.isSignedIn;
    if (isSignedIn) {
      try {
        final profile = await UserProfileRepository.instance.getProfile();
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: profile.toUser(),
          isLoading: false,
        );
      } catch (e) {
        state = state.copyWith(status: AuthStatus.unauthenticated, isLoading: false);
      }
    } else {
      state = state.copyWith(status: AuthStatus.unauthenticated, isLoading: false);
    }
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await AuthService.instance.signInWithEmail(email: email, password: password);
      if (result.isSuccess) {
        final profile = await UserProfileRepository.instance.getProfile();
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: profile.toUser(),
          isLoading: false,
        );
        return true;
      } else {
        state = state.copyWith(isLoading: false, error: result.message ?? 'Login failed');
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> signup(String email, String password, {String? verificationCode}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      if (verificationCode == null) {
        // Step 1: Start registration (sends code)
        final result = await AuthService.instance.signUpWithEmail(email: email);
        if (result.isPendingVerification) {
          state = state.copyWith(isLoading: false, error: result.message);
          return false;
        } else if (result.isSuccess) {
          // Should not happen, registration requires verification
          state = state.copyWith(isLoading: false);
          return true;
        } else {
          state = state.copyWith(isLoading: false, error: result.message ?? 'Signup failed');
          return false;
        }
      } else {
        // Step 2: Verify code and complete registration
        final verifyResult = await AuthService.instance.verifyEmailRegistration(code: verificationCode);
        if (verifyResult.isPendingPassword) {
          // Now set password
          final completeResult = await AuthService.instance.completeRegistration(password: password);
          if (completeResult.isSuccess) {
            final profile = await UserProfileRepository.instance.getProfile();
            state = state.copyWith(
              status: AuthStatus.authenticated,
              user: profile.toUser(),
              isLoading: false,
            );
            return true;
          } else {
            state = state.copyWith(isLoading: false, error: completeResult.message ?? 'Signup failed');
            return false;
          }
        } else {
          state = state.copyWith(isLoading: false, error: verifyResult.message ?? 'Verification failed');
          return false;
        }
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }
  void logout() async {
    await AuthService.instance.signOut();
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
  EntriesNotifier(this.ref) : super([]);
  
  final Ref ref;

  Future<void> fetchEntries() async {
    // Only fetch if authenticated
    if (!ref.read(isAuthenticatedProvider)) return;
    
    try {
      final entries = await VoiceEntryRepository.instance.getEntries();
      state = entries.map((e) => e.toVoiceEntry()).toList();
    } catch (e) {
      // Handle error silently - user might not be authenticated
    }
  }

  void addEntry(VoiceEntry entry) {
    state = [entry, ...state];
  }

  void updateEntry(String id, VoiceEntry entry) {
    state = state.map((e) => e.id == id ? entry : e).toList();
  }

  Future<void> deleteEntry(String id) async {
    // Delete from backend first
    try {
      final intId = int.parse(id);
      final success = await VoiceEntryRepository.instance.deleteEntry(intId);
      
      if (success) {
        // Update local state only if backend deletion succeeded
        state = state.where((e) => e.id != id).toList();
      }
    } catch (e) {
      debugPrint('Error deleting voice entry: $e');
      rethrow;
    }
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
  return EntriesNotifier(ref);
});

/// Insights State
class InsightsNotifier extends StateNotifier<List<Insight>> {
  InsightsNotifier(this.ref) : super([]);
  
  final Ref ref;

  Future<void> fetchInsights() async {
    // Only fetch if authenticated
    if (!ref.read(isAuthenticatedProvider)) return;
    
    try {
      final insights = await InsightRepository.instance.getInsights();
      state = insights.map((i) => i.toInsight()).toList();
    } catch (e) {
      // Handle error silently - user might not be authenticated
    }
  }

  void markAsRead(String id) {
    state =
        state.map((i) => i.id == id ? i.copyWith(isRead: true) : i).toList();
  }

  void markAllAsRead() {
    state = state.map((i) => i.copyWith(isRead: true)).toList();
  }

  Future<void> addInsight(Insight insight) async {
    // Add to local state immediately
    state = [insight, ...state];
    
    // Save to database if authenticated
    if (ref.read(isAuthenticatedProvider)) {
      try {
        await InsightRepository.instance.createInsight(
          insightText: insight.insightText,
          insightType: insight.insightType,
        );
      } catch (e) {
        // If save fails, keep in local state anyway
        debugPrint('Failed to save insight to database: $e');
      }
    }
  }

  void clearAll() {
    state = [];
  }

  int get unreadCount => state.where((i) => !i.isRead).length;
}

final insightsProvider =
    StateNotifierProvider<InsightsNotifier, List<Insight>>((ref) {
  return InsightsNotifier(ref);
});

/// User Settings State
class SettingsNotifier extends StateNotifier<UserSettings> {
  SettingsNotifier(this.ref) : super(UserSettingsEmpty.empty());
  
  final Ref ref;

  Future<void> fetchSettings() async {
    // Only fetch if authenticated
    if (!ref.read(isAuthenticatedProvider)) return;
    
    try {
      final settings = await SettingsRepository.instance.getSettings();
      state = settings.toUserSettings();
    } catch (e) {
      // User not authenticated yet, keep default settings
      // Settings will be fetched after successful login
    }
  }

  void updateReminderTime(TimeOfDay time) {
    state = state.copyWith(reminderTime: time);
  }

  Future<void> setReminderTime(TimeOfDay time) async {
    state = state.copyWith(reminderTime: time);
    
    // If reminders are enabled, reschedule with new time
    if (state.reminderEnabled) {
      await _scheduleReminder(time);
    }
  }

  Future<void> toggleReminders(bool enabled) async {
    state = state.copyWith(reminderEnabled: enabled);
    
    if (enabled) {
      // Schedule reminder
      await _scheduleReminder(state.reminderTime);
    } else {
      // Cancel reminder
      await NotificationService().cancelDailyReminder();
    }
  }

  Future<void> _scheduleReminder(TimeOfDay time) async {
    final notificationService = NotificationService();
    await notificationService.initialize();
    
    // Request permissions if not granted
    final granted = await notificationService.requestPermissions();
    if (!granted) {
      // Show error or disable reminders
      state = state.copyWith(reminderEnabled: false);
      return;
    }
    
    await notificationService.scheduleDailyReminder(
      hour: time.hour,
      minute: time.minute,
    );
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
  return SettingsNotifier(ref);
});

/// Tags State
final tagsProvider = FutureProvider<List<Tag>>((ref) async {
  final tags = await TagRepository.instance.getTags();
  return tags.map((t) => t.toTag()).toList();
});

/// Patterns State
final patternsProvider = FutureProvider<List<MoodPattern>>((ref) async {
  final patterns = await AnalyticsRepository.instance.getPatterns();
  return patterns.map((p) => p.toMoodPattern()).toList();
});

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

  Future<void> addEntry(JournalEntry entry) async {
    // Add to local state immediately for UI responsiveness
    state = [entry, ...state];
    
    // Save to database asynchronously
    try {
      await WellnessRepository.instance.createJournal(
        content: entry.content,
        prompt: entry.prompt,
        moodAtTime: entry.moodAtTime,
      );
    } catch (e) {
      print('Error saving journal to database: $e');
    }
  }

  Future<void> deleteEntry(String id) async {
    // Delete from backend first
    try {
      final intId = int.parse(id);
      final success = await WellnessRepository.instance.deleteJournal(intId);
      
      if (success) {
        // Update local state only if backend deletion succeeded
        state = state.where((e) => e.id != id).toList();
      }
    } catch (e) {
      debugPrint('Error deleting journal entry: $e');
      rethrow;
    }
  }
  
  void clearAll() {
    state = [];
  }
  
  Future<void> loadEntries() async {
    try {
      final entries = await WellnessRepository.instance.getJournals(limit: 50);
      state = entries.map((e) => e.toLocal()).toList();
    } catch (e) {
      print('Error loading journals: $e');
    }
  }
}

final journalProvider = StateNotifierProvider<JournalNotifier, List<JournalEntry>>((ref) {
  final notifier = JournalNotifier();
  notifier.loadEntries(); // Load from database on init
  return notifier;
});

/// Gratitude Entries Provider
class GratitudeNotifier extends StateNotifier<List<GratitudeEntry>> {
  GratitudeNotifier() : super([]);

  Future<void> addEntry(GratitudeEntry entry) async {
    // Add to local state immediately for UI responsiveness
    state = [entry, ...state];
    
    // Save to database asynchronously
    try {
      await WellnessRepository.instance.createGratitude(
        items: entry.items,
      );
    } catch (e) {
      print('Error saving gratitude to database: $e');
    }
  }

  Future<void> deleteEntry(String id) async {
    // Delete from backend first
    try {
      final intId = int.parse(id);
      final success = await WellnessRepository.instance.deleteGratitude(intId);
      
      if (success) {
        // Update local state only if backend deletion succeeded
        state = state.where((e) => e.id != id).toList();
      }
    } catch (e) {
      debugPrint('Error deleting gratitude entry: $e');
      rethrow;
    }
  }
  
  void clearAll() {
    state = [];
  }
  
  Future<void> loadEntries() async {
    try {
      final entries = await WellnessRepository.instance.getGratitudes(limit: 50);
      state = entries.map((e) => e.toLocal()).toList();
    } catch (e) {
      print('Error loading gratitudes: $e');
    }
  }
}

final gratitudeProvider = StateNotifierProvider<GratitudeNotifier, List<GratitudeEntry>>((ref) {
  final notifier = GratitudeNotifier();
  notifier.loadEntries(); // Load from database on init
  return notifier;
});

/// Wellness Goals Provider
class WellnessGoalNotifier extends StateNotifier<List<WellnessGoal>> {
  WellnessGoalNotifier() : super([]);

  Future<void> addGoal(WellnessGoal goal) async {
    // Check if goal already exists (by title)
    final exists = state.any((g) => g.title == goal.title && !g.isCompleted);
    if (!exists) {
      // Add to local state immediately for UI responsiveness
      state = [goal, ...state];
      
      // Save to database asynchronously
      try {
        await WellnessRepository.instance.createGoal(
          title: goal.title,
          emoji: goal.emoji,
        );
      } catch (e) {
        print('Error saving goal to database: $e');
      }
    }
  }

  Future<void> toggleGoal(String id) async {
    // Update local state immediately
    state = state.map((g) {
      if (g.id == id) {
        return g.copyWith(
          isCompleted: !g.isCompleted,
          completedAt: !g.isCompleted ? DateTime.now() : null,
        );
      }
      return g;
    }).toList();
    
    // Update database asynchronously
    try {
      final goalIdInt = int.tryParse(id);
      if (goalIdInt != null) {
        await WellnessRepository.instance.toggleGoal(goalIdInt);
      }
    } catch (e) {
      print('Error toggling goal in database: $e');
    }
  }

  void deleteGoal(String id) {
    state = state.where((g) => g.id != id).toList();
  }
  
  void clearAll() {
    state = [];
  }
  
  Future<void> loadGoals() async {
    try {
      final goals = await WellnessRepository.instance.getGoals();
      state = goals.map((g) => g.toLocal()).toList();
    } catch (e) {
      print('Error loading goals: $e');
    }
  }
}

final wellnessGoalProvider = StateNotifierProvider<WellnessGoalNotifier, List<WellnessGoal>>((ref) {
  final notifier = WellnessGoalNotifier();
  notifier.loadGoals(); // Load from database on init
  return notifier;
});

/// Favorite Contacts Provider
class FavoriteContactNotifier extends StateNotifier<List<FavoriteContact>> {
  FavoriteContactNotifier() : super([]);

  static const int maxContacts = 6;

  bool get canAddMore => state.length < maxContacts;

  Future<void> addContact(FavoriteContact contact) async {
    // Check if max contacts reached
    if (state.length >= maxContacts) return;
    // Check if contact already exists (by name)
    final exists = state.any((c) => c.name.toLowerCase() == contact.name.toLowerCase());
    if (!exists) {
      // Add to local state immediately for UI responsiveness
      state = [contact, ...state];
      
      // Save to database asynchronously
      try {
        await WellnessRepository.instance.createContact(
          name: contact.name,
          emoji: contact.emoji,
          type: contact.type,
          phone: contact.phone,
        );
      } catch (e) {
        print('Error saving contact to database: $e');
      }
    }
  }

  void deleteContact(String id) {
    state = state.where((c) => c.id != id).toList();
  }
  
  void clearAll() {
    state = [];
  }
  
  Future<void> loadContacts() async {
    try {
      final contacts = await WellnessRepository.instance.getContacts();
      state = contacts.map((c) => c.toLocal()).toList();
    } catch (e) {
      print('Error loading contacts: $e');
    }
  }
}

final favoriteContactProvider = StateNotifierProvider<FavoriteContactNotifier, List<FavoriteContact>>((ref) {
  final notifier = FavoriteContactNotifier();
  notifier.loadContacts(); // Load from database on init
  return notifier;
});

/// Onboarding completion state
final hasSeenOnboardingProvider = StateProvider<bool>((ref) => false);

/// Selected date for calendar
final selectedCalendarDateProvider = StateProvider<DateTime?>((ref) => null);

/// Selected trend period
final selectedTrendPeriodProvider = StateProvider<String>((ref) => 'Week');
