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

/// Favorite contact for reaching out when feeling down.
abstract class FavoriteContact implements _i1.SerializableModel {
  FavoriteContact._({
    this.id,
    required this.userProfileId,
    required this.createdAt,
    required this.name,
    required this.emoji,
    required this.type,
    this.phone,
  });

  factory FavoriteContact({
    int? id,
    required int userProfileId,
    required DateTime createdAt,
    required String name,
    required String emoji,
    required String type,
    String? phone,
  }) = _FavoriteContactImpl;

  factory FavoriteContact.fromJson(Map<String, dynamic> jsonSerialization) {
    return FavoriteContact(
      id: jsonSerialization['id'] as int?,
      userProfileId: jsonSerialization['userProfileId'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      name: jsonSerialization['name'] as String,
      emoji: jsonSerialization['emoji'] as String,
      type: jsonSerialization['type'] as String,
      phone: jsonSerialization['phone'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userProfileId;

  DateTime createdAt;

  String name;

  String emoji;

  String type;

  String? phone;

  /// Returns a shallow copy of this [FavoriteContact]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FavoriteContact copyWith({
    int? id,
    int? userProfileId,
    DateTime? createdAt,
    String? name,
    String? emoji,
    String? type,
    String? phone,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FavoriteContact',
      if (id != null) 'id': id,
      'userProfileId': userProfileId,
      'createdAt': createdAt.toJson(),
      'name': name,
      'emoji': emoji,
      'type': type,
      if (phone != null) 'phone': phone,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FavoriteContactImpl extends FavoriteContact {
  _FavoriteContactImpl({
    int? id,
    required int userProfileId,
    required DateTime createdAt,
    required String name,
    required String emoji,
    required String type,
    String? phone,
  }) : super._(
         id: id,
         userProfileId: userProfileId,
         createdAt: createdAt,
         name: name,
         emoji: emoji,
         type: type,
         phone: phone,
       );

  /// Returns a shallow copy of this [FavoriteContact]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FavoriteContact copyWith({
    Object? id = _Undefined,
    int? userProfileId,
    DateTime? createdAt,
    String? name,
    String? emoji,
    String? type,
    Object? phone = _Undefined,
  }) {
    return FavoriteContact(
      id: id is int? ? id : this.id,
      userProfileId: userProfileId ?? this.userProfileId,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      type: type ?? this.type,
      phone: phone is String? ? phone : this.phone,
    );
  }
}
