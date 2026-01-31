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

abstract class AccessSession
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AccessSession._({
    this.id,
    required this.token,
    required this.expiry,
    this.userId,
    this.userEmail,
    this.sessionId,
  });

  factory AccessSession({
    int? id,
    required String token,
    required DateTime expiry,
    int? userId,
    String? userEmail,
    String? sessionId,
  }) = _AccessSessionImpl;

  factory AccessSession.fromJson(Map<String, dynamic> jsonSerialization) {
    return AccessSession(
      id: jsonSerialization['id'] as int?,
      token: jsonSerialization['token'] as String,
      expiry: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiry']),
      userId: jsonSerialization['userId'] as int?,
      userEmail: jsonSerialization['userEmail'] as String?,
      sessionId: jsonSerialization['sessionId'] as String?,
    );
  }

  static final t = AccessSessionTable();

  static const db = AccessSessionRepository._();

  @override
  int? id;

  String token;

  DateTime expiry;

  int? userId;

  String? userEmail;

  String? sessionId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AccessSession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AccessSession copyWith({
    int? id,
    String? token,
    DateTime? expiry,
    int? userId,
    String? userEmail,
    String? sessionId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AccessSession',
      if (id != null) 'id': id,
      'token': token,
      'expiry': expiry.toJson(),
      if (userId != null) 'userId': userId,
      if (userEmail != null) 'userEmail': userEmail,
      if (sessionId != null) 'sessionId': sessionId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AccessSession',
      if (id != null) 'id': id,
      'token': token,
      'expiry': expiry.toJson(),
      if (userId != null) 'userId': userId,
      if (userEmail != null) 'userEmail': userEmail,
      if (sessionId != null) 'sessionId': sessionId,
    };
  }

  static AccessSessionInclude include() {
    return AccessSessionInclude._();
  }

  static AccessSessionIncludeList includeList({
    _i1.WhereExpressionBuilder<AccessSessionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AccessSessionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AccessSessionTable>? orderByList,
    AccessSessionInclude? include,
  }) {
    return AccessSessionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AccessSession.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AccessSession.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AccessSessionImpl extends AccessSession {
  _AccessSessionImpl({
    int? id,
    required String token,
    required DateTime expiry,
    int? userId,
    String? userEmail,
    String? sessionId,
  }) : super._(
         id: id,
         token: token,
         expiry: expiry,
         userId: userId,
         userEmail: userEmail,
         sessionId: sessionId,
       );

  /// Returns a shallow copy of this [AccessSession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AccessSession copyWith({
    Object? id = _Undefined,
    String? token,
    DateTime? expiry,
    Object? userId = _Undefined,
    Object? userEmail = _Undefined,
    Object? sessionId = _Undefined,
  }) {
    return AccessSession(
      id: id is int? ? id : this.id,
      token: token ?? this.token,
      expiry: expiry ?? this.expiry,
      userId: userId is int? ? userId : this.userId,
      userEmail: userEmail is String? ? userEmail : this.userEmail,
      sessionId: sessionId is String? ? sessionId : this.sessionId,
    );
  }
}

class AccessSessionUpdateTable extends _i1.UpdateTable<AccessSessionTable> {
  AccessSessionUpdateTable(super.table);

  _i1.ColumnValue<String, String> token(String value) => _i1.ColumnValue(
    table.token,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> expiry(DateTime value) => _i1.ColumnValue(
    table.expiry,
    value,
  );

  _i1.ColumnValue<int, int> userId(int? value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> userEmail(String? value) => _i1.ColumnValue(
    table.userEmail,
    value,
  );

  _i1.ColumnValue<String, String> sessionId(String? value) => _i1.ColumnValue(
    table.sessionId,
    value,
  );
}

class AccessSessionTable extends _i1.Table<int?> {
  AccessSessionTable({super.tableRelation})
    : super(tableName: 'access_session') {
    updateTable = AccessSessionUpdateTable(this);
    token = _i1.ColumnString(
      'token',
      this,
    );
    expiry = _i1.ColumnDateTime(
      'expiry',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    userEmail = _i1.ColumnString(
      'userEmail',
      this,
    );
    sessionId = _i1.ColumnString(
      'sessionId',
      this,
    );
  }

  late final AccessSessionUpdateTable updateTable;

  late final _i1.ColumnString token;

  late final _i1.ColumnDateTime expiry;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString userEmail;

  late final _i1.ColumnString sessionId;

  @override
  List<_i1.Column> get columns => [
    id,
    token,
    expiry,
    userId,
    userEmail,
    sessionId,
  ];
}

class AccessSessionInclude extends _i1.IncludeObject {
  AccessSessionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AccessSession.t;
}

class AccessSessionIncludeList extends _i1.IncludeList {
  AccessSessionIncludeList._({
    _i1.WhereExpressionBuilder<AccessSessionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AccessSession.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AccessSession.t;
}

class AccessSessionRepository {
  const AccessSessionRepository._();

  /// Returns a list of [AccessSession]s matching the given query parameters.
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
  Future<List<AccessSession>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AccessSessionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AccessSessionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AccessSessionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<AccessSession>(
      where: where?.call(AccessSession.t),
      orderBy: orderBy?.call(AccessSession.t),
      orderByList: orderByList?.call(AccessSession.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [AccessSession] matching the given query parameters.
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
  Future<AccessSession?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AccessSessionTable>? where,
    int? offset,
    _i1.OrderByBuilder<AccessSessionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AccessSessionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<AccessSession>(
      where: where?.call(AccessSession.t),
      orderBy: orderBy?.call(AccessSession.t),
      orderByList: orderByList?.call(AccessSession.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [AccessSession] by its [id] or null if no such row exists.
  Future<AccessSession?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<AccessSession>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [AccessSession]s in the list and returns the inserted rows.
  ///
  /// The returned [AccessSession]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<AccessSession>> insert(
    _i1.Session session,
    List<AccessSession> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<AccessSession>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [AccessSession] and returns the inserted row.
  ///
  /// The returned [AccessSession] will have its `id` field set.
  Future<AccessSession> insertRow(
    _i1.Session session,
    AccessSession row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AccessSession>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AccessSession]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AccessSession>> update(
    _i1.Session session,
    List<AccessSession> rows, {
    _i1.ColumnSelections<AccessSessionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AccessSession>(
      rows,
      columns: columns?.call(AccessSession.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AccessSession]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AccessSession> updateRow(
    _i1.Session session,
    AccessSession row, {
    _i1.ColumnSelections<AccessSessionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AccessSession>(
      row,
      columns: columns?.call(AccessSession.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AccessSession] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AccessSession?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<AccessSessionUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AccessSession>(
      id,
      columnValues: columnValues(AccessSession.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AccessSession]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AccessSession>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<AccessSessionUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AccessSessionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AccessSessionTable>? orderBy,
    _i1.OrderByListBuilder<AccessSessionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AccessSession>(
      columnValues: columnValues(AccessSession.t.updateTable),
      where: where(AccessSession.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AccessSession.t),
      orderByList: orderByList?.call(AccessSession.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AccessSession]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AccessSession>> delete(
    _i1.Session session,
    List<AccessSession> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AccessSession>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AccessSession].
  Future<AccessSession> deleteRow(
    _i1.Session session,
    AccessSession row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AccessSession>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AccessSession>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AccessSessionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AccessSession>(
      where: where(AccessSession.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AccessSessionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AccessSession>(
      where: where?.call(AccessSession.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
