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
import 'package:serverpod_client/serverpod_client.dart' as _i1;

/// Journal entry for wellness reflection.
abstract class JournalEntry implements _i1.SerializableModel {
  JournalEntry._({
    this.id,
    required this.userProfileId,
    required this.createdAt,
    required this.content,
    required this.prompt,
    this.moodAtTime,
  });

  factory JournalEntry({
    int? id,
    required int userProfileId,
    required DateTime createdAt,
    required String content,
    required String prompt,
    String? moodAtTime,
  }) = _JournalEntryImpl;

  factory JournalEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return JournalEntry(
      id: jsonSerialization['id'] as int?,
      userProfileId: jsonSerialization['userProfileId'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      content: jsonSerialization['content'] as String,
      prompt: jsonSerialization['prompt'] as String,
      moodAtTime: jsonSerialization['moodAtTime'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userProfileId;

  DateTime createdAt;

  String content;

  String prompt;

  String? moodAtTime;

  /// Returns a shallow copy of this [JournalEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  JournalEntry copyWith({
    int? id,
    int? userProfileId,
    DateTime? createdAt,
    String? content,
    String? prompt,
    String? moodAtTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JournalEntry',
      if (id != null) 'id': id,
      'userProfileId': userProfileId,
      'createdAt': createdAt.toJson(),
      'content': content,
      'prompt': prompt,
      if (moodAtTime != null) 'moodAtTime': moodAtTime,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JournalEntryImpl extends JournalEntry {
  _JournalEntryImpl({
    int? id,
    required int userProfileId,
    required DateTime createdAt,
    required String content,
    required String prompt,
    String? moodAtTime,
  }) : super._(
         id: id,
         userProfileId: userProfileId,
         createdAt: createdAt,
         content: content,
         prompt: prompt,
         moodAtTime: moodAtTime,
       );

  /// Returns a shallow copy of this [JournalEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  JournalEntry copyWith({
    Object? id = _Undefined,
    int? userProfileId,
    DateTime? createdAt,
    String? content,
    String? prompt,
    Object? moodAtTime = _Undefined,
  }) {
    return JournalEntry(
      id: id is int? ? id : this.id,
      userProfileId: userProfileId ?? this.userProfileId,
      createdAt: createdAt ?? this.createdAt,
      content: content ?? this.content,
      prompt: prompt ?? this.prompt,
      moodAtTime: moodAtTime is String? ? moodAtTime : this.moodAtTime,
    );
  }
}
