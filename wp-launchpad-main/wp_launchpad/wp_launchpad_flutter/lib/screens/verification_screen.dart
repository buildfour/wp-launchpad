import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:printing/printing.dart';
import '../widgets/workflow_screen.dart';
import '../widgets/hero_card.dart';
import '../widgets/progress_tracker.dart';
import '../widgets/nav_buttons.dart';
import '../theme/app_theme.dart';
import '../providers/navigation_provider.dart';
import '../services/report_service.dart';
import '../providers/project_provider.dart';
import 'app_shell.dart';

class VerificationScreen extends ConsumerStatefulWidget {
  final VoidCallback onBack;
  const VerificationScreen({super.key, required this.onBack});

  @override
  ConsumerState<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends ConsumerState<VerificationScreen> {
  final Map<String, bool> _checklist = {
    'server_ready': false,
    'dns_configured': false,
    'database_created': false,
    'wp_uploaded': false,
    'wp_config_uploaded': false,
    'wp_installed': false,
  };

  bool get _allComplete => _checklist.values.every((v) => v);

  Future<void> _downloadSummary() async {
    final p = ref.read(projectProvider);
    if (p == null) return;
    final pdf = await ReportService.generateProjectSummary(
      projectName: p.name,
      provider: p.hostingProvider ?? 'N/A',
      domain: p.domain ?? 'N/A',
    );
    await Printing.sharePdf(bytes: pdf, filename: '${p.name}_Summary.pdf');
  }

  Future<void> _downloadTechnicalReport() async {
    final p = ref.read(projectProvider);
    if (p == null) return;
    final pdf = await ReportService.generateTechnicalReport(
      projectName: p.name,
      config: {
        'Project Name': p.name,
        'Domain': p.domain ?? 'N/A',
        'Server IP': p.serverIp ?? 'N/A',
        'Hosting Provider': p.hostingProvider ?? 'N/A',
        'Database Name': p.databaseName ?? 'N/A',
        'Database User': p.databaseUser ?? 'N/A',
        'Database Host': p.databaseHost ?? 'N/A',
      },
      commands: [
        'ssh root@${p.serverIp ?? "YOUR_IP"}',
        'apt update && apt upgrade -y',
        'mysql -u ${p.databaseUser ?? "root"} -p',
        'CREATE DATABASE ${p.databaseName ?? "wordpress"};',
      ],
    );
    await Printing.sharePdf(bytes: pdf, filename: '${p.name}_Technical_Report.pdf');
  }

  @override
  Widget build(BuildContext context) {
    final p = ref.watch(projectProvider);

    return WorkflowScreen(
      heroCard: HeroCard(
        title: _allComplete ? 'Installation Complete!' : 'Installation Checklist',
        description: _allComplete
            ? 'Congratulations! Your WordPress site is ready.'
            : 'Complete these steps to finish your WordPress installation.',
        icon: _allComplete ? Icons.rocket_launch : Icons.checklist,
      ),
      mainContent: Column(children: [
        if (_allComplete) ...[
          _buildSuccessState(p),
        ] else ...[
          _buildChecklist(p),
        ],
      ]),
      progressTracker: ProgressTracker(steps: buildProgressSteps(_allComplete ? 4 : 3)),
      navButtons: _allComplete
          ? Row(children: [
              OutlinedButton.icon(
                onPressed: () => setState(() => _checklist.updateAll((k, v) => false)),
                icon: const FaIcon(FontAwesomeIcons.arrowLeft, size: 14),
                label: const Text('Back to Checklist'),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () => ref.read(appTabProvider.notifier).state = AppTab.dashboard,
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accentOrange, foregroundColor: Colors.white),
                icon: const FaIcon(FontAwesomeIcons.house, size: 14),
                label: const Text('Go to Dashboard'),
              ),
            ])
          : NavButtons(onBack: widget.onBack, onNext: null),
    );
  }

  Widget _buildChecklist(dynamic p) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppTheme.primaryNavy.withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
        child: Row(children: [
          const FaIcon(FontAwesomeIcons.circleInfo, size: 18, color: AppTheme.primaryNavy),
          const SizedBox(width: 12),
          Expanded(child: Text('Check off each step as you complete it on your server. This helps track your progress.', style: TextStyle(color: AppTheme.textMuted, fontSize: 13))),
        ]),
      ),
      const SizedBox(height: 24),
      _checkItem('server_ready', 'Server is running and accessible', 'You can SSH into your server or access cPanel'),
      _checkItem('dns_configured', 'DNS A record points to server IP', 'Domain ${p?.domain ?? "yourdomain.com"} → ${p?.serverIp ?? "YOUR_IP"}'),
      _checkItem('database_created', 'MySQL database and user created', 'Database: ${p?.databaseName ?? "wordpress"}'),
      _checkItem('wp_uploaded', 'WordPress files uploaded to server', 'Files in /var/www/html or public_html'),
      _checkItem('wp_config_uploaded', 'wp-config.php uploaded', 'Generated config file placed in WordPress root'),
      _checkItem('wp_installed', 'WordPress installation wizard completed', 'Visit ${p?.domain ?? "yourdomain.com"}/wp-admin/install.php'),
      const SizedBox(height: 24),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFFFFF7ED), borderRadius: BorderRadius.circular(12)),
        child: Row(children: [
          const FaIcon(FontAwesomeIcons.lightbulb, size: 16, color: AppTheme.accentOrange),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Need help?', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textMain)),
            const SizedBox(height: 4),
            Text('Check our guides in the sidebar for detailed instructions.', style: TextStyle(color: AppTheme.textMuted, fontSize: 13)),
          ])),
        ]),
      ),
      const SizedBox(height: 24),
      if (_checklist.values.where((v) => v).length >= 4)
        Center(
          child: ElevatedButton.icon(
            onPressed: () => setState(() => _checklist.updateAll((k, v) => true)),
            icon: const FaIcon(FontAwesomeIcons.check, size: 14),
            label: const Text('Mark All Complete'),
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.success, foregroundColor: Colors.white),
          ),
        ),
    ]);
  }

  Widget _checkItem(String key, String title, String subtitle) {
    final checked = _checklist[key] ?? false;
    return InkWell(
      onTap: () => setState(() => _checklist[key] = !checked),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppTheme.borderGray.withOpacity(0.5)))),
        child: Row(children: [
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(
              color: checked ? AppTheme.success : Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: checked ? AppTheme.success : AppTheme.borderGray, width: 2),
            ),
            child: checked ? const Icon(Icons.check, size: 18, color: Colors.white) : null,
          ),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: checked ? AppTheme.success : AppTheme.textMain, decoration: checked ? TextDecoration.lineThrough : null)),
            const SizedBox(height: 2),
            Text(subtitle, style: TextStyle(fontSize: 12, color: AppTheme.textMuted)),
          ])),
        ]),
      ),
    );
  }

  Widget _buildSuccessState(dynamic p) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(color: AppTheme.success.withOpacity(0.1), shape: BoxShape.circle),
        child: const FaIcon(FontAwesomeIcons.circleCheck, size: 64, color: AppTheme.success),
      ),
      const SizedBox(height: 24),
      const Text('All Steps Complete!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
      const SizedBox(height: 8),
      Text('Your WordPress site at ${p?.domain ?? "yourdomain.com"} is ready.', style: const TextStyle(color: AppTheme.textMuted)),
      const SizedBox(height: 32),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        _statCard('Site URL', p?.domain ?? 'N/A', FontAwesomeIcons.globe),
        const SizedBox(width: 16),
        _statCard('Admin URL', '${p?.domain ?? ""}/wp-admin', FontAwesomeIcons.userShield),
      ]),
      const SizedBox(height: 32),
      const Text('Download Your Reports', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
      const SizedBox(height: 16),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton.icon(
          onPressed: _downloadSummary,
          icon: const FaIcon(FontAwesomeIcons.fileLines, size: 14),
          label: const Text('Project Summary'),
          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryNavy),
        ),
        const SizedBox(width: 12),
        OutlinedButton.icon(
          onPressed: _downloadTechnicalReport,
          icon: const FaIcon(FontAwesomeIcons.fileCode, size: 14),
          label: const Text('Technical Report'),
        ),
      ]),
      const SizedBox(height: 32),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFFF0FDF4), borderRadius: BorderRadius.circular(12)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Row(children: [
            FaIcon(FontAwesomeIcons.listCheck, size: 16, color: AppTheme.success),
            SizedBox(width: 10),
            Text('First 5 Minutes Checklist', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textMain)),
          ]),
          const SizedBox(height: 12),
          _miniCheck('Delete "Hello World" post and sample page'),
          _miniCheck('Set permalinks: Settings → Permalinks → Post name'),
          _miniCheck('Update site title: Settings → General'),
          _miniCheck('Install security plugin (Wordfence or Sucuri)'),
          _miniCheck('Set up backups (UpdraftPlus)'),
        ]),
      ),
    ]);
  }

  Widget _statCard(String label, String value, IconData icon) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.borderGray)),
      child: Column(children: [
        FaIcon(icon, color: AppTheme.primaryNavy, size: 24),
        const SizedBox(height: 12),
        Text(label, style: const TextStyle(color: AppTheme.textMuted, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.primaryNavy), textAlign: TextAlign.center, overflow: TextOverflow.ellipsis),
      ]),
    );
  }

  Widget _miniCheck(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(children: [
        const FaIcon(FontAwesomeIcons.square, size: 12, color: AppTheme.textMuted),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 13, color: AppTheme.textMuted))),
      ]),
    );
  }
}
