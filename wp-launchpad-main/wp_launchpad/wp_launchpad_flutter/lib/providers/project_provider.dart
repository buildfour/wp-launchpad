import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wp_launchpad_client/wp_launchpad_client.dart';
import '../main.dart';
import 'auth_provider.dart';

class ProjectStateNotifier extends StateNotifier<ProjectState?> {
  ProjectStateNotifier() : super(null);

  Future<void> loadProjectById(int id) async {
    try {
      state = await client.project.getProjectById(id);
    } catch (e) {
      print('Error loading project: $e');
    }
  }

  Future<bool> createProject(String name) async {
    final visitorId = getCurrentUserId();
    if (visitorId == null) return false;
    try {
      state = await client.project.createProject(name, visitorId);
      // Log activity
      await client.activity.logActivity(visitorId, 'project_created', projectName: name);
      return true;
    } catch (e) {
      print('Error creating project: $e');
      return false;
    }
  }

  Future<bool> createProjectWithTemplate(String name, String templateId) async {
    final visitorId = getCurrentUserId();
    if (visitorId == null) return false;
    try {
      final project = await client.project.createProject(name, visitorId);
      final updated = project.copyWith(
        template: templateId,
        currentStep: 1,
      );
      state = await client.project.updateProjectState(updated);
      await client.activity.logActivity(visitorId, 'project_created_from_template', details: templateId, projectName: name);
      return true;
    } catch (e) {
      print('Error creating project with template: $e');
      return false;
    }
  }

  Future<void> updateProjectState(ProjectState updatedState) async {
    try {
      state = await client.project.updateProjectState(updatedState);
    } catch (e) {
      print('Error updating project state: $e');
    }
  }

  void updateField({
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
  }) {
    if (state == null) return;
    state = state!.copyWith(
      domain: domain ?? state!.domain,
      serverIp: serverIp ?? state!.serverIp,
      dnsStatus: dnsStatus ?? state!.dnsStatus,
      hostingProvider: hostingProvider ?? state!.hostingProvider,
      databaseName: databaseName ?? state!.databaseName,
      databaseUser: databaseUser ?? state!.databaseUser,
      databasePassword: databasePassword ?? state!.databasePassword,
      databaseHost: databaseHost ?? state!.databaseHost,
      installationStatus: installationStatus ?? state!.installationStatus,
      template: template ?? state!.template,
      currentStep: currentStep ?? state!.currentStep,
      lastModified: DateTime.now(),
    );
    updateProjectState(state!);
  }

  void setProject(ProjectState? project) {
    state = project;
  }

  void clearProject() {
    state = null;
  }

  Future<void> deleteProject() async {
    if (state?.id == null) return;
    final visitorId = getCurrentUserId();
    try {
      await client.project.deleteProject(state!.id!);
      if (visitorId != null) {
        await client.activity.logActivity(visitorId, 'project_deleted', projectName: state!.name);
      }
    } catch (e) {
      print('Error deleting project: $e');
    }
    state = null;
  }
}

final projectProvider = StateNotifierProvider<ProjectStateNotifier, ProjectState?>((ref) {
  return ProjectStateNotifier();
});

final projectsListProvider = FutureProvider<List<ProjectState>>((ref) async {
  final userId = getCurrentUserId();
  if (userId == null) return [];
  try {
    return await client.project.getProjectsForUser(userId);
  } catch (e) {
    print('Error fetching projects: $e');
    return [];
  }
});
