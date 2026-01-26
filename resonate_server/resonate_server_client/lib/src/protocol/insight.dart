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

/// AI-generated insight based on mood patterns.
abstract class Insight implements _i1.SerializableModel {
  Insight._({
    this.id,
    required this.userProfileId,
    required this.insightText,
    required this.insightType,
    required this.generatedAt,
    required this.isRead,
    this.relatedEntryIds,
  });

  factory Insight({
    int? id,
    required int userProfileId,
    required String insightText,
    required String insightType,
    required DateTime generatedAt,
    required bool isRead,
    List<int>? relatedEntryIds,
  }) = _InsightImpl;

  factory Insight.fromJson(Map<String, dynamic> jsonSerialization) {
    return Insight(
      id: jsonSerialization['id'] as int?,
      userProfileId: jsonSerialization['userProfileId'] as int,
      insightText: jsonSerialization['insightText'] as String,
      insightType: jsonSerialization['insightType'] as String,
      generatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['generatedAt'],
      ),
      isRead: jsonSerialization['isRead'] as bool,
      relatedEntryIds: jsonSerialization['relatedEntryIds'] == null
          ? null
          : _i2.Protocol().deserialize<List<int>>(
              jsonSerialization['relatedEntryIds'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userProfileId;

  String insightText;

  String insightType;

  DateTime generatedAt;

  bool isRead;

  List<int>? relatedEntryIds;

  /// Returns a shallow copy of this [Insight]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Insight copyWith({
    int? id,
    int? userProfileId,
    String? insightText,
    String? insightType,
    DateTime? generatedAt,
    bool? isRead,
    List<int>? relatedEntryIds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Insight',
      if (id != null) 'id': id,
      'userProfileId': userProfileId,
      'insightText': insightText,
      'insightType': insightType,
      'generatedAt': generatedAt.toJson(),
      'isRead': isRead,
      if (relatedEntryIds != null) 'relatedEntryIds': relatedEntryIds?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InsightImpl extends Insight {
  _InsightImpl({
    int? id,
    required int userProfileId,
    required String insightText,
    required String insightType,
    required DateTime generatedAt,
    required bool isRead,
    List<int>? relatedEntryIds,
  }) : super._(
         id: id,
         userProfileId: userProfileId,
         insightText: insightText,
         insightType: insightType,
         generatedAt: generatedAt,
         isRead: isRead,
         relatedEntryIds: relatedEntryIds,
       );

  /// Returns a shallow copy of this [Insight]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Insight copyWith({
    Object? id = _Undefined,
    int? userProfileId,
    String? insightText,
    String? insightType,
    DateTime? generatedAt,
    bool? isRead,
    Object? relatedEntryIds = _Undefined,
  }) {
    return Insight(
      id: id is int? ? id : this.id,
      userProfileId: userProfileId ?? this.userProfileId,
      insightText: insightText ?? this.insightText,
      insightType: insightType ?? this.insightType,
      generatedAt: generatedAt ?? this.generatedAt,
      isRead: isRead ?? this.isRead,
      relatedEntryIds: relatedEntryIds is List<int>?
          ? relatedEntryIds
          : this.relatedEntryIds?.map((e0) => e0).toList(),
    );
  }
}
