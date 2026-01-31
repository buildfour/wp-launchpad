import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wp_launchpad_client/wp_launchpad_client.dart';
import '../theme/app_theme.dart';
import '../providers/project_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/navigation_provider.dart';
import '../main.dart';
import 'app_shell.dart';

class ProjectsScreen extends ConsumerWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsAsync = ref.watch(projectsListProvider);
    final currentProject = ref.watch(projectProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Expanded(child: Text('My Projects', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textMain))),
          ElevatedButton.icon(
            onPressed: () => _showNewProjectDialog(context, ref),
            icon: const FaIcon(FontAwesomeIcons.plus, size: 14),
            label: const Text('New Project'),
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accentOrange, foregroundColor: Colors.white),
          ),
        ]),
        const SizedBox(height: 24),
        projectsAsync.when(
          loading: () => const Center(child: Padding(padding: EdgeInsets.all(40), child: CircularProgressIndicator())),
          error: (e, _) => Center(child: Text('Error loading projects: $e')),
          data: (projects) {
            if (projects.isEmpty) {
              return _EmptyState(onCreateProject: () => _showNewProjectDialog(context, ref));
            }
            return Column(
              children: projects.map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _ProjectCard(
                  project: p,
                  isActive: currentProject?.id == p.id,
                  onTap: () => _showProjectDetails(context, ref, p),
                ),
              )).toList(),
            );
          },
        ),
      ]),
    );
  }

  void _showNewProjectDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('New Project'),
        content: SizedBox(
          width: 400,
          child: TextField(
            controller: nameController,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Project Name',
              hintText: 'My WordPress Site',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.trim().isEmpty) return;
              Navigator.pop(ctx);
              final success = await ref.read(projectProvider.notifier).createProject(nameController.text.trim());
              if (success) {
                ref.invalidate(projectsListProvider);
                ref.read(navigationProvider.notifier).setStep(WorkflowStep.infrastructure);
                ref.read(appTabProvider.notifier).state = AppTab.deploy;
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryNavy),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showProjectDetails(BuildContext context, WidgetRef ref, ProjectState project) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(children: [
          const FaIcon(FontAwesomeIcons.folderOpen, size: 18, color: AppTheme.primaryNavy),
          const SizedBox(width: 12),
          Expanded(child: Text(project.name, overflow: TextOverflow.ellipsis)),
        ]),
        content: SizedBox(
          width: 450,
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              _DetailRow(label: 'Domain', value: project.domain ?? 'Not set'),
              _DetailRow(label: 'Server IP', value: project.serverIp ?? 'Not set'),
              _DetailRow(label: 'Hosting', value: _formatProvider(project.hostingProvider)),
              _DetailRow(label: 'Database', value: project.databaseName ?? 'Not configured'),
              _DetailRow(label: 'Template', value: _formatTemplate(project.template)),
              _DetailRow(label: 'Progress', value: 'Step ${(project.currentStep ?? 0) + 1} of 5'),
              _DetailRow(label: 'Status', value: project.installationStatus ?? 'In Progress'),
              _DetailRow(label: 'Last Modified', value: _formatDate(project.lastModified)),
            ]),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _confirmDelete(context, ref, project);
            },
            style: TextButton.styleFrom(foregroundColor: AppTheme.error),
            child: const Text('Delete'),
          ),
          const Spacer(),
          OutlinedButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(projectProvider.notifier).setProject(project);
              ref.read(navigationProvider.notifier).setStepByIndex((project.currentStep ?? 0) + 1);
              ref.read(appTabProvider.notifier).state = AppTab.deploy;
            },
            icon: const FaIcon(FontAwesomeIcons.play, size: 12),
            label: const Text('Continue'),
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accentOrange),
          ),
        ],
      ),
    );
  }

  String _formatProvider(String? provider) {
    if (provider == null) return 'Not selected';
    switch (provider) {
      case 'cpanel': return 'cPanel';
      case 'digitalocean': return 'DigitalOcean';
      case 'aws': return 'AWS Lightsail';
      case 'managed': return 'Managed Hosting';
      case 'custom': return 'Custom Server';
      default: return provider;
    }
  }

  String _formatTemplate(String? template) {
    if (template == null) return 'None';
    switch (template) {
      case 'blog': return 'Blog';
      case 'ecommerce': return 'E-Commerce';
      case 'portfolio': return 'Portfolio';
      case 'business': return 'Business';
      default: return template;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, ProjectState project) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Project?'),
        content: Text('Delete "${project.name}"? This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final current = ref.read(projectProvider);
              if (current?.id == project.id) {
                await ref.read(projectProvider.notifier).deleteProject();
              } else {
                await client.project.deleteProject(project.id!);
              }
              ref.invalidate(projectsListProvider);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onCreateProject;
  const _EmptyState({required this.onCreateProject});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: AppTheme.cardShadow, blurRadius: 8)]),
      child: Column(children: [
        FaIcon(FontAwesomeIcons.folderOpen, size: 48, color: AppTheme.textMuted.withOpacity(0.3)),
        const SizedBox(height: 20),
        const Text('No Projects Yet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
        const SizedBox(height: 8),
        const Text('Create your first WordPress project', style: TextStyle(color: AppTheme.textMuted)),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: onCreateProject,
          icon: const FaIcon(FontAwesomeIcons.plus, size: 14),
          label: const Text('Create Project'),
          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryNavy, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14)),
        ),
      ]),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final ProjectState project;
  final bool isActive;
  final VoidCallback onTap;
  const _ProjectCard({required this.project, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isActive ? AppTheme.accentOrange : AppTheme.borderGray, width: isActive ? 2 : 1),
          boxShadow: [BoxShadow(color: AppTheme.cardShadow, blurRadius: 4)],
        ),
        child: Row(children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: AppTheme.primaryNavy.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: const Center(child: FaIcon(FontAwesomeIcons.wordpress, color: AppTheme.primaryNavy, size: 20)),
          ),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(project.name, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textMain)),
            const SizedBox(height: 2),
            Text(project.domain ?? 'No domain', style: const TextStyle(color: AppTheme.textMuted, fontSize: 13)),
          ])),
          if (isActive) Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: AppTheme.accentOrange, borderRadius: BorderRadius.circular(8)),
            child: const Text('Active', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 8),
          const FaIcon(FontAwesomeIcons.chevronRight, size: 12, color: AppTheme.textMuted),
        ]),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label, value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: const TextStyle(color: AppTheme.textMuted, fontSize: 13)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      ]),
    );
  }
}
