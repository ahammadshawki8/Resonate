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

/// Emergency or support contact.
abstract class Contact
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Contact._({
    this.id,
    this.userProfileId,
    required this.name,
    this.phone,
    this.email,
    this.relationship,
    this.emoji,
    this.isPrimary,
    this.createdAt,
    this.updatedAt,
  });

  factory Contact({
    int? id,
    int? userProfileId,
    required String name,
    String? phone,
    String? email,
    String? relationship,
    String? emoji,
    bool? isPrimary,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ContactImpl;

  factory Contact.fromJson(Map<String, dynamic> jsonSerialization) {
    return Contact(
      id: jsonSerialization['id'] as int?,
      userProfileId: jsonSerialization['userProfileId'] as int?,
      name: jsonSerialization['name'] as String,
      phone: jsonSerialization['phone'] as String?,
      email: jsonSerialization['email'] as String?,
      relationship: jsonSerialization['relationship'] as String?,
      emoji: jsonSerialization['emoji'] as String?,
      isPrimary: jsonSerialization['isPrimary'] as bool?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ContactTable();

  static const db = ContactRepository._();

  @override
  int? id;

  int? userProfileId;

  String name;

  String? phone;

  String? email;

  String? relationship;

  String? emoji;

  bool? isPrimary;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Contact]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Contact copyWith({
    int? id,
    int? userProfileId,
    String? name,
    String? phone,
    String? email,
    String? relationship,
    String? emoji,
    bool? isPrimary,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Contact',
      if (id != null) 'id': id,
      if (userProfileId != null) 'userProfileId': userProfileId,
      'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (relationship != null) 'relationship': relationship,
      if (emoji != null) 'emoji': emoji,
      if (isPrimary != null) 'isPrimary': isPrimary,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
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

  static ContactInclude include() {
    return ContactInclude._();
  }

  static ContactIncludeList includeList({
    _i1.WhereExpressionBuilder<ContactTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ContactTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ContactTable>? orderByList,
    ContactInclude? include,
  }) {
    return ContactIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Contact.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Contact.t),
      include: include,
    );
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
    int? userProfileId,
    required String name,
    String? phone,
    String? email,
    String? relationship,
    String? emoji,
    bool? isPrimary,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userProfileId: userProfileId,
         name: name,
         phone: phone,
         email: email,
         relationship: relationship,
         emoji: emoji,
         isPrimary: isPrimary,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Contact]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Contact copyWith({
    Object? id = _Undefined,
    Object? userProfileId = _Undefined,
    String? name,
    Object? phone = _Undefined,
    Object? email = _Undefined,
    Object? relationship = _Undefined,
    Object? emoji = _Undefined,
    Object? isPrimary = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return Contact(
      id: id is int? ? id : this.id,
      userProfileId: userProfileId is int? ? userProfileId : this.userProfileId,
      name: name ?? this.name,
      phone: phone is String? ? phone : this.phone,
      email: email is String? ? email : this.email,
      relationship: relationship is String? ? relationship : this.relationship,
      emoji: emoji is String? ? emoji : this.emoji,
      isPrimary: isPrimary is bool? ? isPrimary : this.isPrimary,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class ContactUpdateTable extends _i1.UpdateTable<ContactTable> {
  ContactUpdateTable(super.table);

  _i1.ColumnValue<int, int> userProfileId(int? value) => _i1.ColumnValue(
    table.userProfileId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> phone(String? value) => _i1.ColumnValue(
    table.phone,
    value,
  );

  _i1.ColumnValue<String, String> email(String? value) => _i1.ColumnValue(
    table.email,
    value,
  );

  _i1.ColumnValue<String, String> relationship(String? value) =>
      _i1.ColumnValue(
        table.relationship,
        value,
      );

  _i1.ColumnValue<String, String> emoji(String? value) => _i1.ColumnValue(
    table.emoji,
    value,
  );

  _i1.ColumnValue<bool, bool> isPrimary(bool? value) => _i1.ColumnValue(
    table.isPrimary,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class ContactTable extends _i1.Table<int?> {
  ContactTable({super.tableRelation}) : super(tableName: 'contacts') {
    updateTable = ContactUpdateTable(this);
    userProfileId = _i1.ColumnInt(
      'userProfileId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    phone = _i1.ColumnString(
      'phone',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    relationship = _i1.ColumnString(
      'relationship',
      this,
    );
    emoji = _i1.ColumnString(
      'emoji',
      this,
    );
    isPrimary = _i1.ColumnBool(
      'isPrimary',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final ContactUpdateTable updateTable;

  late final _i1.ColumnInt userProfileId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString phone;

  late final _i1.ColumnString email;

  late final _i1.ColumnString relationship;

  late final _i1.ColumnString emoji;

  late final _i1.ColumnBool isPrimary;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userProfileId,
    name,
    phone,
    email,
    relationship,
    emoji,
    isPrimary,
    createdAt,
    updatedAt,
  ];
}

class ContactInclude extends _i1.IncludeObject {
  ContactInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Contact.t;
}

class ContactIncludeList extends _i1.IncludeList {
  ContactIncludeList._({
    _i1.WhereExpressionBuilder<ContactTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Contact.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Contact.t;
}

class ContactRepository {
  const ContactRepository._();

  /// Returns a list of [Contact]s matching the given query parameters.
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
  Future<List<Contact>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ContactTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ContactTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ContactTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Contact>(
      where: where?.call(Contact.t),
      orderBy: orderBy?.call(Contact.t),
      orderByList: orderByList?.call(Contact.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Contact] matching the given query parameters.
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
  Future<Contact?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ContactTable>? where,
    int? offset,
    _i1.OrderByBuilder<ContactTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ContactTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Contact>(
      where: where?.call(Contact.t),
      orderBy: orderBy?.call(Contact.t),
      orderByList: orderByList?.call(Contact.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Contact] by its [id] or null if no such row exists.
  Future<Contact?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Contact>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Contact]s in the list and returns the inserted rows.
  ///
  /// The returned [Contact]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Contact>> insert(
    _i1.Session session,
    List<Contact> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Contact>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Contact] and returns the inserted row.
  ///
  /// The returned [Contact] will have its `id` field set.
  Future<Contact> insertRow(
    _i1.Session session,
    Contact row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Contact>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Contact]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Contact>> update(
    _i1.Session session,
    List<Contact> rows, {
    _i1.ColumnSelections<ContactTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Contact>(
      rows,
      columns: columns?.call(Contact.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Contact]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Contact> updateRow(
    _i1.Session session,
    Contact row, {
    _i1.ColumnSelections<ContactTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Contact>(
      row,
      columns: columns?.call(Contact.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Contact] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Contact?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<ContactUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Contact>(
      id,
      columnValues: columnValues(Contact.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Contact]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Contact>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ContactUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ContactTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ContactTable>? orderBy,
    _i1.OrderByListBuilder<ContactTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Contact>(
      columnValues: columnValues(Contact.t.updateTable),
      where: where(Contact.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Contact.t),
      orderByList: orderByList?.call(Contact.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Contact]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Contact>> delete(
    _i1.Session session,
    List<Contact> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Contact>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Contact].
  Future<Contact> deleteRow(
    _i1.Session session,
    Contact row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Contact>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Contact>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ContactTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Contact>(
      where: where(Contact.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ContactTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Contact>(
      where: where?.call(Contact.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
