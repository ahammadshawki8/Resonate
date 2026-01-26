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

/// Junction table for voice entries and tags (many-to-many).
abstract class EntryTag
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  EntryTag._({
    this.id,
    required this.voiceEntryId,
    required this.tagId,
  });

  factory EntryTag({
    int? id,
    required int voiceEntryId,
    required int tagId,
  }) = _EntryTagImpl;

  factory EntryTag.fromJson(Map<String, dynamic> jsonSerialization) {
    return EntryTag(
      id: jsonSerialization['id'] as int?,
      voiceEntryId: jsonSerialization['voiceEntryId'] as int,
      tagId: jsonSerialization['tagId'] as int,
    );
  }

  static final t = EntryTagTable();

  static const db = EntryTagRepository._();

  @override
  int? id;

  int voiceEntryId;

  int tagId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [EntryTag]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EntryTag copyWith({
    int? id,
    int? voiceEntryId,
    int? tagId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EntryTag',
      if (id != null) 'id': id,
      'voiceEntryId': voiceEntryId,
      'tagId': tagId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EntryTag',
      if (id != null) 'id': id,
      'voiceEntryId': voiceEntryId,
      'tagId': tagId,
    };
  }

  static EntryTagInclude include() {
    return EntryTagInclude._();
  }

  static EntryTagIncludeList includeList({
    _i1.WhereExpressionBuilder<EntryTagTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EntryTagTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EntryTagTable>? orderByList,
    EntryTagInclude? include,
  }) {
    return EntryTagIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EntryTag.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(EntryTag.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EntryTagImpl extends EntryTag {
  _EntryTagImpl({
    int? id,
    required int voiceEntryId,
    required int tagId,
  }) : super._(
         id: id,
         voiceEntryId: voiceEntryId,
         tagId: tagId,
       );

  /// Returns a shallow copy of this [EntryTag]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EntryTag copyWith({
    Object? id = _Undefined,
    int? voiceEntryId,
    int? tagId,
  }) {
    return EntryTag(
      id: id is int? ? id : this.id,
      voiceEntryId: voiceEntryId ?? this.voiceEntryId,
      tagId: tagId ?? this.tagId,
    );
  }
}

class EntryTagUpdateTable extends _i1.UpdateTable<EntryTagTable> {
  EntryTagUpdateTable(super.table);

  _i1.ColumnValue<int, int> voiceEntryId(int value) => _i1.ColumnValue(
    table.voiceEntryId,
    value,
  );

  _i1.ColumnValue<int, int> tagId(int value) => _i1.ColumnValue(
    table.tagId,
    value,
  );
}

class EntryTagTable extends _i1.Table<int?> {
  EntryTagTable({super.tableRelation}) : super(tableName: 'entry_tags') {
    updateTable = EntryTagUpdateTable(this);
    voiceEntryId = _i1.ColumnInt(
      'voiceEntryId',
      this,
    );
    tagId = _i1.ColumnInt(
      'tagId',
      this,
    );
  }

  late final EntryTagUpdateTable updateTable;

  late final _i1.ColumnInt voiceEntryId;

  late final _i1.ColumnInt tagId;

  @override
  List<_i1.Column> get columns => [
    id,
    voiceEntryId,
    tagId,
  ];
}

class EntryTagInclude extends _i1.IncludeObject {
  EntryTagInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => EntryTag.t;
}

class EntryTagIncludeList extends _i1.IncludeList {
  EntryTagIncludeList._({
    _i1.WhereExpressionBuilder<EntryTagTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EntryTag.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => EntryTag.t;
}

class EntryTagRepository {
  const EntryTagRepository._();

  /// Returns a list of [EntryTag]s matching the given query parameters.
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
  Future<List<EntryTag>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EntryTagTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EntryTagTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EntryTagTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<EntryTag>(
      where: where?.call(EntryTag.t),
      orderBy: orderBy?.call(EntryTag.t),
      orderByList: orderByList?.call(EntryTag.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [EntryTag] matching the given query parameters.
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
  Future<EntryTag?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EntryTagTable>? where,
    int? offset,
    _i1.OrderByBuilder<EntryTagTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EntryTagTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<EntryTag>(
      where: where?.call(EntryTag.t),
      orderBy: orderBy?.call(EntryTag.t),
      orderByList: orderByList?.call(EntryTag.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [EntryTag] by its [id] or null if no such row exists.
  Future<EntryTag?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<EntryTag>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [EntryTag]s in the list and returns the inserted rows.
  ///
  /// The returned [EntryTag]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<EntryTag>> insert(
    _i1.Session session,
    List<EntryTag> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<EntryTag>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [EntryTag] and returns the inserted row.
  ///
  /// The returned [EntryTag] will have its `id` field set.
  Future<EntryTag> insertRow(
    _i1.Session session,
    EntryTag row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<EntryTag>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [EntryTag]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<EntryTag>> update(
    _i1.Session session,
    List<EntryTag> rows, {
    _i1.ColumnSelections<EntryTagTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<EntryTag>(
      rows,
      columns: columns?.call(EntryTag.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EntryTag]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EntryTag> updateRow(
    _i1.Session session,
    EntryTag row, {
    _i1.ColumnSelections<EntryTagTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<EntryTag>(
      row,
      columns: columns?.call(EntryTag.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EntryTag] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<EntryTag?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<EntryTagUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<EntryTag>(
      id,
      columnValues: columnValues(EntryTag.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [EntryTag]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<EntryTag>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<EntryTagUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<EntryTagTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EntryTagTable>? orderBy,
    _i1.OrderByListBuilder<EntryTagTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<EntryTag>(
      columnValues: columnValues(EntryTag.t.updateTable),
      where: where(EntryTag.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EntryTag.t),
      orderByList: orderByList?.call(EntryTag.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [EntryTag]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<EntryTag>> delete(
    _i1.Session session,
    List<EntryTag> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<EntryTag>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [EntryTag].
  Future<EntryTag> deleteRow(
    _i1.Session session,
    EntryTag row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EntryTag>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<EntryTag>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<EntryTagTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<EntryTag>(
      where: where(EntryTag.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EntryTagTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<EntryTag>(
      where: where?.call(EntryTag.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
