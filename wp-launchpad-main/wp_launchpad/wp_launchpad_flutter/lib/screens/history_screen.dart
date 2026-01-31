import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wp_launchpad_client/wp_launchpad_client.dart';
import '../theme/app_theme.dart';
import '../providers/auth_provider.dart';
import '../main.dart';

final activityListProvider = FutureProvider<List<ActivityLog>>((ref) async {
  final userId = getCurrentUserId();
  if (userId == null) return [];
  try {
    return await client.activity.getActivitiesForUser(userId, limit: 50);
  } catch (e) {
    print('Error fetching activities: $e');
    return [];
  }
});

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activitiesAsync = ref.watch(activityListProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Text('Activity Log', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
          const Spacer(),
          IconButton(
            onPressed: () => ref.invalidate(activityListProvider),
            icon: const FaIcon(FontAwesomeIcons.arrowsRotate, size: 14),
            tooltip: 'Refresh',
          ),
        ]),
        const SizedBox(height: 8),
        const Text('Your recent actions and project updates', style: TextStyle(color: AppTheme.textMuted)),
        const SizedBox(height: 24),
        activitiesAsync.when(
          loading: () => const Center(child: Padding(padding: EdgeInsets.all(40), child: CircularProgressIndicator())),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (activities) {
            if (activities.isEmpty) {
              return _EmptyState();
            }
            return Column(children: activities.map((a) => _ActivityItem(activity: a)).toList());
          },
        ),
      ]),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        FaIcon(FontAwesomeIcons.clockRotateLeft, size: 40, color: AppTheme.textMuted.withOpacity(0.3)),
        const SizedBox(height: 16),
        const Text('No Activity Yet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Your actions will appear here', style: TextStyle(color: AppTheme.textMuted)),
      ]),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final ActivityLog activity;
  const _ActivityItem({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.borderGray),
      ),
      child: Row(children: [
        Container(
          width: 40, height: 40,
          decoration: BoxDecoration(color: _getColor().withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
          child: Center(child: FaIcon(_getIcon(), size: 16, color: _getColor())),
        ),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(_getTitle(), style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          if (activity.projectName != null)
            Text(activity.projectName!, style: const TextStyle(color: AppTheme.textMuted, fontSize: 13)),
          if (activity.details != null)
            Text(activity.details!, style: const TextStyle(color: AppTheme.textMuted, fontSize: 12)),
        ])),
        Text(_formatTime(activity.createdAt), style: const TextStyle(color: AppTheme.textMuted, fontSize: 12)),
      ]),
    );
  }

  IconData _getIcon() {
    switch (activity.action) {
      case 'project_created': return FontAwesomeIcons.folderPlus;
      case 'project_created_from_template': return FontAwesomeIcons.shapes;
      case 'project_deleted': return FontAwesomeIcons.trash;
      case 'step_completed': return FontAwesomeIcons.circleCheck;
      case 'config_generated': return FontAwesomeIcons.fileCode;
      case 'login': return FontAwesomeIcons.rightToBracket;
      default: return FontAwesomeIcons.circle;
    }
  }

  Color _getColor() {
    switch (activity.action) {
      case 'project_created': return AppTheme.success;
      case 'project_created_from_template': return AppTheme.accentOrange;
      case 'project_deleted': return AppTheme.error;
      case 'step_completed': return AppTheme.success;
      case 'config_generated': return AppTheme.primaryNavy;
      default: return AppTheme.textMuted;
    }
  }

  String _getTitle() {
    switch (activity.action) {
      case 'project_created': return 'Project Created';
      case 'project_created_from_template': return 'Project Created from Template';
      case 'project_deleted': return 'Project Deleted';
      case 'step_completed': return 'Step Completed';
      case 'config_generated': return 'Config Generated';
      case 'login': return 'Logged In';
      default: return activity.action;
    }
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${dt.month}/${dt.day}';
  }
}
