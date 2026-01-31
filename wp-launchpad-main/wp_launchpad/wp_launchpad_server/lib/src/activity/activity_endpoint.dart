import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class ActivityEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  /// Log an activity
  Future<ActivityLog> logActivity(Session session, String visitorId, String action, {String? details, int? projectId, String? projectName}) async {
    final log = ActivityLog(
      visitorId: visitorId,
      action: action,
      details: details,
      projectId: projectId,
      projectName: projectName,
      createdAt: DateTime.now(),
    );
    return await ActivityLog.db.insertRow(session, log);
  }

  /// Get activities for a user
  Future<List<ActivityLog>> getActivitiesForUser(Session session, String visitorId, {int limit = 50}) async {
    return await ActivityLog.db.find(
      session,
      where: (t) => t.visitorId.equals(visitorId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit,
    );
  }
}
