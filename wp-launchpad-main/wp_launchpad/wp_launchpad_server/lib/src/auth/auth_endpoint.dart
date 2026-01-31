import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class AuthEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  /// Generates token for a user (admin only) - auto-generates userId
  Future<Map<String, String>?> generateTokenWithUserId(Session session, String password) async {
    final adminPassword = session.passwords['adminPassword'];
    if (adminPassword == null || password != adminPassword) return null;
    
    final token = Uuid().v4();
    final generatedUserId = 'WPL-${Uuid().v4().substring(0, 8).toUpperCase()}';
    final expiry = DateTime.now().add(const Duration(days: 30));
    
    final accessSession = AccessSession(token: token, expiry: expiry, userEmail: generatedUserId);
    await AccessSession.db.insertRow(session, accessSession);
    return {'token': token, 'userId': generatedUserId};
  }

  /// Generates token for a user (admin only)
  Future<String?> generateTokenForUser(Session session, String password, String userEmail) async {
    final adminPassword = session.passwords['adminPassword'];
    if (adminPassword == null || password != adminPassword) return null;
    
    final token = Uuid().v4();
    final expiry = DateTime.now().add(const Duration(days: 30));
    final user = await User.db.findFirstRow(session, where: (t) => t.email.equals(userEmail));
    
    final accessSession = AccessSession(token: token, expiry: expiry, userId: user?.id, userEmail: userEmail);
    await AccessSession.db.insertRow(session, accessSession);
    return token;
  }

  /// Validates admin password and generates a new token.
  Future<String?> generateTokenWithPassword(Session session, String password) async {
    final adminPassword = session.passwords['adminPassword'];
    if (adminPassword == null || password != adminPassword) return null;
    
    final token = Uuid().v4();
    final expiry = DateTime.now().add(const Duration(days: 30));
    final accessSession = AccessSession(token: token, expiry: expiry);
    await AccessSession.db.insertRow(session, accessSession);
    return token;
  }

  /// Validates admin password.
  Future<bool> validateAdminPassword(Session session, String password) async {
    final adminPassword = session.passwords['adminPassword'];
    return adminPassword != null && password == adminPassword;
  }

  /// Validates a token and returns session info.
  @unauthenticatedClientCall
  Future<AccessSession?> validateTokenAndGetSession(Session session, String token) async {
    final accessSession = await AccessSession.db.findFirstRow(session, where: (t) => t.token.equals(token));
    if (accessSession == null || accessSession.expiry.isBefore(DateTime.now())) return null;
    return accessSession;
  }

  /// Exchanges token for sessionId - returns sessionId for client storage
  @unauthenticatedClientCall
  Future<String?> exchangeTokenForSession(Session session, String token) async {
    final accessSession = await AccessSession.db.findFirstRow(session, where: (t) => t.token.equals(token));
    if (accessSession == null || accessSession.expiry.isBefore(DateTime.now())) return null;
    
    // Generate new sessionId if not exists
    if (accessSession.sessionId == null) {
      accessSession.sessionId = Uuid().v4();
      await AccessSession.db.updateRow(session, accessSession);
    }
    return accessSession.sessionId;
  }

  /// Gets session by sessionId (for auth handler)
  Future<AccessSession?> getSessionBySessionId(Session session, String sessionId) async {
    final accessSession = await AccessSession.db.findFirstRow(session, where: (t) => t.sessionId.equals(sessionId));
    if (accessSession == null || accessSession.expiry.isBefore(DateTime.now())) return null;
    return accessSession;
  }

  /// Validates a token.
  @unauthenticatedClientCall
  Future<bool> validateToken(Session session, String token) async {
    final accessSession = await AccessSession.db.findFirstRow(session, where: (t) => t.token.equals(token));
    if (accessSession == null || accessSession.expiry.isBefore(DateTime.now())) return false;
    return true;
  }

  /// Links user to existing token
  @unauthenticatedClientCall
  Future<bool> linkUserToToken(Session session, String token, String email, String name) async {
    final accessSession = await AccessSession.db.findFirstRow(session, where: (t) => t.token.equals(token));
    if (accessSession == null) return false;
    
    var user = await User.db.findFirstRow(session, where: (t) => t.email.equals(email));
    user ??= await User.db.insertRow(session, User(email: email, name: name, createdAt: DateTime.now()));
    
    accessSession.userId = user.id;
    accessSession.userEmail = email;
    await AccessSession.db.updateRow(session, accessSession);
    return true;
  }

  /// Parses a token from a .wplp file.
  Future<String?> parseTokenFromFile(Session session, String fileContent) async {
    try {
      final data = jsonDecode(fileContent);
      return data['token'] as String?;
    } catch (e) {
      return null;
    }
  }
}
