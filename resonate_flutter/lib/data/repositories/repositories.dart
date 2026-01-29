import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:resonate_server_client/resonate_server_client.dart';
import '../../core/services/api_service.dart';

/// Repository for user profile operations.
/// 
/// This repository provides methods to interact with the user profile
/// endpoint on the Serverpod server.
class UserProfileRepository {
  static UserProfileRepository? _instance;
  
  UserProfileRepository._();
  
  static UserProfileRepository get instance {
    _instance ??= UserProfileRepository._();
    return _instance!;
  }

  Client get _client => ApiService.client;

  /// Get the current user's profile.
  /// Creates a new profile if one doesn't exist.
  Future<UserProfile> getProfile() async {
    return await _client.userProfile.getProfile();
  }

  /// Update the user's profile.
  Future<UserProfile> updateProfile({
    String? displayName,
    String? email,
    String? avatarUrl,
  }) async {
    return await _client.userProfile.updateProfile(
      displayName: displayName,
      email: email,
      avatarUrl: avatarUrl,
    );
  }

  /// Change the user's password.
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    return await _client.userProfile.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }

  /// Get user statistics.
  Future<UserStats> getStats() async {
    return await _client.userProfile.getStats();
  }

  /// Delete the user's account and all data.
  Future<bool> deleteAccount() async {
    return await _client.userProfile.deleteAccount();
  }
}

/// Repository for voice entry operations.
class VoiceEntryRepository {
  static VoiceEntryRepository? _instance;
  
  VoiceEntryRepository._();
  
  static VoiceEntryRepository get instance {
    _instance ??= VoiceEntryRepository._();
    return _instance!;
  }

  Client get _client => ApiService.client;

  /// Upload and analyze a voice recording
  Future<VoiceEntryWithTags> uploadAndAnalyze({
    required String audioFilePath,
    required String language,
    required String privacyLevel,
  }) async {
    // Read audio file
    final file = File(audioFilePath);
    
    if (!await file.exists()) {
      throw Exception('Audio file does not exist: $audioFilePath');
    }
    
    final bytes = await file.readAsBytes();
    debugPrint('Audio file read: ${bytes.length} bytes');
    
    final audioData = ByteData.sublistView(Uint8List.fromList(bytes));
    
    // Upload to backend
    return await _client.voiceEntry.uploadAndAnalyze(
      audioData,
      language,
      privacyLevel,
    );
  }

  /// Get all voice entries.
  Future<List<VoiceEntryWithTags>> getEntries({int? limit}) async {
    return await _client.voiceEntry.getEntries(limit: limit);
  }

  /// Get a specific entry by ID.
  Future<VoiceEntryWithTags?> getEntry(int id) async {
    return await _client.voiceEntry.getEntry(id);
  }

  /// Get today's entry.
  Future<VoiceEntryWithTags?> getTodayEntry() async {
    return await _client.voiceEntry.getTodayEntry();
  }

  /// Get calendar data for a month.
  Future<CalendarMonth> getCalendarMonth(int year, int month) async {
    return await _client.voiceEntry.getCalendarMonth(year, month);
  }

  /// Delete an entry.
  Future<bool> deleteEntry(int id) async {
    return await _client.voiceEntry.deleteEntry(id);
  }
}

/// Repository for insights operations.
class InsightRepository {
  static InsightRepository? _instance;
  
  InsightRepository._();
  
  static InsightRepository get instance {
    _instance ??= InsightRepository._();
    return _instance!;
  }

  Client get _client => ApiService.client;

  /// Get all insights.
  Future<List<Insight>> getInsights({int? limit}) async {
    return await _client.insight.getInsights(limit: limit);
  }

  /// Get unread insights count.
  Future<int> getUnreadCount() async {
    return await _client.insight.getUnreadCount();
  }

  /// Mark an insight as read.
  Future<Insight> markAsRead(int id) async {
    return await _client.insight.markAsRead(id);
  }

  /// Generate a new insight.
  Future<Insight> generateInsight() async {
    return await _client.insight.generateInsight();
  }

  /// Generate AI-powered insight using Python service.
  Future<Insight> generateAIInsight() async {
    return await _client.insight.generateAIInsight();
  }

  /// Create a custom insight (e.g., from AI).
  Future<Insight> createInsight({
    required String insightText,
    required String insightType,
  }) async {
    return await _client.insight.createInsight(
      insightText: insightText,
      insightType: insightType,
    );
  }
}

/// Repository for wellness features (journal, gratitude, goals, contacts).
class WellnessRepository {
  static WellnessRepository? _instance;
  
  WellnessRepository._();
  
  static WellnessRepository get instance {
    _instance ??= WellnessRepository._();
    return _instance!;
  }

  Client get _client => ApiService.client;

  // ========== JOURNAL ==========
  
  Future<List<JournalEntry>> getJournals({int? limit}) async {
    return await _client.wellness.getJournals(limit: limit);
  }

  Future<JournalEntry> createJournal({
    required String content,
    required String prompt,
    String? moodAtTime,
  }) async {
    return await _client.wellness.createJournal(
      content,
      prompt,
      moodAtTime: moodAtTime,
    );
  }

  Future<bool> deleteJournal(int id) async {
    return await _client.wellness.deleteJournal(id);
  }

  // ========== GRATITUDE ==========
  
  Future<List<GratitudeEntry>> getGratitudes({int? limit}) async {
    return await _client.wellness.getGratitudes(limit: limit);
  }

  Future<GratitudeEntry> createGratitude({
    required List<String> items,
  }) async {
    return await _client.wellness.createGratitude(items);
  }

  Future<bool> deleteGratitude(int id) async {
    return await _client.wellness.deleteGratitude(id);
  }

  // ========== GOALS ==========
  
  Future<List<WellnessGoal>> getGoals() async {
    return await _client.wellness.getGoals();
  }

  Future<WellnessGoal> createGoal({
    required String title,
    required String emoji,
  }) async {
    return await _client.wellness.createGoal(title, emoji);
  }

  Future<WellnessGoal> toggleGoal(int id) async {
    return await _client.wellness.toggleGoal(id);
  }

  Future<bool> deleteGoal(int id) async {
    return await _client.wellness.deleteGoal(id);
  }

  // ========== CONTACTS ==========
  
  Future<List<FavoriteContact>> getContacts() async {
    return await _client.wellness.getContacts();
  }

  Future<FavoriteContact> createContact({
    required String name,
    required String emoji,
    required String type,
    String? phone,
  }) async {
    return await _client.wellness.createContact(
      name,
      emoji,
      type,
      phone: phone,
    );
  }

  Future<bool> deleteContact(int id) async {
    return await _client.wellness.deleteContact(id);
  }
}

/// Repository for user settings operations.
class SettingsRepository {
  static SettingsRepository? _instance;
  
  SettingsRepository._();
  
  static SettingsRepository get instance {
    _instance ??= SettingsRepository._();
    return _instance!;
  }

  Client get _client => ApiService.client;

  /// Get user settings.
  Future<UserSettings> getSettings() async {
    return await _client.settings.getSettings();
  }

  /// Update user settings.
  Future<UserSettings> updateSettings(UserSettings settings) async {
    return await _client.settings.updateSettings(settings);
  }

  /// Toggle dark mode.
  Future<UserSettings> toggleDarkMode(bool enabled) async {
    return await _client.settings.toggleDarkMode(enabled);
  }

  /// Toggle notifications.
  Future<UserSettings> toggleNotifications(bool enabled) async {
    return await _client.settings.toggleNotifications(enabled);
  }
}

/// Repository for user data operations (export, delete)
class UserDataRepository {
  static UserDataRepository? _instance;
  
  UserDataRepository._();
  
  static UserDataRepository get instance {
    _instance ??= UserDataRepository._();
    return _instance!;
  }

  Client get _client => ApiService.client;

  /// Export all user data from the database
  Future<Map<String, dynamic>> exportAllData() async {
    final jsonString = await _client.userData.exportAllData();
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  /// Delete all user data from the database
  Future<bool> deleteAllData() async {
    return await _client.userData.deleteAllData();
  }

  /// Get count of user data
  Future<Map<String, int>> getDataCounts() async {
    return await _client.userData.getDataCounts();
  }
}

/// Repository for tag operations.
class TagRepository {
  static TagRepository? _instance;
  
  TagRepository._();
  
  static TagRepository get instance {
    _instance ??= TagRepository._();
    return _instance!;
  }

  Client get _client => ApiService.client;

  /// Get all tags.
  Future<List<Tag>> getTags() async {
    return await _client.tag.getTags();
  }

  /// Create a new tag.
  Future<Tag> createTag(String name, String color) async {
    return await _client.tag.createTag(name, color);
  }

  /// Delete a tag.
  Future<bool> deleteTag(int id) async {
    return await _client.tag.deleteTag(id);
  }

  /// Add tag to an entry.
  Future<bool> addTagToEntry(int entryId, int tagId) async {
    return await _client.tag.addTagToEntry(entryId, tagId);
  }
}

/// Repository for analytics operations.
class AnalyticsRepository {
  static AnalyticsRepository? _instance;
  
  AnalyticsRepository._();
  
  static AnalyticsRepository get instance {
    _instance ??= AnalyticsRepository._();
    return _instance!;
  }

  Client get _client => ApiService.client;

  /// Get weekly analytics.
  Future<WeeklyAnalytics> getWeeklyAnalytics() async {
    return await _client.analytics.getWeeklyAnalytics();
  }

  /// Get mood distribution.
  Future<MoodDistribution> getMoodDistribution(String period) async {
    return await _client.analytics.getMoodDistribution(period);
  }

  /// Get time of day analysis.
  Future<TimeOfDayAnalysis> getTimeOfDayAnalysis() async {
    return await _client.analytics.getTimeOfDayAnalysis();
  }

  /// Get detected patterns.
  Future<List<MoodPattern>> getPatterns() async {
    return await _client.analytics.getPatterns();
  }
}
