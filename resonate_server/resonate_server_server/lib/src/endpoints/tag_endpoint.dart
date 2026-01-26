import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart' hide UserProfile;
import '../generated/protocol.dart';

/// Endpoint for tag operations.
class TagEndpoint extends Endpoint {
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

  /// Get all tags for the user.
  Future<List<Tag>> getTags(Session session) async {
    final profileId = await _getProfileId(session);

    return await Tag.db.find(
      session,
      where: (t) => t.userProfileId.equals(profileId),
      orderBy: (t) => t.usageCount,
      orderDescending: true,
    );
  }

  /// Create a new tag.
  Future<Tag> createTag(
    Session session,
    String name,
    String color,
  ) async {
    final profileId = await _getProfileId(session);

    final existing = await Tag.db.findFirstRow(
      session,
      where: (t) =>
          t.userProfileId.equals(profileId) &
          t.name.equals(name.toLowerCase()),
    );

    if (existing != null) {
      return existing;
    }

    final tag = Tag(
      userProfileId: profileId,
      name: name.toLowerCase(),
      color: color,
      usageCount: 0,
    );

    return await Tag.db.insertRow(session, tag);
  }

  /// Delete a tag.
  Future<bool> deleteTag(Session session, int id) async {
    final profileId = await _getProfileId(session);

    final tag = await Tag.db.findById(session, id);
    if (tag == null || tag.userProfileId != profileId) {
      return false;
    }

    await EntryTag.db.deleteWhere(
      session,
      where: (t) => t.tagId.equals(id),
    );
    await Tag.db.deleteRow(session, tag);
    return true;
  }

  /// Add tag to an entry.
  Future<bool> addTagToEntry(Session session, int entryId, int tagId) async {
    final profileId = await _getProfileId(session);

    final entry = await VoiceEntry.db.findById(session, entryId);
    if (entry == null || entry.userProfileId != profileId) {
      return false;
    }

    final tag = await Tag.db.findById(session, tagId);
    if (tag == null || tag.userProfileId != profileId) {
      return false;
    }

    final existing = await EntryTag.db.findFirstRow(
      session,
      where: (t) => t.voiceEntryId.equals(entryId) & t.tagId.equals(tagId),
    );

    if (existing != null) {
      return true;
    }

    await EntryTag.db.insertRow(
      session,
      EntryTag(voiceEntryId: entryId, tagId: tagId),
    );

    await Tag.db.updateRow(
      session,
      tag.copyWith(usageCount: tag.usageCount + 1),
    );

    return true;
  }
}
