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
import 'package:resonate_server_client/src/protocol/protocol.dart' as _i2;

/// Gratitude entry for positive reflection.
abstract class GratitudeEntry implements _i1.SerializableModel {
  GratitudeEntry._({
    this.id,
    required this.items,
  });

  factory GratitudeEntry({
    int? id,
    required List<String> items,
  }) = _GratitudeEntryImpl;

  factory GratitudeEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return GratitudeEntry(
      id: jsonSerialization['id'] as int?,
      items: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['items'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  List<String> items;

  /// Returns a shallow copy of this [GratitudeEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GratitudeEntry copyWith({
    int? id,
    List<String>? items,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GratitudeEntry',
      if (id != null) 'id': id,
      'items': items.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GratitudeEntryImpl extends GratitudeEntry {
  _GratitudeEntryImpl({
    int? id,
    required List<String> items,
  }) : super._(
         id: id,
         items: items,
       );

  /// Returns a shallow copy of this [GratitudeEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GratitudeEntry copyWith({
    Object? id = _Undefined,
    List<String>? items,
  }) {
    return GratitudeEntry(
      id: id is int? ? id : this.id,
      items: items ?? this.items.map((e0) => e0).toList(),
    );
  }
}
