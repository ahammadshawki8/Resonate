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

/// Wellness goal for user's wellness journey.
abstract class WellnessGoal
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  WellnessGoal._({
    this.id,
    required this.userProfileId,
    required this.createdAt,
    required this.title,
    required this.emoji,
    required this.isCompleted,
    this.completedAt,
  });

  factory WellnessGoal({
    int? id,
    required int userProfileId,
    required DateTime createdAt,
    required String title,
    required String emoji,
    required bool isCompleted,
    DateTime? completedAt,
  }) = _WellnessGoalImpl;

  factory WellnessGoal.fromJson(Map<String, dynamic> jsonSerialization) {
    return WellnessGoal(
      id: jsonSerialization['id'] as int?,
      userProfileId: jsonSerialization['userProfileId'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      title: jsonSerialization['title'] as String,
      emoji: jsonSerialization['emoji'] as String,
      isCompleted: jsonSerialization['isCompleted'] as bool,
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
    );
  }

  static final t = WellnessGoalTable();

  static const db = WellnessGoalRepository._();

  @override
  int? id;

  int userProfileId;

  DateTime createdAt;

  String title;

  String emoji;

  bool isCompleted;

  DateTime? completedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [WellnessGoal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WellnessGoal copyWith({
    int? id,
    int? userProfileId,
    DateTime? createdAt,
    String? title,
    String? emoji,
    bool? isCompleted,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WellnessGoal',
      if (id != null) 'id': id,
      'userProfileId': userProfileId,
      'createdAt': createdAt.toJson(),
      'title': title,
      'emoji': emoji,
      'isCompleted': isCompleted,
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WellnessGoal',
      if (id != null) 'id': id,
      'userProfileId': userProfileId,
      'createdAt': createdAt.toJson(),
      'title': title,
      'emoji': emoji,
      'isCompleted': isCompleted,
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  static WellnessGoalInclude include() {
    return WellnessGoalInclude._();
  }

  static WellnessGoalIncludeList includeList({
    _i1.WhereExpressionBuilder<WellnessGoalTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WellnessGoalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WellnessGoalTable>? orderByList,
    WellnessGoalInclude? include,
  }) {
    return WellnessGoalIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WellnessGoal.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(WellnessGoal.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WellnessGoalImpl extends WellnessGoal {
  _WellnessGoalImpl({
    int? id,
    required int userProfileId,
    required DateTime createdAt,
    required String title,
    required String emoji,
    required bool isCompleted,
    DateTime? completedAt,
  }) : super._(
         id: id,
         userProfileId: userProfileId,
         createdAt: createdAt,
         title: title,
         emoji: emoji,
         isCompleted: isCompleted,
         completedAt: completedAt,
       );

  /// Returns a shallow copy of this [WellnessGoal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WellnessGoal copyWith({
    Object? id = _Undefined,
    int? userProfileId,
    DateTime? createdAt,
    String? title,
    String? emoji,
    bool? isCompleted,
    Object? completedAt = _Undefined,
  }) {
    return WellnessGoal(
      id: id is int? ? id : this.id,
      userProfileId: userProfileId ?? this.userProfileId,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      emoji: emoji ?? this.emoji,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
    );
  }
}

class WellnessGoalUpdateTable extends _i1.UpdateTable<WellnessGoalTable> {
  WellnessGoalUpdateTable(super.table);

  _i1.ColumnValue<int, int> userProfileId(int value) => _i1.ColumnValue(
    table.userProfileId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> emoji(String value) => _i1.ColumnValue(
    table.emoji,
    value,
  );

  _i1.ColumnValue<bool, bool> isCompleted(bool value) => _i1.ColumnValue(
    table.isCompleted,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.completedAt,
        value,
      );
}

class WellnessGoalTable extends _i1.Table<int?> {
  WellnessGoalTable({super.tableRelation})
    : super(tableName: 'wellness_goals') {
    updateTable = WellnessGoalUpdateTable(this);
    userProfileId = _i1.ColumnInt(
      'userProfileId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    emoji = _i1.ColumnString(
      'emoji',
      this,
    );
    isCompleted = _i1.ColumnBool(
      'isCompleted',
      this,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
      this,
    );
  }

  late final WellnessGoalUpdateTable updateTable;

  late final _i1.ColumnInt userProfileId;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnString title;

  late final _i1.ColumnString emoji;

  late final _i1.ColumnBool isCompleted;

  late final _i1.ColumnDateTime completedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userProfileId,
    createdAt,
    title,
    emoji,
    isCompleted,
    completedAt,
  ];
}

class WellnessGoalInclude extends _i1.IncludeObject {
  WellnessGoalInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => WellnessGoal.t;
}

class WellnessGoalIncludeList extends _i1.IncludeList {
  WellnessGoalIncludeList._({
    _i1.WhereExpressionBuilder<WellnessGoalTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WellnessGoal.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => WellnessGoal.t;
}

class WellnessGoalRepository {
  const WellnessGoalRepository._();

  /// Returns a list of [WellnessGoal]s matching the given query parameters.
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
  Future<List<WellnessGoal>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WellnessGoalTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WellnessGoalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WellnessGoalTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<WellnessGoal>(
      where: where?.call(WellnessGoal.t),
      orderBy: orderBy?.call(WellnessGoal.t),
      orderByList: orderByList?.call(WellnessGoal.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [WellnessGoal] matching the given query parameters.
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
  Future<WellnessGoal?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WellnessGoalTable>? where,
    int? offset,
    _i1.OrderByBuilder<WellnessGoalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WellnessGoalTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<WellnessGoal>(
      where: where?.call(WellnessGoal.t),
      orderBy: orderBy?.call(WellnessGoal.t),
      orderByList: orderByList?.call(WellnessGoal.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [WellnessGoal] by its [id] or null if no such row exists.
  Future<WellnessGoal?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<WellnessGoal>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [WellnessGoal]s in the list and returns the inserted rows.
  ///
  /// The returned [WellnessGoal]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<WellnessGoal>> insert(
    _i1.Session session,
    List<WellnessGoal> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<WellnessGoal>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [WellnessGoal] and returns the inserted row.
  ///
  /// The returned [WellnessGoal] will have its `id` field set.
  Future<WellnessGoal> insertRow(
    _i1.Session session,
    WellnessGoal row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<WellnessGoal>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [WellnessGoal]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<WellnessGoal>> update(
    _i1.Session session,
    List<WellnessGoal> rows, {
    _i1.ColumnSelections<WellnessGoalTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<WellnessGoal>(
      rows,
      columns: columns?.call(WellnessGoal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WellnessGoal]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WellnessGoal> updateRow(
    _i1.Session session,
    WellnessGoal row, {
    _i1.ColumnSelections<WellnessGoalTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<WellnessGoal>(
      row,
      columns: columns?.call(WellnessGoal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WellnessGoal] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WellnessGoal?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<WellnessGoalUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<WellnessGoal>(
      id,
      columnValues: columnValues(WellnessGoal.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WellnessGoal]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<WellnessGoal>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<WellnessGoalUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<WellnessGoalTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WellnessGoalTable>? orderBy,
    _i1.OrderByListBuilder<WellnessGoalTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<WellnessGoal>(
      columnValues: columnValues(WellnessGoal.t.updateTable),
      where: where(WellnessGoal.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WellnessGoal.t),
      orderByList: orderByList?.call(WellnessGoal.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [WellnessGoal]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<WellnessGoal>> delete(
    _i1.Session session,
    List<WellnessGoal> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<WellnessGoal>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [WellnessGoal].
  Future<WellnessGoal> deleteRow(
    _i1.Session session,
    WellnessGoal row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WellnessGoal>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<WellnessGoal>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<WellnessGoalTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<WellnessGoal>(
      where: where(WellnessGoal.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WellnessGoalTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<WellnessGoal>(
      where: where?.call(WellnessGoal.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
