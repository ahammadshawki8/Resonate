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

/// Emergency or support contact.
abstract class Contact implements _i1.SerializableModel {
  Contact._({
    this.id,
    required this.name,
    this.phone,
    this.email,
    this.relationship,
    this.emoji,
  });

  factory Contact({
    int? id,
    required String name,
    String? phone,
    String? email,
    String? relationship,
    String? emoji,
  }) = _ContactImpl;

  factory Contact.fromJson(Map<String, dynamic> jsonSerialization) {
    return Contact(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      phone: jsonSerialization['phone'] as String?,
      email: jsonSerialization['email'] as String?,
      relationship: jsonSerialization['relationship'] as String?,
      emoji: jsonSerialization['emoji'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String? phone;

  String? email;

  String? relationship;

  String? emoji;

  /// Returns a shallow copy of this [Contact]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Contact copyWith({
    int? id,
    String? name,
    String? phone,
    String? email,
    String? relationship,
    String? emoji,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Contact',
      if (id != null) 'id': id,
      'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (relationship != null) 'relationship': relationship,
      if (emoji != null) 'emoji': emoji,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ContactImpl extends Contact {
  _ContactImpl({
    int? id,
    required String name,
    String? phone,
    String? email,
    String? relationship,
    String? emoji,
  }) : super._(
         id: id,
         name: name,
         phone: phone,
         email: email,
         relationship: relationship,
         emoji: emoji,
       );

  /// Returns a shallow copy of this [Contact]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Contact copyWith({
    Object? id = _Undefined,
    String? name,
    Object? phone = _Undefined,
    Object? email = _Undefined,
    Object? relationship = _Undefined,
    Object? emoji = _Undefined,
  }) {
    return Contact(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      phone: phone is String? ? phone : this.phone,
      email: email is String? ? email : this.email,
      relationship: relationship is String? ? relationship : this.relationship,
      emoji: emoji is String? ? emoji : this.emoji,
    );
  }
}
