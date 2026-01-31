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

abstract class ActivityLog implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String visitorId;

  String action;

  String? details;

  int? projectId;

  String? projectName;

  DateTime createdAt;

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
