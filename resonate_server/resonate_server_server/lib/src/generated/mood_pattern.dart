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

/// Detected mood pattern over time.
abstract class MoodPattern
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  MoodPattern._({
    this.id,
    required this.userProfileId,
    required this.patternType,
    required this.description,
    required this.confidence,
    required this.detectedAt,
  });

  factory MoodPattern({
    int? id,
    required int userProfileId,
    required String patternType,
    required String description,
    required double confidence,
    required DateTime detectedAt,
  }) = _MoodPatternImpl;

  factory MoodPattern.fromJson(Map<String, dynamic> jsonSerialization) {
    return MoodPattern(
      id: jsonSerialization['id'] as int?,
      userProfileId: jsonSerialization['userProfileId'] as int,
      patternType: jsonSerialization['patternType'] as String,
      description: jsonSerialization['description'] as String,
      confidence: (jsonSerialization['confidence'] as num).toDouble(),
      detectedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['detectedAt'],
      ),
    );
  }

  static final t = MoodPatternTable();

  static const db = MoodPatternRepository._();

  @override
  int? id;

  int userProfileId;

  String patternType;

  String description;

  double confidence;

  DateTime detectedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [MoodPattern]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MoodPattern copyWith({
    int? id,
    int? userProfileId,
    String? patternType,
    String? description,
    double? confidence,
    DateTime? detectedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MoodPattern',
      if (id != null) 'id': id,
      'userProfileId': userProfileId,
      'patternType': patternType,
      'description': description,
      'confidence': confidence,
      'detectedAt': detectedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MoodPattern',
      if (id != null) 'id': id,
      'userProfileId': userProfileId,
      'patternType': patternType,
      'description': description,
      'confidence': confidence,
      'detectedAt': detectedAt.toJson(),
    };
  }

  static MoodPatternInclude include() {
    return MoodPatternInclude._();
  }

  static MoodPatternIncludeList includeList({
    _i1.WhereExpressionBuilder<MoodPatternTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MoodPatternTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MoodPatternTable>? orderByList,
    MoodPatternInclude? include,
  }) {
    return MoodPatternIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MoodPattern.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MoodPattern.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MoodPatternImpl extends MoodPattern {
  _MoodPatternImpl({
    int? id,
    required int userProfileId,
    required String patternType,
    required String description,
    required double confidence,
    required DateTime detectedAt,
  }) : super._(
         id: id,
         userProfileId: userProfileId,
         patternType: patternType,
         description: description,
         confidence: confidence,
         detectedAt: detectedAt,
       );

  /// Returns a shallow copy of this [MoodPattern]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MoodPattern copyWith({
    Object? id = _Undefined,
    int? userProfileId,
    String? patternType,
    String? description,
    double? confidence,
    DateTime? detectedAt,
  }) {
    return MoodPattern(
      id: id is int? ? id : this.id,
      userProfileId: userProfileId ?? this.userProfileId,
      patternType: patternType ?? this.patternType,
      description: description ?? this.description,
      confidence: confidence ?? this.confidence,
      detectedAt: detectedAt ?? this.detectedAt,
    );
  }
}

class MoodPatternUpdateTable extends _i1.UpdateTable<MoodPatternTable> {
  MoodPatternUpdateTable(super.table);

  _i1.ColumnValue<int, int> userProfileId(int value) => _i1.ColumnValue(
    table.userProfileId,
    value,
  );

  _i1.ColumnValue<String, String> patternType(String value) => _i1.ColumnValue(
    table.patternType,
    value,
  );

  _i1.ColumnValue<String, String> description(String value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<double, double> confidence(double value) => _i1.ColumnValue(
    table.confidence,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> detectedAt(DateTime value) =>
      _i1.ColumnValue(
        table.detectedAt,
        value,
      );
}

class MoodPatternTable extends _i1.Table<int?> {
  MoodPatternTable({super.tableRelation}) : super(tableName: 'mood_patterns') {
    updateTable = MoodPatternUpdateTable(this);
    userProfileId = _i1.ColumnInt(
      'userProfileId',
      this,
    );
    patternType = _i1.ColumnString(
      'patternType',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    confidence = _i1.ColumnDouble(
      'confidence',
      this,
    );
    detectedAt = _i1.ColumnDateTime(
      'detectedAt',
      this,
    );
  }

  late final MoodPatternUpdateTable updateTable;

  late final _i1.ColumnInt userProfileId;

  late final _i1.ColumnString patternType;

  late final _i1.ColumnString description;

  late final _i1.ColumnDouble confidence;

  late final _i1.ColumnDateTime detectedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userProfileId,
    patternType,
    description,
    confidence,
    detectedAt,
  ];
}

class MoodPatternInclude extends _i1.IncludeObject {
  MoodPatternInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => MoodPattern.t;
}

class MoodPatternIncludeList extends _i1.IncludeList {
  MoodPatternIncludeList._({
    _i1.WhereExpressionBuilder<MoodPatternTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MoodPattern.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => MoodPattern.t;
}

class MoodPatternRepository {
  const MoodPatternRepository._();

  /// Returns a list of [MoodPattern]s matching the given query parameters.
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
  Future<List<MoodPattern>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MoodPatternTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MoodPatternTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MoodPatternTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<MoodPattern>(
      where: where?.call(MoodPattern.t),
      orderBy: orderBy?.call(MoodPattern.t),
      orderByList: orderByList?.call(MoodPattern.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [MoodPattern] matching the given query parameters.
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
  Future<MoodPattern?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MoodPatternTable>? where,
    int? offset,
    _i1.OrderByBuilder<MoodPatternTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MoodPatternTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<MoodPattern>(
      where: where?.call(MoodPattern.t),
      orderBy: orderBy?.call(MoodPattern.t),
      orderByList: orderByList?.call(MoodPattern.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [MoodPattern] by its [id] or null if no such row exists.
  Future<MoodPattern?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<MoodPattern>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [MoodPattern]s in the list and returns the inserted rows.
  ///
  /// The returned [MoodPattern]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<MoodPattern>> insert(
    _i1.Session session,
    List<MoodPattern> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<MoodPattern>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [MoodPattern] and returns the inserted row.
  ///
  /// The returned [MoodPattern] will have its `id` field set.
  Future<MoodPattern> insertRow(
    _i1.Session session,
    MoodPattern row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MoodPattern>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MoodPattern]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MoodPattern>> update(
    _i1.Session session,
    List<MoodPattern> rows, {
    _i1.ColumnSelections<MoodPatternTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MoodPattern>(
      rows,
      columns: columns?.call(MoodPattern.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MoodPattern]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MoodPattern> updateRow(
    _i1.Session session,
    MoodPattern row, {
    _i1.ColumnSelections<MoodPatternTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MoodPattern>(
      row,
      columns: columns?.call(MoodPattern.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MoodPattern] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MoodPattern?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<MoodPatternUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<MoodPattern>(
      id,
      columnValues: columnValues(MoodPattern.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MoodPattern]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<MoodPattern>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<MoodPatternUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<MoodPatternTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MoodPatternTable>? orderBy,
    _i1.OrderByListBuilder<MoodPatternTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<MoodPattern>(
      columnValues: columnValues(MoodPattern.t.updateTable),
      where: where(MoodPattern.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MoodPattern.t),
      orderByList: orderByList?.call(MoodPattern.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [MoodPattern]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MoodPattern>> delete(
    _i1.Session session,
    List<MoodPattern> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MoodPattern>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MoodPattern].
  Future<MoodPattern> deleteRow(
    _i1.Session session,
    MoodPattern row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MoodPattern>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MoodPattern>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MoodPatternTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MoodPattern>(
      where: where(MoodPattern.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MoodPatternTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MoodPattern>(
      where: where?.call(MoodPattern.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
