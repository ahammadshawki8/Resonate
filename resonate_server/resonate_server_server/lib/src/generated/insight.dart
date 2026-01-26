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
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:resonate_server_server/src/generated/protocol.dart' as _i2;

/// AI-generated insight based on mood patterns.
abstract class Insight
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = InsightTable();

  static const db = InsightRepository._();

  @override
  int? id;

  int userProfileId;

  String insightText;

  String insightType;

  DateTime generatedAt;

  bool isRead;

  List<int>? relatedEntryIds;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static InsightInclude include() {
    return InsightInclude._();
  }

  static InsightIncludeList includeList({
    _i1.WhereExpressionBuilder<InsightTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InsightTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InsightTable>? orderByList,
    InsightInclude? include,
  }) {
    return InsightIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Insight.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Insight.t),
      include: include,
    );
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

class InsightUpdateTable extends _i1.UpdateTable<InsightTable> {
  InsightUpdateTable(super.table);

  _i1.ColumnValue<int, int> userProfileId(int value) => _i1.ColumnValue(
    table.userProfileId,
    value,
  );

  _i1.ColumnValue<String, String> insightText(String value) => _i1.ColumnValue(
    table.insightText,
    value,
  );

  _i1.ColumnValue<String, String> insightType(String value) => _i1.ColumnValue(
    table.insightType,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> generatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.generatedAt,
        value,
      );

  _i1.ColumnValue<bool, bool> isRead(bool value) => _i1.ColumnValue(
    table.isRead,
    value,
  );

  _i1.ColumnValue<List<int>, List<int>> relatedEntryIds(List<int>? value) =>
      _i1.ColumnValue(
        table.relatedEntryIds,
        value,
      );
}

class InsightTable extends _i1.Table<int?> {
  InsightTable({super.tableRelation}) : super(tableName: 'insights') {
    updateTable = InsightUpdateTable(this);
    userProfileId = _i1.ColumnInt(
      'userProfileId',
      this,
    );
    insightText = _i1.ColumnString(
      'insightText',
      this,
    );
    insightType = _i1.ColumnString(
      'insightType',
      this,
    );
    generatedAt = _i1.ColumnDateTime(
      'generatedAt',
      this,
    );
    isRead = _i1.ColumnBool(
      'isRead',
      this,
    );
    relatedEntryIds = _i1.ColumnSerializable<List<int>>(
      'relatedEntryIds',
      this,
    );
  }

  late final InsightUpdateTable updateTable;

  late final _i1.ColumnInt userProfileId;

  late final _i1.ColumnString insightText;

  late final _i1.ColumnString insightType;

  late final _i1.ColumnDateTime generatedAt;

  late final _i1.ColumnBool isRead;

  late final _i1.ColumnSerializable<List<int>> relatedEntryIds;

  @override
  List<_i1.Column> get columns => [
    id,
    userProfileId,
    insightText,
    insightType,
    generatedAt,
    isRead,
    relatedEntryIds,
  ];
}

class InsightInclude extends _i1.IncludeObject {
  InsightInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Insight.t;
}

class InsightIncludeList extends _i1.IncludeList {
  InsightIncludeList._({
    _i1.WhereExpressionBuilder<InsightTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Insight.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Insight.t;
}

class InsightRepository {
  const InsightRepository._();

  /// Returns a list of [Insight]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Insight>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InsightTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InsightTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InsightTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Insight>(
      where: where?.call(Insight.t),
      orderBy: orderBy?.call(Insight.t),
      orderByList: orderByList?.call(Insight.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Insight] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Insight?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InsightTable>? where,
    int? offset,
    _i1.OrderByBuilder<InsightTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InsightTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Insight>(
      where: where?.call(Insight.t),
      orderBy: orderBy?.call(Insight.t),
      orderByList: orderByList?.call(Insight.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Insight] by its [id] or null if no such row exists.
  Future<Insight?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Insight>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Insight]s in the list and returns the inserted rows.
  ///
  /// The returned [Insight]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Insight>> insert(
    _i1.Session session,
    List<Insight> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Insight>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Insight] and returns the inserted row.
  ///
  /// The returned [Insight] will have its `id` field set.
  Future<Insight> insertRow(
    _i1.Session session,
    Insight row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Insight>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Insight]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Insight>> update(
    _i1.Session session,
    List<Insight> rows, {
    _i1.ColumnSelections<InsightTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Insight>(
      rows,
      columns: columns?.call(Insight.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Insight]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Insight> updateRow(
    _i1.Session session,
    Insight row, {
    _i1.ColumnSelections<InsightTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Insight>(
      row,
      columns: columns?.call(Insight.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Insight] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Insight?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<InsightUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Insight>(
      id,
      columnValues: columnValues(Insight.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Insight]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Insight>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<InsightUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<InsightTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InsightTable>? orderBy,
    _i1.OrderByListBuilder<InsightTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Insight>(
      columnValues: columnValues(Insight.t.updateTable),
      where: where(Insight.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Insight.t),
      orderByList: orderByList?.call(Insight.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Insight]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Insight>> delete(
    _i1.Session session,
    List<Insight> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Insight>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Insight].
  Future<Insight> deleteRow(
    _i1.Session session,
    Insight row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Insight>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Insight>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<InsightTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Insight>(
      where: where(Insight.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InsightTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Insight>(
      where: where?.call(Insight.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
