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

/// Tag for categorizing entries.
abstract class Tag implements _i1.SerializableModel {
  Tag._({
    this.id,
    required this.userProfileId,
    required this.name,
    required this.color,
    required this.usageCount,
  });

  factory Tag({
    int? id,
    required int userProfileId,
    required String name,
    required String color,
    required int usageCount,
  }) = _TagImpl;

  factory Tag.fromJson(Map<String, dynamic> jsonSerialization) {
    return Tag(
      id: jsonSerialization['id'] as int?,
      userProfileId: jsonSerialization['userProfileId'] as int,
      name: jsonSerialization['name'] as String,
      color: jsonSerialization['color'] as String,
      usageCount: jsonSerialization['usageCount'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userProfileId;

  String name;

  String color;

  int usageCount;

  /// Returns a shallow copy of this [Tag]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Tag copyWith({
    int? id,
    int? userProfileId,
    String? name,
    String? color,
    int? usageCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Tag',
      if (id != null) 'id': id,
      'userProfileId': userProfileId,
      'name': name,
      'color': color,
      'usageCount': usageCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TagImpl extends Tag {
  _TagImpl({
    int? id,
    required int userProfileId,
    required String name,
    required String color,
    required int usageCount,
  }) : super._(
         id: id,
         userProfileId: userProfileId,
         name: name,
         color: color,
         usageCount: usageCount,
       );

  /// Returns a shallow copy of this [Tag]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Tag copyWith({
    Object? id = _Undefined,
    int? userProfileId,
    String? name,
    String? color,
    int? usageCount,
  }) {
    return Tag(
      id: id is int? ? id : this.id,
      userProfileId: userProfileId ?? this.userProfileId,
      name: name ?? this.name,
      color: color ?? this.color,
      usageCount: usageCount ?? this.usageCount,
    );
  }
}
