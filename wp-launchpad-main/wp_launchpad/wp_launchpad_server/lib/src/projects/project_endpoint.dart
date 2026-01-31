import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class ProjectEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  /// Returns all projects for a specific user.
  Future<List<ProjectState>> getProjectsForUser(Session session, String visitorId) async {
    return await ProjectState.db.find(
      session,
      where: (t) => t.visitorId.equals(visitorId),
      orderBy: (t) => t.lastModified,
      orderDescending: true,
    );
  }

  /// Returns all projects (admin).
  Future<List<ProjectState>> getAllProjects(Session session) async {
    return await ProjectState.db.find(
      session,
      orderBy: (t) => t.lastModified,
      orderDescending: true,
    );
  }

  /// Returns a project by ID.
  Future<ProjectState?> getProjectById(Session session, int id) async {
    return await ProjectState.db.findById(session, id);
  }

  /// Creates a new project for a user.
  Future<ProjectState> createProject(Session session, String name, String visitorId) async {
    final project = ProjectState(
      name: name,
      visitorId: visitorId,
      currentStep: 0,
      lastModified: DateTime.now(),
    );
    return await ProjectState.db.insertRow(session, project);
  }

  /// Updates project state.
  Future<ProjectState> updateProjectState(Session session, ProjectState state) async {
    state.lastModified = DateTime.now();
    if (state.id == null) {
      return await ProjectState.db.insertRow(session, state);
    } else {
      return await ProjectState.db.updateRow(session, state);
    }
  }

  /// Deletes a project by ID.
  Future<bool> deleteProject(Session session, int id) async {
    final project = await ProjectState.db.findById(session, id);
    if (project == null) return false;
    await ProjectState.db.deleteRow(session, project);
    return true;
  }
}
