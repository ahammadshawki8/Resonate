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

/// Gratitude entry for daily gratitude practice.
abstract class GratitudeEntry
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  GratitudeEntry._({
    this.id,
    required this.userProfileId,
    required this.createdAt,
    required this.items,
  });

  factory GratitudeEntry({
    int? id,
    required int userProfileId,
    required DateTime createdAt,
    required List<String> items,
  }) = _GratitudeEntryImpl;

  factory GratitudeEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return GratitudeEntry(
      id: jsonSerialization['id'] as int?,
      userProfileId: jsonSerialization['userProfileId'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      items: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['items'],
      ),
    );
  }

  static final t = GratitudeEntryTable();

  static const db = GratitudeEntryRepository._();

  @override
  int? id;

  int userProfileId;

  DateTime createdAt;

  List<String> items;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [GratitudeEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GratitudeEntry copyWith({
    int? id,
    int? userProfileId,
    DateTime? createdAt,
    List<String>? items,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GratitudeEntry',
      if (id != null) 'id': id,
      'userProfileId': userProfileId,
      'createdAt': createdAt.toJson(),
      'items': items.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GratitudeEntry',
      if (id != null) 'id': id,
      'userProfileId': userProfileId,
      'createdAt': createdAt.toJson(),
      'items': items.toJson(),
    };
  }

  static GratitudeEntryInclude include() {
    return GratitudeEntryInclude._();
  }

  static GratitudeEntryIncludeList includeList({
    _i1.WhereExpressionBuilder<GratitudeEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GratitudeEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GratitudeEntryTable>? orderByList,
    GratitudeEntryInclude? include,
  }) {
    return GratitudeEntryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GratitudeEntry.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(GratitudeEntry.t),
      include: include,
    );
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
    required int userProfileId,
    required DateTime createdAt,
    required List<String> items,
  }) : super._(
         id: id,
         userProfileId: userProfileId,
         createdAt: createdAt,
         items: items,
       );

  /// Returns a shallow copy of this [GratitudeEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GratitudeEntry copyWith({
    Object? id = _Undefined,
    int? userProfileId,
    DateTime? createdAt,
    List<String>? items,
  }) {
    return GratitudeEntry(
      id: id is int? ? id : this.id,
      userProfileId: userProfileId ?? this.userProfileId,
      createdAt: createdAt ?? this.createdAt,
      items: items ?? this.items.map((e0) => e0).toList(),
    );
  }
}

class GratitudeEntryUpdateTable extends _i1.UpdateTable<GratitudeEntryTable> {
  GratitudeEntryUpdateTable(super.table);

  _i1.ColumnValue<int, int> userProfileId(int value) => _i1.ColumnValue(
    table.userProfileId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<List<String>, List<String>> items(List<String> value) =>
      _i1.ColumnValue(
        table.items,
        value,
      );
}

class GratitudeEntryTable extends _i1.Table<int?> {
  GratitudeEntryTable({super.tableRelation})
    : super(tableName: 'gratitude_entries') {
    updateTable = GratitudeEntryUpdateTable(this);
    userProfileId = _i1.ColumnInt(
      'userProfileId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    items = _i1.ColumnSerializable<List<String>>(
      'items',
      this,
    );
  }

  late final GratitudeEntryUpdateTable updateTable;

  late final _i1.ColumnInt userProfileId;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnSerializable<List<String>> items;

  @override
  List<_i1.Column> get columns => [
    id,
    userProfileId,
    createdAt,
    items,
  ];
}

class GratitudeEntryInclude extends _i1.IncludeObject {
  GratitudeEntryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => GratitudeEntry.t;
}

class GratitudeEntryIncludeList extends _i1.IncludeList {
  GratitudeEntryIncludeList._({
    _i1.WhereExpressionBuilder<GratitudeEntryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(GratitudeEntry.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => GratitudeEntry.t;
}

class GratitudeEntryRepository {
  const GratitudeEntryRepository._();

  /// Returns a list of [GratitudeEntry]s matching the given query parameters.
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
  Future<List<GratitudeEntry>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GratitudeEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GratitudeEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GratitudeEntryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<GratitudeEntry>(
      where: where?.call(GratitudeEntry.t),
      orderBy: orderBy?.call(GratitudeEntry.t),
      orderByList: orderByList?.call(GratitudeEntry.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [GratitudeEntry] matching the given query parameters.
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
  Future<GratitudeEntry?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GratitudeEntryTable>? where,
    int? offset,
    _i1.OrderByBuilder<GratitudeEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GratitudeEntryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<GratitudeEntry>(
      where: where?.call(GratitudeEntry.t),
      orderBy: orderBy?.call(GratitudeEntry.t),
      orderByList: orderByList?.call(GratitudeEntry.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [GratitudeEntry] by its [id] or null if no such row exists.
  Future<GratitudeEntry?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<GratitudeEntry>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [GratitudeEntry]s in the list and returns the inserted rows.
  ///
  /// The returned [GratitudeEntry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<GratitudeEntry>> insert(
    _i1.Session session,
    List<GratitudeEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<GratitudeEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [GratitudeEntry] and returns the inserted row.
  ///
  /// The returned [GratitudeEntry] will have its `id` field set.
  Future<GratitudeEntry> insertRow(
    _i1.Session session,
    GratitudeEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<GratitudeEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [GratitudeEntry]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<GratitudeEntry>> update(
    _i1.Session session,
    List<GratitudeEntry> rows, {
    _i1.ColumnSelections<GratitudeEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<GratitudeEntry>(
      rows,
      columns: columns?.call(GratitudeEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [GratitudeEntry]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<GratitudeEntry> updateRow(
    _i1.Session session,
    GratitudeEntry row, {
    _i1.ColumnSelections<GratitudeEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<GratitudeEntry>(
      row,
      columns: columns?.call(GratitudeEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [GratitudeEntry] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<GratitudeEntry?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<GratitudeEntryUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<GratitudeEntry>(
      id,
      columnValues: columnValues(GratitudeEntry.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [GratitudeEntry]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<GratitudeEntry>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<GratitudeEntryUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<GratitudeEntryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GratitudeEntryTable>? orderBy,
    _i1.OrderByListBuilder<GratitudeEntryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<GratitudeEntry>(
      columnValues: columnValues(GratitudeEntry.t.updateTable),
      where: where(GratitudeEntry.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GratitudeEntry.t),
      orderByList: orderByList?.call(GratitudeEntry.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [GratitudeEntry]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<GratitudeEntry>> delete(
    _i1.Session session,
    List<GratitudeEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<GratitudeEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [GratitudeEntry].
  Future<GratitudeEntry> deleteRow(
    _i1.Session session,
    GratitudeEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<GratitudeEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<GratitudeEntry>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<GratitudeEntryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<GratitudeEntry>(
      where: where(GratitudeEntry.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GratitudeEntryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<GratitudeEntry>(
      where: where?.call(GratitudeEntry.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
