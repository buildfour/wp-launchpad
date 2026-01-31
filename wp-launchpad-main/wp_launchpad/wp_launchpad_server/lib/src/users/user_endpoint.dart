import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class UserEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<User?> registerUser(Session session, String email, String name) async {
    final existing = await User.db.findFirstRow(session, where: (t) => t.email.equals(email));
    if (existing != null) return existing;
    
    final user = User(email: email, name: name, createdAt: DateTime.now());
    return await User.db.insertRow(session, user);
  }

  Future<User?> getUserByEmail(Session session, String email) async {
    return await User.db.findFirstRow(session, where: (t) => t.email.equals(email));
  }

  Future<User?> getUserById(Session session, int id) async {
    return await User.db.findById(session, id);
  }

  Future<bool> updateUser(Session session, String email, String name) async {
    final user = await User.db.findFirstRow(session, where: (t) => t.email.equals(email));
    if (user == null) return false;
    user.name = name;
    await User.db.updateRow(session, user);
    return true;
  }
}
