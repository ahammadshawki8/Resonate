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

/// Journal entry for wellness reflection.
abstract class JournalEntry
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = JournalEntryTable();

  static const db = JournalEntryRepository._();

  @override
  int? id;

  int userProfileId;

  DateTime createdAt;

  String content;

  String prompt;

  String? moodAtTime;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static JournalEntryInclude include() {
    return JournalEntryInclude._();
  }

  static JournalEntryIncludeList includeList({
    _i1.WhereExpressionBuilder<JournalEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JournalEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JournalEntryTable>? orderByList,
    JournalEntryInclude? include,
  }) {
    return JournalEntryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JournalEntry.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(JournalEntry.t),
      include: include,
    );
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

class JournalEntryUpdateTable extends _i1.UpdateTable<JournalEntryTable> {
  JournalEntryUpdateTable(super.table);

  _i1.ColumnValue<int, int> userProfileId(int value) => _i1.ColumnValue(
    table.userProfileId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<String, String> content(String value) => _i1.ColumnValue(
    table.content,
    value,
  );

  _i1.ColumnValue<String, String> prompt(String value) => _i1.ColumnValue(
    table.prompt,
    value,
  );

  _i1.ColumnValue<String, String> moodAtTime(String? value) => _i1.ColumnValue(
    table.moodAtTime,
    value,
  );
}

class JournalEntryTable extends _i1.Table<int?> {
  JournalEntryTable({super.tableRelation})
    : super(tableName: 'journal_entries') {
    updateTable = JournalEntryUpdateTable(this);
    userProfileId = _i1.ColumnInt(
      'userProfileId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    content = _i1.ColumnString(
      'content',
      this,
    );
    prompt = _i1.ColumnString(
      'prompt',
      this,
    );
    moodAtTime = _i1.ColumnString(
      'moodAtTime',
      this,
    );
  }

  late final JournalEntryUpdateTable updateTable;

  late final _i1.ColumnInt userProfileId;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnString content;

  late final _i1.ColumnString prompt;

  late final _i1.ColumnString moodAtTime;

  @override
  List<_i1.Column> get columns => [
    id,
    userProfileId,
    createdAt,
    content,
    prompt,
    moodAtTime,
  ];
}

class JournalEntryInclude extends _i1.IncludeObject {
  JournalEntryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => JournalEntry.t;
}

class JournalEntryIncludeList extends _i1.IncludeList {
  JournalEntryIncludeList._({
    _i1.WhereExpressionBuilder<JournalEntryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(JournalEntry.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => JournalEntry.t;
}

class JournalEntryRepository {
  const JournalEntryRepository._();

  /// Returns a list of [JournalEntry]s matching the given query parameters.
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
  Future<List<JournalEntry>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<JournalEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JournalEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JournalEntryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<JournalEntry>(
      where: where?.call(JournalEntry.t),
      orderBy: orderBy?.call(JournalEntry.t),
      orderByList: orderByList?.call(JournalEntry.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [JournalEntry] matching the given query parameters.
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
  Future<JournalEntry?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<JournalEntryTable>? where,
    int? offset,
    _i1.OrderByBuilder<JournalEntryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<JournalEntryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<JournalEntry>(
      where: where?.call(JournalEntry.t),
      orderBy: orderBy?.call(JournalEntry.t),
      orderByList: orderByList?.call(JournalEntry.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [JournalEntry] by its [id] or null if no such row exists.
  Future<JournalEntry?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<JournalEntry>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [JournalEntry]s in the list and returns the inserted rows.
  ///
  /// The returned [JournalEntry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<JournalEntry>> insert(
    _i1.Session session,
    List<JournalEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<JournalEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [JournalEntry] and returns the inserted row.
  ///
  /// The returned [JournalEntry] will have its `id` field set.
  Future<JournalEntry> insertRow(
    _i1.Session session,
    JournalEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<JournalEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [JournalEntry]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<JournalEntry>> update(
    _i1.Session session,
    List<JournalEntry> rows, {
    _i1.ColumnSelections<JournalEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<JournalEntry>(
      rows,
      columns: columns?.call(JournalEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JournalEntry]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<JournalEntry> updateRow(
    _i1.Session session,
    JournalEntry row, {
    _i1.ColumnSelections<JournalEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<JournalEntry>(
      row,
      columns: columns?.call(JournalEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JournalEntry] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<JournalEntry?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<JournalEntryUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<JournalEntry>(
      id,
      columnValues: columnValues(JournalEntry.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [JournalEntry]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<JournalEntry>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<JournalEntryUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<JournalEntryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<JournalEntryTable>? orderBy,
    _i1.OrderByListBuilder<JournalEntryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<JournalEntry>(
      columnValues: columnValues(JournalEntry.t.updateTable),
      where: where(JournalEntry.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JournalEntry.t),
      orderByList: orderByList?.call(JournalEntry.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [JournalEntry]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<JournalEntry>> delete(
    _i1.Session session,
    List<JournalEntry> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<JournalEntry>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [JournalEntry].
  Future<JournalEntry> deleteRow(
    _i1.Session session,
    JournalEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<JournalEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<JournalEntry>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<JournalEntryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<JournalEntry>(
      where: where(JournalEntry.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<JournalEntryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<JournalEntry>(
      where: where?.call(JournalEntry.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
