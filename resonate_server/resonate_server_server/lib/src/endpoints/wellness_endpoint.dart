import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart' hide UserProfile;
import '../generated/protocol.dart';

/// Endpoint for wellness features.
class WellnessEndpoint extends Endpoint {
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

  // ========== JOURNAL ENTRIES ==========

  Future<List<JournalEntry>> getJournals(Session session, {int? limit}) async {
    final profileId = await _getProfileId(session);

    return await JournalEntry.db.find(
      session,
      where: (t) => t.userProfileId.equals(profileId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit,
    );
  }

  Future<JournalEntry> createJournal(
    Session session,
    String content,
    String prompt, {
    String? moodAtTime,
  }) async {
    final profileId = await _getProfileId(session);

    final entry = JournalEntry(
      userProfileId: profileId,
      createdAt: DateTime.now(),
      content: content,
      prompt: prompt,
      moodAtTime: moodAtTime,
    );

    return await JournalEntry.db.insertRow(session, entry);
  }

  Future<bool> deleteJournal(Session session, int id) async {
    final profileId = await _getProfileId(session);

    final entry = await JournalEntry.db.findById(session, id);
    if (entry == null || entry.userProfileId != profileId) {
      return false;
    }

    await JournalEntry.db.deleteRow(session, entry);
    return true;
  }

  // ========== GRATITUDE ENTRIES ==========

  Future<List<GratitudeEntry>> getGratitudes(
    Session session, {
    int? limit,
  }) async {
    final profileId = await _getProfileId(session);

    return await GratitudeEntry.db.find(
      session,
      where: (t) => t.userProfileId.equals(profileId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit,
    );
  }

  Future<GratitudeEntry> createGratitude(
    Session session,
    List<String> items,
  ) async {
    final profileId = await _getProfileId(session);

    final entry = GratitudeEntry(
      userProfileId: profileId,
      createdAt: DateTime.now(),
      items: items,
    );

    return await GratitudeEntry.db.insertRow(session, entry);
  }

  Future<bool> deleteGratitude(Session session, int id) async {
    final profileId = await _getProfileId(session);

    final entry = await GratitudeEntry.db.findById(session, id);
    if (entry == null || entry.userProfileId != profileId) {
      return false;
    }

    await GratitudeEntry.db.deleteRow(session, entry);
    return true;
  }

  // ========== WELLNESS GOALS ==========

  Future<List<WellnessGoal>> getGoals(Session session) async {
    final profileId = await _getProfileId(session);

    return await WellnessGoal.db.find(
      session,
      where: (t) => t.userProfileId.equals(profileId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );
  }

  Future<WellnessGoal> createGoal(
    Session session,
    String title,
    String emoji,
  ) async {
    final profileId = await _getProfileId(session);

    final goal = WellnessGoal(
      userProfileId: profileId,
      createdAt: DateTime.now(),
      title: title,
      emoji: emoji,
      isCompleted: false,
    );

    return await WellnessGoal.db.insertRow(session, goal);
  }

  Future<WellnessGoal> toggleGoal(Session session, int id) async {
    final profileId = await _getProfileId(session);

    final goal = await WellnessGoal.db.findById(session, id);
    if (goal == null || goal.userProfileId != profileId) {
      throw Exception('Goal not found');
    }

    final updated = goal.copyWith(
      isCompleted: !goal.isCompleted,
      completedAt: !goal.isCompleted ? DateTime.now() : null,
    );

    return await WellnessGoal.db.updateRow(session, updated);
  }

  Future<bool> deleteGoal(Session session, int id) async {
    final profileId = await _getProfileId(session);

    final goal = await WellnessGoal.db.findById(session, id);
    if (goal == null || goal.userProfileId != profileId) {
      return false;
    }

    await WellnessGoal.db.deleteRow(session, goal);
    return true;
  }

  // ========== FAVORITE CONTACTS ==========

  Future<List<FavoriteContact>> getContacts(Session session) async {
    final profileId = await _getProfileId(session);

    return await FavoriteContact.db.find(
      session,
      where: (t) => t.userProfileId.equals(profileId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );
  }

  Future<FavoriteContact> createContact(
    Session session,
    String name,
    String emoji,
    String type, {
    String? phone,
  }) async {
    final profileId = await _getProfileId(session);

    final contact = FavoriteContact(
      userProfileId: profileId,
      createdAt: DateTime.now(),
      name: name,
      emoji: emoji,
      type: type,
      phone: phone,
    );

    return await FavoriteContact.db.insertRow(session, contact);
  }

  Future<bool> deleteContact(Session session, int id) async {
    final profileId = await _getProfileId(session);

    final contact = await FavoriteContact.db.findById(session, id);
    if (contact == null || contact.userProfileId != profileId) {
      return false;
    }

    await FavoriteContact.db.deleteRow(session, contact);
    return true;
  }
}
