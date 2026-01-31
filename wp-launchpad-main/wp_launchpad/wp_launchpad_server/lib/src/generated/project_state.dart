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

abstract class ProjectState
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ProjectState._({
    this.id,
    this.visitorId,
    this.userId,
    this.userEmail,
    required this.name,
    this.domain,
    this.serverIp,
    this.dnsStatus,
    this.hostingProvider,
    this.databaseName,
    this.databaseUser,
    this.databasePassword,
    this.databaseHost,
    this.installationStatus,
    this.template,
    this.currentStep,
    required this.lastModified,
  });

  factory ProjectState({
    int? id,
    String? visitorId,
    int? userId,
    String? userEmail,
    required String name,
    String? domain,
    String? serverIp,
    String? dnsStatus,
    String? hostingProvider,
    String? databaseName,
    String? databaseUser,
    String? databasePassword,
    String? databaseHost,
    String? installationStatus,
    String? template,
    int? currentStep,
    required DateTime lastModified,
  }) = _ProjectStateImpl;

  factory ProjectState.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProjectState(
      id: jsonSerialization['id'] as int?,
      visitorId: jsonSerialization['visitorId'] as String?,
      userId: jsonSerialization['userId'] as int?,
      userEmail: jsonSerialization['userEmail'] as String?,
      name: jsonSerialization['name'] as String,
      domain: jsonSerialization['domain'] as String?,
      serverIp: jsonSerialization['serverIp'] as String?,
      dnsStatus: jsonSerialization['dnsStatus'] as String?,
      hostingProvider: jsonSerialization['hostingProvider'] as String?,
      databaseName: jsonSerialization['databaseName'] as String?,
      databaseUser: jsonSerialization['databaseUser'] as String?,
      databasePassword: jsonSerialization['databasePassword'] as String?,
      databaseHost: jsonSerialization['databaseHost'] as String?,
      installationStatus: jsonSerialization['installationStatus'] as String?,
      template: jsonSerialization['template'] as String?,
      currentStep: jsonSerialization['currentStep'] as int?,
      lastModified: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastModified'],
      ),
    );
  }

  static final t = ProjectStateTable();

  static const db = ProjectStateRepository._();

  @override
  int? id;

  String? visitorId;

  int? userId;

  String? userEmail;

  String name;

  String? domain;

  String? serverIp;

  String? dnsStatus;

  String? hostingProvider;

  String? databaseName;

  String? databaseUser;

  String? databasePassword;

  String? databaseHost;

  String? installationStatus;

  String? template;

  int? currentStep;

  DateTime lastModified;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ProjectState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProjectState copyWith({
    int? id,
    String? visitorId,
    int? userId,
    String? userEmail,
    String? name,
    String? domain,
    String? serverIp,
    String? dnsStatus,
    String? hostingProvider,
    String? databaseName,
    String? databaseUser,
    String? databasePassword,
    String? databaseHost,
    String? installationStatus,
    String? template,
    int? currentStep,
    DateTime? lastModified,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProjectState',
      if (id != null) 'id': id,
      if (visitorId != null) 'visitorId': visitorId,
      if (userId != null) 'userId': userId,
      if (userEmail != null) 'userEmail': userEmail,
      'name': name,
      if (domain != null) 'domain': domain,
      if (serverIp != null) 'serverIp': serverIp,
      if (dnsStatus != null) 'dnsStatus': dnsStatus,
      if (hostingProvider != null) 'hostingProvider': hostingProvider,
      if (databaseName != null) 'databaseName': databaseName,
      if (databaseUser != null) 'databaseUser': databaseUser,
      if (databasePassword != null) 'databasePassword': databasePassword,
      if (databaseHost != null) 'databaseHost': databaseHost,
      if (installationStatus != null) 'installationStatus': installationStatus,
      if (template != null) 'template': template,
      if (currentStep != null) 'currentStep': currentStep,
      'lastModified': lastModified.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProjectState',
      if (id != null) 'id': id,
      if (visitorId != null) 'visitorId': visitorId,
      if (userId != null) 'userId': userId,
      if (userEmail != null) 'userEmail': userEmail,
      'name': name,
      if (domain != null) 'domain': domain,
      if (serverIp != null) 'serverIp': serverIp,
      if (dnsStatus != null) 'dnsStatus': dnsStatus,
      if (hostingProvider != null) 'hostingProvider': hostingProvider,
      if (databaseName != null) 'databaseName': databaseName,
      if (databaseUser != null) 'databaseUser': databaseUser,
      if (databasePassword != null) 'databasePassword': databasePassword,
      if (databaseHost != null) 'databaseHost': databaseHost,
      if (installationStatus != null) 'installationStatus': installationStatus,
      if (template != null) 'template': template,
      if (currentStep != null) 'currentStep': currentStep,
      'lastModified': lastModified.toJson(),
    };
  }

  static ProjectStateInclude include() {
    return ProjectStateInclude._();
  }

  static ProjectStateIncludeList includeList({
    _i1.WhereExpressionBuilder<ProjectStateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProjectStateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProjectStateTable>? orderByList,
    ProjectStateInclude? include,
  }) {
    return ProjectStateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProjectState.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ProjectState.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProjectStateImpl extends ProjectState {
  _ProjectStateImpl({
    int? id,
    String? visitorId,
    int? userId,
    String? userEmail,
    required String name,
    String? domain,
    String? serverIp,
    String? dnsStatus,
    String? hostingProvider,
    String? databaseName,
    String? databaseUser,
    String? databasePassword,
    String? databaseHost,
    String? installationStatus,
    String? template,
    int? currentStep,
    required DateTime lastModified,
  }) : super._(
         id: id,
         visitorId: visitorId,
         userId: userId,
         userEmail: userEmail,
         name: name,
         domain: domain,
         serverIp: serverIp,
         dnsStatus: dnsStatus,
         hostingProvider: hostingProvider,
         databaseName: databaseName,
         databaseUser: databaseUser,
         databasePassword: databasePassword,
         databaseHost: databaseHost,
         installationStatus: installationStatus,
         template: template,
         currentStep: currentStep,
         lastModified: lastModified,
       );

  /// Returns a shallow copy of this [ProjectState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProjectState copyWith({
    Object? id = _Undefined,
    Object? visitorId = _Undefined,
    Object? userId = _Undefined,
    Object? userEmail = _Undefined,
    String? name,
    Object? domain = _Undefined,
    Object? serverIp = _Undefined,
    Object? dnsStatus = _Undefined,
    Object? hostingProvider = _Undefined,
    Object? databaseName = _Undefined,
    Object? databaseUser = _Undefined,
    Object? databasePassword = _Undefined,
    Object? databaseHost = _Undefined,
    Object? installationStatus = _Undefined,
    Object? template = _Undefined,
    Object? currentStep = _Undefined,
    DateTime? lastModified,
  }) {
    return ProjectState(
      id: id is int? ? id : this.id,
      visitorId: visitorId is String? ? visitorId : this.visitorId,
      userId: userId is int? ? userId : this.userId,
      userEmail: userEmail is String? ? userEmail : this.userEmail,
      name: name ?? this.name,
      domain: domain is String? ? domain : this.domain,
      serverIp: serverIp is String? ? serverIp : this.serverIp,
      dnsStatus: dnsStatus is String? ? dnsStatus : this.dnsStatus,
      hostingProvider: hostingProvider is String?
          ? hostingProvider
          : this.hostingProvider,
      databaseName: databaseName is String? ? databaseName : this.databaseName,
      databaseUser: databaseUser is String? ? databaseUser : this.databaseUser,
      databasePassword: databasePassword is String?
          ? databasePassword
          : this.databasePassword,
      databaseHost: databaseHost is String? ? databaseHost : this.databaseHost,
      installationStatus: installationStatus is String?
          ? installationStatus
          : this.installationStatus,
      template: template is String? ? template : this.template,
      currentStep: currentStep is int? ? currentStep : this.currentStep,
      lastModified: lastModified ?? this.lastModified,
    );
  }
}

class ProjectStateUpdateTable extends _i1.UpdateTable<ProjectStateTable> {
  ProjectStateUpdateTable(super.table);

  _i1.ColumnValue<String, String> visitorId(String? value) => _i1.ColumnValue(
    table.visitorId,
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

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> domain(String? value) => _i1.ColumnValue(
    table.domain,
    value,
  );

  _i1.ColumnValue<String, String> serverIp(String? value) => _i1.ColumnValue(
    table.serverIp,
    value,
  );

  _i1.ColumnValue<String, String> dnsStatus(String? value) => _i1.ColumnValue(
    table.dnsStatus,
    value,
  );

  _i1.ColumnValue<String, String> hostingProvider(String? value) =>
      _i1.ColumnValue(
        table.hostingProvider,
        value,
      );

  _i1.ColumnValue<String, String> databaseName(String? value) =>
      _i1.ColumnValue(
        table.databaseName,
        value,
      );

  _i1.ColumnValue<String, String> databaseUser(String? value) =>
      _i1.ColumnValue(
        table.databaseUser,
        value,
      );

  _i1.ColumnValue<String, String> databasePassword(String? value) =>
      _i1.ColumnValue(
        table.databasePassword,
        value,
      );

  _i1.ColumnValue<String, String> databaseHost(String? value) =>
      _i1.ColumnValue(
        table.databaseHost,
        value,
      );

  _i1.ColumnValue<String, String> installationStatus(String? value) =>
      _i1.ColumnValue(
        table.installationStatus,
        value,
      );

  _i1.ColumnValue<String, String> template(String? value) => _i1.ColumnValue(
    table.template,
    value,
  );

  _i1.ColumnValue<int, int> currentStep(int? value) => _i1.ColumnValue(
    table.currentStep,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> lastModified(DateTime value) =>
      _i1.ColumnValue(
        table.lastModified,
        value,
      );
}

class ProjectStateTable extends _i1.Table<int?> {
  ProjectStateTable({super.tableRelation}) : super(tableName: 'project_state') {
    updateTable = ProjectStateUpdateTable(this);
    visitorId = _i1.ColumnString(
      'visitorId',
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
    name = _i1.ColumnString(
      'name',
      this,
    );
    domain = _i1.ColumnString(
      'domain',
      this,
    );
    serverIp = _i1.ColumnString(
      'serverIp',
      this,
    );
    dnsStatus = _i1.ColumnString(
      'dnsStatus',
      this,
    );
    hostingProvider = _i1.ColumnString(
      'hostingProvider',
      this,
    );
    databaseName = _i1.ColumnString(
      'databaseName',
      this,
    );
    databaseUser = _i1.ColumnString(
      'databaseUser',
      this,
    );
    databasePassword = _i1.ColumnString(
      'databasePassword',
      this,
    );
    databaseHost = _i1.ColumnString(
      'databaseHost',
      this,
    );
    installationStatus = _i1.ColumnString(
      'installationStatus',
      this,
    );
    template = _i1.ColumnString(
      'template',
      this,
    );
    currentStep = _i1.ColumnInt(
      'currentStep',
      this,
    );
    lastModified = _i1.ColumnDateTime(
      'lastModified',
      this,
    );
  }

  late final ProjectStateUpdateTable updateTable;

  late final _i1.ColumnString visitorId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString userEmail;

  late final _i1.ColumnString name;

  late final _i1.ColumnString domain;

  late final _i1.ColumnString serverIp;

  late final _i1.ColumnString dnsStatus;

  late final _i1.ColumnString hostingProvider;

  late final _i1.ColumnString databaseName;

  late final _i1.ColumnString databaseUser;

  late final _i1.ColumnString databasePassword;

  late final _i1.ColumnString databaseHost;

  late final _i1.ColumnString installationStatus;

  late final _i1.ColumnString template;

  late final _i1.ColumnInt currentStep;

  late final _i1.ColumnDateTime lastModified;

  @override
  List<_i1.Column> get columns => [
    id,
    visitorId,
    userId,
    userEmail,
    name,
    domain,
    serverIp,
    dnsStatus,
    hostingProvider,
    databaseName,
    databaseUser,
    databasePassword,
    databaseHost,
    installationStatus,
    template,
    currentStep,
    lastModified,
  ];
}

class ProjectStateInclude extends _i1.IncludeObject {
  ProjectStateInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ProjectState.t;
}

class ProjectStateIncludeList extends _i1.IncludeList {
  ProjectStateIncludeList._({
    _i1.WhereExpressionBuilder<ProjectStateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ProjectState.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ProjectState.t;
}

class ProjectStateRepository {
  const ProjectStateRepository._();

  /// Returns a list of [ProjectState]s matching the given query parameters.
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
  Future<List<ProjectState>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ProjectStateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProjectStateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProjectStateTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ProjectState>(
      where: where?.call(ProjectState.t),
      orderBy: orderBy?.call(ProjectState.t),
      orderByList: orderByList?.call(ProjectState.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ProjectState] matching the given query parameters.
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
  Future<ProjectState?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ProjectStateTable>? where,
    int? offset,
    _i1.OrderByBuilder<ProjectStateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProjectStateTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ProjectState>(
      where: where?.call(ProjectState.t),
      orderBy: orderBy?.call(ProjectState.t),
      orderByList: orderByList?.call(ProjectState.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ProjectState] by its [id] or null if no such row exists.
  Future<ProjectState?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ProjectState>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ProjectState]s in the list and returns the inserted rows.
  ///
  /// The returned [ProjectState]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ProjectState>> insert(
    _i1.Session session,
    List<ProjectState> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ProjectState>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ProjectState] and returns the inserted row.
  ///
  /// The returned [ProjectState] will have its `id` field set.
  Future<ProjectState> insertRow(
    _i1.Session session,
    ProjectState row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ProjectState>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ProjectState]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ProjectState>> update(
    _i1.Session session,
    List<ProjectState> rows, {
    _i1.ColumnSelections<ProjectStateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ProjectState>(
      rows,
      columns: columns?.call(ProjectState.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProjectState]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ProjectState> updateRow(
    _i1.Session session,
    ProjectState row, {
    _i1.ColumnSelections<ProjectStateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ProjectState>(
      row,
      columns: columns?.call(ProjectState.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProjectState] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ProjectState?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<ProjectStateUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ProjectState>(
      id,
      columnValues: columnValues(ProjectState.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ProjectState]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ProjectState>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ProjectStateUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ProjectStateTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProjectStateTable>? orderBy,
    _i1.OrderByListBuilder<ProjectStateTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ProjectState>(
      columnValues: columnValues(ProjectState.t.updateTable),
      where: where(ProjectState.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProjectState.t),
      orderByList: orderByList?.call(ProjectState.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ProjectState]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ProjectState>> delete(
    _i1.Session session,
    List<ProjectState> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ProjectState>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ProjectState].
  Future<ProjectState> deleteRow(
    _i1.Session session,
    ProjectState row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ProjectState>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ProjectState>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ProjectStateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ProjectState>(
      where: where(ProjectState.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ProjectStateTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ProjectState>(
      where: where?.call(ProjectState.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
