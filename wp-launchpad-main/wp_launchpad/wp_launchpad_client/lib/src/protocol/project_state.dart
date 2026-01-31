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
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class ProjectState implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
