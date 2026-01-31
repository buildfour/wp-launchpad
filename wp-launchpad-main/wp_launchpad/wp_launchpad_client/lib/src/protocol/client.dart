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
import 'dart:async' as _i2;
import 'package:wp_launchpad_client/src/protocol/activity_log.dart' as _i3;
import 'package:wp_launchpad_client/src/protocol/access_session.dart' as _i4;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i5;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i6;
import 'package:wp_launchpad_client/src/protocol/greetings/greeting.dart'
    as _i7;
import 'package:wp_launchpad_client/src/protocol/project_state.dart' as _i8;
import 'package:wp_launchpad_client/src/protocol/user.dart' as _i9;
import 'protocol.dart' as _i10;

/// {@category Endpoint}
class EndpointActivity extends _i1.EndpointRef {
  EndpointActivity(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'activity';

  /// Log an activity
  _i2.Future<_i3.ActivityLog> logActivity(
    String visitorId,
    String action, {
    String? details,
    int? projectId,
    String? projectName,
  }) => caller.callServerEndpoint<_i3.ActivityLog>(
    'activity',
    'logActivity',
    {
      'visitorId': visitorId,
      'action': action,
      'details': details,
      'projectId': projectId,
      'projectName': projectName,
    },
  );

  /// Get activities for a user
  _i2.Future<List<_i3.ActivityLog>> getActivitiesForUser(
    String visitorId, {
    required int limit,
  }) => caller.callServerEndpoint<List<_i3.ActivityLog>>(
    'activity',
    'getActivitiesForUser',
    {
      'visitorId': visitorId,
      'limit': limit,
    },
  );
}

/// {@category Endpoint}
class EndpointAuth extends _i1.EndpointRef {
  EndpointAuth(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  /// Generates token for a user (admin only) - auto-generates userId
  _i2.Future<Map<String, String>?> generateTokenWithUserId(String password) =>
      caller.callServerEndpoint<Map<String, String>?>(
        'auth',
        'generateTokenWithUserId',
        {'password': password},
      );

  /// Generates token for a user (admin only)
  _i2.Future<String?> generateTokenForUser(
    String password,
    String userEmail,
  ) => caller.callServerEndpoint<String?>(
    'auth',
    'generateTokenForUser',
    {
      'password': password,
      'userEmail': userEmail,
    },
  );

  /// Validates admin password and generates a new token.
  _i2.Future<String?> generateTokenWithPassword(String password) =>
      caller.callServerEndpoint<String?>(
        'auth',
        'generateTokenWithPassword',
        {'password': password},
      );

  /// Validates admin password.
  _i2.Future<bool> validateAdminPassword(String password) =>
      caller.callServerEndpoint<bool>(
        'auth',
        'validateAdminPassword',
        {'password': password},
      );

  /// Validates a token and returns session info.
  _i2.Future<_i4.AccessSession?> validateTokenAndGetSession(String token) =>
      caller.callServerEndpoint<_i4.AccessSession?>(
        'auth',
        'validateTokenAndGetSession',
        {'token': token},
        authenticated: false,
      );

  /// Exchanges token for sessionId - returns sessionId for client storage
  _i2.Future<String?> exchangeTokenForSession(String token) =>
      caller.callServerEndpoint<String?>(
        'auth',
        'exchangeTokenForSession',
        {'token': token},
        authenticated: false,
      );

  /// Gets session by sessionId (for auth handler)
  _i2.Future<_i4.AccessSession?> getSessionBySessionId(String sessionId) =>
      caller.callServerEndpoint<_i4.AccessSession?>(
        'auth',
        'getSessionBySessionId',
        {'sessionId': sessionId},
      );

  /// Validates a token.
  _i2.Future<bool> validateToken(String token) =>
      caller.callServerEndpoint<bool>(
        'auth',
        'validateToken',
        {'token': token},
        authenticated: false,
      );

  /// Links user to existing token
  _i2.Future<bool> linkUserToToken(
    String token,
    String email,
    String name,
  ) => caller.callServerEndpoint<bool>(
    'auth',
    'linkUserToToken',
    {
      'token': token,
      'email': email,
      'name': name,
    },
    authenticated: false,
  );

  /// Parses a token from a .wplp file.
  _i2.Future<String?> parseTokenFromFile(String fileContent) =>
      caller.callServerEndpoint<String?>(
        'auth',
        'parseTokenFromFile',
        {'fileContent': fileContent},
      );
}

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _i5.EndpointEmailIdpBase {
  EndpointEmailIdp(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i2.Future<_i6.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_i6.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _i2.Future<_i1.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_i1.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _i2.Future<String> verifyRegistrationCode({
    required _i1.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _i2.Future<_i6.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_i6.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _i2.Future<_i1.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_i1.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _i2.Future<String> verifyPasswordResetCode({
    required _i1.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i2.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _i6.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _i2.Future<_i6.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i6.AuthSuccess>(
    'jwtRefresh',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i1.EndpointRef {
  EndpointGreeting(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i2.Future<_i7.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i7.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

/// {@category Endpoint}
class EndpointProject extends _i1.EndpointRef {
  EndpointProject(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'project';

  /// Returns all projects for a specific user.
  _i2.Future<List<_i8.ProjectState>> getProjectsForUser(String visitorId) =>
      caller.callServerEndpoint<List<_i8.ProjectState>>(
        'project',
        'getProjectsForUser',
        {'visitorId': visitorId},
      );

  /// Returns all projects (admin).
  _i2.Future<List<_i8.ProjectState>> getAllProjects() =>
      caller.callServerEndpoint<List<_i8.ProjectState>>(
        'project',
        'getAllProjects',
        {},
      );

  /// Returns a project by ID.
  _i2.Future<_i8.ProjectState?> getProjectById(int id) =>
      caller.callServerEndpoint<_i8.ProjectState?>(
        'project',
        'getProjectById',
        {'id': id},
      );

  /// Creates a new project for a user.
  _i2.Future<_i8.ProjectState> createProject(
    String name,
    String visitorId,
  ) => caller.callServerEndpoint<_i8.ProjectState>(
    'project',
    'createProject',
    {
      'name': name,
      'visitorId': visitorId,
    },
  );

  /// Updates project state.
  _i2.Future<_i8.ProjectState> updateProjectState(_i8.ProjectState state) =>
      caller.callServerEndpoint<_i8.ProjectState>(
        'project',
        'updateProjectState',
        {'state': state},
      );

  /// Deletes a project by ID.
  _i2.Future<bool> deleteProject(int id) => caller.callServerEndpoint<bool>(
    'project',
    'deleteProject',
    {'id': id},
  );
}

/// {@category Endpoint}
class EndpointUser extends _i1.EndpointRef {
  EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  _i2.Future<_i9.User?> registerUser(
    String email,
    String name,
  ) => caller.callServerEndpoint<_i9.User?>(
    'user',
    'registerUser',
    {
      'email': email,
      'name': name,
    },
  );

  _i2.Future<_i9.User?> getUserByEmail(String email) =>
      caller.callServerEndpoint<_i9.User?>(
        'user',
        'getUserByEmail',
        {'email': email},
      );

  _i2.Future<_i9.User?> getUserById(int id) =>
      caller.callServerEndpoint<_i9.User?>(
        'user',
        'getUserById',
        {'id': id},
      );

  _i2.Future<bool> updateUser(
    String email,
    String name,
  ) => caller.callServerEndpoint<bool>(
    'user',
    'updateUser',
    {
      'email': email,
      'name': name,
    },
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _i5.Caller(client);
    serverpod_auth_core = _i6.Caller(client);
  }

  late final _i5.Caller serverpod_auth_idp;

  late final _i6.Caller serverpod_auth_core;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i10.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    activity = EndpointActivity(this);
    auth = EndpointAuth(this);
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    greeting = EndpointGreeting(this);
    project = EndpointProject(this);
    user = EndpointUser(this);
    modules = Modules(this);
  }

  late final EndpointActivity activity;

  late final EndpointAuth auth;

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointGreeting greeting;

  late final EndpointProject project;

  late final EndpointUser user;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
    'activity': activity,
    'auth': auth,
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'greeting': greeting,
    'project': project,
    'user': user,
  };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
