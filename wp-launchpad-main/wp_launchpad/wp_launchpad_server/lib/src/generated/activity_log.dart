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

abstract class ActivityLog
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ActivityLog._({
    this.id,
    required this.visitorId,
    required this.action,
    this.details,
    this.projectId,
    this.projectName,
    required this.createdAt,
  });

  factory ActivityLog({
    int? id,
    required String visitorId,
    required String action,
    String? details,
    int? projectId,
    String? projectName,
    required DateTime createdAt,
  }) = _ActivityLogImpl;

  factory ActivityLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return ActivityLog(
      id: jsonSerialization['id'] as int?,
      visitorId: jsonSerialization['visitorId'] as String,
      action: jsonSerialization['action'] as String,
      details: jsonSerialization['details'] as String?,
      projectId: jsonSerialization['projectId'] as int?,
      projectName: jsonSerialization['projectName'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = ActivityLogTable();

  static const db = ActivityLogRepository._();

  @override
  int? id;

  String visitorId;

  String action;

  String? details;

  int? projectId;

  String? projectName;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ActivityLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ActivityLog copyWith({
    int? id,
    String? visitorId,
    String? action,
    String? details,
    int? projectId,
    String? projectName,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ActivityLog',
      if (id != null) 'id': id,
      'visitorId': visitorId,
      'action': action,
      if (details != null) 'details': details,
      if (projectId != null) 'projectId': projectId,
      if (projectName != null) 'projectName': projectName,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ActivityLog',
      if (id != null) 'id': id,
      'visitorId': visitorId,
      'action': action,
      if (details != null) 'details': details,
      if (projectId != null) 'projectId': projectId,
      if (projectName != null) 'projectName': projectName,
      'createdAt': createdAt.toJson(),
    };
  }

  static ActivityLogInclude include() {
    return ActivityLogInclude._();
  }

  static ActivityLogIncludeList includeList({
    _i1.WhereExpressionBuilder<ActivityLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ActivityLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ActivityLogTable>? orderByList,
    ActivityLogInclude? include,
  }) {
    return ActivityLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ActivityLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ActivityLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ActivityLogImpl extends ActivityLog {
  _ActivityLogImpl({
    int? id,
    required String visitorId,
    required String action,
    String? details,
    int? projectId,
    String? projectName,
    required DateTime createdAt,
  }) : super._(
         id: id,
         visitorId: visitorId,
         action: action,
         details: details,
         projectId: projectId,
         projectName: projectName,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ActivityLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ActivityLog copyWith({
    Object? id = _Undefined,
    String? visitorId,
    String? action,
    Object? details = _Undefined,
    Object? projectId = _Undefined,
    Object? projectName = _Undefined,
    DateTime? createdAt,
  }) {
    return ActivityLog(
      id: id is int? ? id : this.id,
      visitorId: visitorId ?? this.visitorId,
      action: action ?? this.action,
      details: details is String? ? details : this.details,
      projectId: projectId is int? ? projectId : this.projectId,
      projectName: projectName is String? ? projectName : this.projectName,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ActivityLogUpdateTable extends _i1.UpdateTable<ActivityLogTable> {
  ActivityLogUpdateTable(super.table);

  _i1.ColumnValue<String, String> visitorId(String value) => _i1.ColumnValue(
    table.visitorId,
    value,
  );

  _i1.ColumnValue<String, String> action(String value) => _i1.ColumnValue(
    table.action,
    value,
  );

  _i1.ColumnValue<String, String> details(String? value) => _i1.ColumnValue(
    table.details,
    value,
  );

  _i1.ColumnValue<int, int> projectId(int? value) => _i1.ColumnValue(
    table.projectId,
    value,
  );

  _i1.ColumnValue<String, String> projectName(String? value) => _i1.ColumnValue(
    table.projectName,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class ActivityLogTable extends _i1.Table<int?> {
  ActivityLogTable({super.tableRelation}) : super(tableName: 'activity_log') {
    updateTable = ActivityLogUpdateTable(this);
    visitorId = _i1.ColumnString(
      'visitorId',
      this,
    );
    action = _i1.ColumnString(
      'action',
      this,
    );
    details = _i1.ColumnString(
      'details',
      this,
    );
    projectId = _i1.ColumnInt(
      'projectId',
      this,
    );
    projectName = _i1.ColumnString(
      'projectName',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final ActivityLogUpdateTable updateTable;

  late final _i1.ColumnString visitorId;

  late final _i1.ColumnString action;

  late final _i1.ColumnString details;

  late final _i1.ColumnInt projectId;

  late final _i1.ColumnString projectName;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    visitorId,
    action,
    details,
    projectId,
    projectName,
    createdAt,
  ];
}

class ActivityLogInclude extends _i1.IncludeObject {
  ActivityLogInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ActivityLog.t;
}

class ActivityLogIncludeList extends _i1.IncludeList {
  ActivityLogIncludeList._({
    _i1.WhereExpressionBuilder<ActivityLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ActivityLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ActivityLog.t;
}

class ActivityLogRepository {
  const ActivityLogRepository._();

  /// Returns a list of [ActivityLog]s matching the given query parameters.
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
  Future<List<ActivityLog>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ActivityLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ActivityLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ActivityLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ActivityLog>(
      where: where?.call(ActivityLog.t),
      orderBy: orderBy?.call(ActivityLog.t),
      orderByList: orderByList?.call(ActivityLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ActivityLog] matching the given query parameters.
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
  Future<ActivityLog?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ActivityLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<ActivityLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ActivityLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ActivityLog>(
      where: where?.call(ActivityLog.t),
      orderBy: orderBy?.call(ActivityLog.t),
      orderByList: orderByList?.call(ActivityLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ActivityLog] by its [id] or null if no such row exists.
  Future<ActivityLog?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ActivityLog>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ActivityLog]s in the list and returns the inserted rows.
  ///
  /// The returned [ActivityLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ActivityLog>> insert(
    _i1.Session session,
    List<ActivityLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ActivityLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ActivityLog] and returns the inserted row.
  ///
  /// The returned [ActivityLog] will have its `id` field set.
  Future<ActivityLog> insertRow(
    _i1.Session session,
    ActivityLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ActivityLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ActivityLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ActivityLog>> update(
    _i1.Session session,
    List<ActivityLog> rows, {
    _i1.ColumnSelections<ActivityLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ActivityLog>(
      rows,
      columns: columns?.call(ActivityLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ActivityLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ActivityLog> updateRow(
    _i1.Session session,
    ActivityLog row, {
    _i1.ColumnSelections<ActivityLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ActivityLog>(
      row,
      columns: columns?.call(ActivityLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ActivityLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ActivityLog?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<ActivityLogUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ActivityLog>(
      id,
      columnValues: columnValues(ActivityLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ActivityLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ActivityLog>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ActivityLogUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ActivityLogTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ActivityLogTable>? orderBy,
    _i1.OrderByListBuilder<ActivityLogTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ActivityLog>(
      columnValues: columnValues(ActivityLog.t.updateTable),
      where: where(ActivityLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ActivityLog.t),
      orderByList: orderByList?.call(ActivityLog.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ActivityLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ActivityLog>> delete(
    _i1.Session session,
    List<ActivityLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ActivityLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ActivityLog].
  Future<ActivityLog> deleteRow(
    _i1.Session session,
    ActivityLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ActivityLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ActivityLog>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ActivityLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ActivityLog>(
      where: where(ActivityLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ActivityLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ActivityLog>(
      where: where?.call(ActivityLog.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
