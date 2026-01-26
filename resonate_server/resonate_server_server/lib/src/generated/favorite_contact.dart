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

/// Favorite contact for reaching out when feeling down.
abstract class FavoriteContact
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FavoriteContact._({
    this.id,
    required this.userProfileId,
    required this.createdAt,
    required this.name,
    required this.emoji,
    required this.type,
    this.phone,
  });

  factory FavoriteContact({
    int? id,
    required int userProfileId,
    required DateTime createdAt,
    required String name,
    required String emoji,
    required String type,
    String? phone,
  }) = _FavoriteContactImpl;

  factory FavoriteContact.fromJson(Map<String, dynamic> jsonSerialization) {
    return FavoriteContact(
      id: jsonSerialization['id'] as int?,
      userProfileId: jsonSerialization['userProfileId'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      name: jsonSerialization['name'] as String,
      emoji: jsonSerialization['emoji'] as String,
      type: jsonSerialization['type'] as String,
      phone: jsonSerialization['phone'] as String?,
    );
  }

  static final t = FavoriteContactTable();

  static const db = FavoriteContactRepository._();

  @override
  int? id;

  int userProfileId;

  DateTime createdAt;

  String name;

  String emoji;

  String type;

  String? phone;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FavoriteContact]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FavoriteContact copyWith({
    int? id,
    int? userProfileId,
    DateTime? createdAt,
    String? name,
    String? emoji,
    String? type,
    String? phone,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FavoriteContact',
      if (id != null) 'id': id,
      'userProfileId': userProfileId,
      'createdAt': createdAt.toJson(),
      'name': name,
      'emoji': emoji,
      'type': type,
      if (phone != null) 'phone': phone,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FavoriteContact',
      if (id != null) 'id': id,
      'userProfileId': userProfileId,
      'createdAt': createdAt.toJson(),
      'name': name,
      'emoji': emoji,
      'type': type,
      if (phone != null) 'phone': phone,
    };
  }

  static FavoriteContactInclude include() {
    return FavoriteContactInclude._();
  }

  static FavoriteContactIncludeList includeList({
    _i1.WhereExpressionBuilder<FavoriteContactTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FavoriteContactTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FavoriteContactTable>? orderByList,
    FavoriteContactInclude? include,
  }) {
    return FavoriteContactIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FavoriteContact.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FavoriteContact.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FavoriteContactImpl extends FavoriteContact {
  _FavoriteContactImpl({
    int? id,
    required int userProfileId,
    required DateTime createdAt,
    required String name,
    required String emoji,
    required String type,
    String? phone,
  }) : super._(
         id: id,
         userProfileId: userProfileId,
         createdAt: createdAt,
         name: name,
         emoji: emoji,
         type: type,
         phone: phone,
       );

  /// Returns a shallow copy of this [FavoriteContact]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FavoriteContact copyWith({
    Object? id = _Undefined,
    int? userProfileId,
    DateTime? createdAt,
    String? name,
    String? emoji,
    String? type,
    Object? phone = _Undefined,
  }) {
    return FavoriteContact(
      id: id is int? ? id : this.id,
      userProfileId: userProfileId ?? this.userProfileId,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      type: type ?? this.type,
      phone: phone is String? ? phone : this.phone,
    );
  }
}

class FavoriteContactUpdateTable extends _i1.UpdateTable<FavoriteContactTable> {
  FavoriteContactUpdateTable(super.table);

  _i1.ColumnValue<int, int> userProfileId(int value) => _i1.ColumnValue(
    table.userProfileId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> emoji(String value) => _i1.ColumnValue(
    table.emoji,
    value,
  );

  _i1.ColumnValue<String, String> type(String value) => _i1.ColumnValue(
    table.type,
    value,
  );

  _i1.ColumnValue<String, String> phone(String? value) => _i1.ColumnValue(
    table.phone,
    value,
  );
}

class FavoriteContactTable extends _i1.Table<int?> {
  FavoriteContactTable({super.tableRelation})
    : super(tableName: 'favorite_contacts') {
    updateTable = FavoriteContactUpdateTable(this);
    userProfileId = _i1.ColumnInt(
      'userProfileId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    emoji = _i1.ColumnString(
      'emoji',
      this,
    );
    type = _i1.ColumnString(
      'type',
      this,
    );
    phone = _i1.ColumnString(
      'phone',
      this,
    );
  }

  late final FavoriteContactUpdateTable updateTable;

  late final _i1.ColumnInt userProfileId;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnString name;

  late final _i1.ColumnString emoji;

  late final _i1.ColumnString type;

  late final _i1.ColumnString phone;

  @override
  List<_i1.Column> get columns => [
    id,
    userProfileId,
    createdAt,
    name,
    emoji,
    type,
    phone,
  ];
}

class FavoriteContactInclude extends _i1.IncludeObject {
  FavoriteContactInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => FavoriteContact.t;
}

class FavoriteContactIncludeList extends _i1.IncludeList {
  FavoriteContactIncludeList._({
    _i1.WhereExpressionBuilder<FavoriteContactTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FavoriteContact.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FavoriteContact.t;
}

class FavoriteContactRepository {
  const FavoriteContactRepository._();

  /// Returns a list of [FavoriteContact]s matching the given query parameters.
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
  Future<List<FavoriteContact>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FavoriteContactTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FavoriteContactTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FavoriteContactTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<FavoriteContact>(
      where: where?.call(FavoriteContact.t),
      orderBy: orderBy?.call(FavoriteContact.t),
      orderByList: orderByList?.call(FavoriteContact.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [FavoriteContact] matching the given query parameters.
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
  Future<FavoriteContact?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FavoriteContactTable>? where,
    int? offset,
    _i1.OrderByBuilder<FavoriteContactTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FavoriteContactTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<FavoriteContact>(
      where: where?.call(FavoriteContact.t),
      orderBy: orderBy?.call(FavoriteContact.t),
      orderByList: orderByList?.call(FavoriteContact.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [FavoriteContact] by its [id] or null if no such row exists.
  Future<FavoriteContact?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<FavoriteContact>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [FavoriteContact]s in the list and returns the inserted rows.
  ///
  /// The returned [FavoriteContact]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<FavoriteContact>> insert(
    _i1.Session session,
    List<FavoriteContact> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<FavoriteContact>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [FavoriteContact] and returns the inserted row.
  ///
  /// The returned [FavoriteContact] will have its `id` field set.
  Future<FavoriteContact> insertRow(
    _i1.Session session,
    FavoriteContact row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FavoriteContact>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FavoriteContact]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FavoriteContact>> update(
    _i1.Session session,
    List<FavoriteContact> rows, {
    _i1.ColumnSelections<FavoriteContactTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FavoriteContact>(
      rows,
      columns: columns?.call(FavoriteContact.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FavoriteContact]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FavoriteContact> updateRow(
    _i1.Session session,
    FavoriteContact row, {
    _i1.ColumnSelections<FavoriteContactTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FavoriteContact>(
      row,
      columns: columns?.call(FavoriteContact.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FavoriteContact] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FavoriteContact?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<FavoriteContactUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<FavoriteContact>(
      id,
      columnValues: columnValues(FavoriteContact.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FavoriteContact]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<FavoriteContact>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<FavoriteContactUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<FavoriteContactTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FavoriteContactTable>? orderBy,
    _i1.OrderByListBuilder<FavoriteContactTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<FavoriteContact>(
      columnValues: columnValues(FavoriteContact.t.updateTable),
      where: where(FavoriteContact.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FavoriteContact.t),
      orderByList: orderByList?.call(FavoriteContact.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [FavoriteContact]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FavoriteContact>> delete(
    _i1.Session session,
    List<FavoriteContact> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FavoriteContact>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FavoriteContact].
  Future<FavoriteContact> deleteRow(
    _i1.Session session,
    FavoriteContact row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FavoriteContact>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FavoriteContact>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FavoriteContactTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FavoriteContact>(
      where: where(FavoriteContact.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FavoriteContactTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FavoriteContact>(
      where: where?.call(FavoriteContact.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
