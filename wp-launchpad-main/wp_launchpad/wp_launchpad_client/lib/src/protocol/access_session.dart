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

abstract class AccessSession implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String token;

  DateTime expiry;

  int? userId;

  String? userEmail;

  String? sessionId;

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
