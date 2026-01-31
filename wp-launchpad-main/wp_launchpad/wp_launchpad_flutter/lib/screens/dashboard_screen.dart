import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../providers/project_provider.dart';
import '../providers/auth_provider.dart';
import 'app_shell.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    final userId = ref.watch(userIdProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: AppTheme.primaryNavy, borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome${userId != null ? '!' : ''}', style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(project != null ? 'Continue working on "${project.name}"' : 'Start your WordPress deployment', style: const TextStyle(color: Colors.white70, fontSize: 15)),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () => ref.read(appTabProvider.notifier).state = AppTab.deploy,
                        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accentOrange, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14)),
                        icon: const FaIcon(FontAwesomeIcons.plus, size: 14),
                        label: Text(project != null ? 'Continue' : 'New Project'),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 80, height: 80,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
                  child: const Center(child: FaIcon(FontAwesomeIcons.rocket, size: 32, color: AppTheme.accentOrange)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Quick Actions
          const Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _QuickAction(icon: FontAwesomeIcons.circlePlus, label: 'New Deploy', color: AppTheme.accentOrange, onTap: () => ref.read(appTabProvider.notifier).state = AppTab.deploy)),
              const SizedBox(width: 12),
              Expanded(child: _QuickAction(icon: FontAwesomeIcons.shapes, label: 'Templates', color: AppTheme.success, onTap: () => ref.read(appTabProvider.notifier).state = AppTab.templates)),
              const SizedBox(width: 12),
              Expanded(child: _QuickAction(icon: FontAwesomeIcons.folderOpen, label: 'Projects', color: AppTheme.primaryNavy, onTap: () => ref.read(appTabProvider.notifier).state = AppTab.projects)),
              const SizedBox(width: 12),
              Expanded(child: _QuickAction(icon: FontAwesomeIcons.book, label: 'Guides', color: AppTheme.warning, onTap: () => ref.read(appTabProvider.notifier).state = AppTab.docsGettingStarted)),
            ],
          ),
          const SizedBox(height: 32),
          // Current Project
          if (project != null) ...[
            const Text('Current Project', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: AppTheme.cardShadow, blurRadius: 8, offset: const Offset(0, 2))],
              ),
              child: Column(
                children: [
                  _StatusRow(label: 'Project', value: project.name ?? 'Unnamed'),
                  const Divider(height: 24),
                  _StatusRow(label: 'Domain', value: project.domain ?? 'Not set'),
                  const Divider(height: 24),
                  _StatusRow(label: 'Hosting', value: project.hostingProvider ?? 'Not selected'),
                  const Divider(height: 24),
                  _StatusRow(label: 'Status', value: project.installationStatus ?? 'In Progress', isStatus: true),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
          // Features
          const Text('Features', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.2,
            children: const [
              _FeatureCard(icon: FontAwesomeIcons.heartPulse, title: 'Health Check'),
              _FeatureCard(icon: FontAwesomeIcons.globe, title: 'DNS Checker'),
              _FeatureCard(icon: FontAwesomeIcons.cloudArrowUp, title: 'Backup'),
              _FeatureCard(icon: FontAwesomeIcons.lock, title: 'SSL Setup'),
              _FeatureCard(icon: FontAwesomeIcons.gauge, title: 'Performance'),
              _FeatureCard(icon: FontAwesomeIcons.fileExport, title: 'Export'),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickAction({required this.icon, required this.label, required this.color, required this.onTap});

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
          boxShadow: [BoxShadow(color: AppTheme.cardShadow, blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: Center(child: FaIcon(icon, color: color, size: 18)),
            ),
            const SizedBox(height: 10),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.textMain, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isStatus;

  const _StatusRow({required this.label, required this.value, this.isStatus = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppTheme.textMuted)),
        isStatus
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: AppTheme.warning.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                child: Text(value, style: const TextStyle(color: AppTheme.warning, fontWeight: FontWeight.w600, fontSize: 13)),
              )
            : Text(value, style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.textMain)),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const _FeatureCard({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.borderGray)),
      child: Row(
        children: [
          FaIcon(icon, color: AppTheme.primaryNavy, size: 18),
          const SizedBox(width: 10),
          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.textMain, fontSize: 13))),
        ],
      ),
    );
  }
}
