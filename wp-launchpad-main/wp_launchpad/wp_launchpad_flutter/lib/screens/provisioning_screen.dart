import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:web/web.dart' as web;
import 'dart:convert';
import '../widgets/workflow_screen.dart';
import '../widgets/hero_card.dart';
import '../widgets/sidebar_card.dart';
import '../widgets/progress_tracker.dart';
import '../widgets/nav_buttons.dart';
import '../widgets/step_detail.dart';
import '../theme/app_theme.dart';
import '../providers/navigation_provider.dart';
import '../providers/project_provider.dart';
import '../services/wp_config_service.dart';
import 'app_shell.dart';

class ProvisioningScreen extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const ProvisioningScreen({super.key, required this.onNext, required this.onBack});

  @override
  ConsumerState<ProvisioningScreen> createState() => _ProvisioningScreenState();
}

class _ProvisioningScreenState extends ConsumerState<ProvisioningScreen> {
  final _dbNameController = TextEditingController();
  final _dbUserController = TextEditingController();
  final _dbPasswordController = TextEditingController();
  final _dbHostController = TextEditingController();
  final _tablePrefixController = TextEditingController(text: 'wp_');

  bool _debugMode = false;
  bool _configGenerated = false;
  String _generatedConfig = '';

  @override
  void initState() {
    super.initState();
    final p = ref.read(projectProvider);
    _dbNameController.text = p?.databaseName ?? '';
    _dbUserController.text = p?.databaseUser ?? '';
    _dbPasswordController.text = p?.databasePassword ?? '';
    _dbHostController.text = p?.databaseHost ?? 'localhost';
  }

  @override
  void dispose() {
    _dbNameController.dispose();
    _dbUserController.dispose();
    _dbPasswordController.dispose();
    _dbHostController.dispose();
    _tablePrefixController.dispose();
    super.dispose();
  }

  bool get _allFieldsFilled =>
      _dbNameController.text.isNotEmpty &&
      _dbUserController.text.isNotEmpty &&
      _dbPasswordController.text.isNotEmpty &&
      _dbHostController.text.isNotEmpty;

  void _generateConfig() {
    _generatedConfig = WpConfigService.generateWpConfig(
      dbName: _dbNameController.text,
      dbUser: _dbUserController.text,
      dbPassword: _dbPasswordController.text,
      dbHost: _dbHostController.text,
      tablePrefix: _tablePrefixController.text.isEmpty ? 'wp_' : _tablePrefixController.text,
      debugMode: _debugMode,
    );
    setState(() => _configGenerated = true);
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _generatedConfig));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('wp-config.php copied to clipboard!'), backgroundColor: AppTheme.success),
    );
  }

  void _downloadConfig() {
    final bytes = utf8.encode(_generatedConfig);
    final base64Data = base64Encode(bytes);
    final dataUrl = 'data:text/plain;base64,$base64Data';
    final anchor = web.document.createElement('a') as web.HTMLAnchorElement;
    anchor.href = dataUrl;
    anchor.download = 'wp-config.php';
    anchor.click();
  }

  @override
  Widget build(BuildContext context) {
    return WorkflowScreen(
      heroCard: const HeroCard(
        title: 'Generate WordPress Configuration',
        description: "Enter your database credentials to generate a secure wp-config.php file.",
        icon: Icons.settings_suggest,
      ),
      sidebarCard: SidebarCard(
        title: 'Need Help?',
        description: 'Visit our Support Center for database setup guides.',
        buttonText: 'Get Support',
        onButtonPressed: () => ref.read(navigationProvider.notifier).setStep(WorkflowStep.support),
      ),
      mainContent: _configGenerated ? _buildConfigPreview() : _buildForm(),
      progressTracker: ProgressTracker(steps: buildProgressSteps(2)),
      navButtons: _configGenerated
          ? Row(children: [
              OutlinedButton.icon(
                onPressed: () => setState(() => _configGenerated = false),
                icon: const FaIcon(FontAwesomeIcons.arrowLeft, size: 14),
                label: const Text('Edit'),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: widget.onNext,
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accentOrange, foregroundColor: Colors.white),
                icon: const FaIcon(FontAwesomeIcons.arrowRight, size: 14),
                label: const Text('Continue'),
              ),
            ])
          : NavButtons(
              onBack: widget.onBack,
              onNext: _allFieldsFilled ? _generateConfig : null,
              onSave: () => ref.read(appTabProvider.notifier).state = AppTab.dashboard,
              nextLabel: 'Generate Config',
            ),
    );
  }

  Widget _buildForm() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(flex: 2, child: Column(children: [
          _field('1', 'Database Name', _dbNameController, (v) => ref.read(projectProvider.notifier).updateField(databaseName: v)),
          const SizedBox(height: 20),
          _field('2', 'Database User', _dbUserController, (v) => ref.read(projectProvider.notifier).updateField(databaseUser: v)),
          const SizedBox(height: 20),
          _field('3', 'Database Password', _dbPasswordController, (v) => ref.read(projectProvider.notifier).updateField(databasePassword: v), obscure: true),
          const SizedBox(height: 20),
          _field('4', 'Database Host', _dbHostController, (v) => ref.read(projectProvider.notifier).updateField(databaseHost: v), hint: 'localhost'),
          const SizedBox(height: 20),
          _field('5', 'Table Prefix', _tablePrefixController, (_) {}, hint: 'wp_'),
        ])),
        const SizedBox(width: 32),
        Expanded(child: _buildSidebar()),
      ]),
      const SizedBox(height: 24),
      Row(children: [
        Checkbox(value: _debugMode, onChanged: (v) => setState(() => _debugMode = v ?? false), activeColor: AppTheme.primaryNavy),
        const Text('Enable WP_DEBUG', style: TextStyle(fontWeight: FontWeight.w600, color: AppTheme.primaryNavy)),
        const SizedBox(width: 8),
        const Text('(for development/troubleshooting)', style: TextStyle(color: AppTheme.textMuted, fontSize: 13)),
      ]),
    ]);
  }

  Widget _field(String num, String label, TextEditingController ctrl, ValueChanged<String> onChange, {bool obscure = false, String? hint}) {
    return StepDetail(
      number: num,
      title: label,
      child: TextFormField(
        controller: ctrl,
        obscureText: obscure,
        onChanged: (v) { onChange(v); setState(() {}); },
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: const Color(0xFFF8FAFC),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppTheme.borderGray)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppTheme.borderGray)),
        ),
      ),
    );
  }

  Widget _buildSidebar() {
    final p = ref.watch(projectProvider);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.borderGray)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(children: [
          FaIcon(FontAwesomeIcons.database, size: 16, color: AppTheme.primaryNavy),
          SizedBox(width: 10),
          Text('Credentials Summary', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryNavy)),
        ]),
        const SizedBox(height: 16),
        _row('Database', p?.databaseName ?? '-'),
        _row('User', p?.databaseUser ?? '-'),
        _row('Password', p?.databasePassword != null ? '••••••••' : '-'),
        _row('Host', p?.databaseHost ?? '-'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: AppTheme.warning.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: const Row(children: [
            FaIcon(FontAwesomeIcons.triangleExclamation, size: 14, color: AppTheme.warning),
            SizedBox(width: 10),
            Expanded(child: Text('Keep these credentials secure!', style: TextStyle(fontSize: 12, color: AppTheme.warning, fontWeight: FontWeight.w500))),
          ]),
        ),
      ]),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: const TextStyle(color: AppTheme.textMuted, fontSize: 13)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      ]),
    );
  }

  Widget _buildConfigPreview() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppTheme.success.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
        child: Row(children: [
          const FaIcon(FontAwesomeIcons.circleCheck, color: AppTheme.success, size: 20),
          const SizedBox(width: 12),
          const Expanded(child: Text('wp-config.php generated successfully!', style: TextStyle(fontWeight: FontWeight.w600, color: AppTheme.success))),
          ElevatedButton.icon(
            onPressed: _copyToClipboard,
            icon: const FaIcon(FontAwesomeIcons.copy, size: 14),
            label: const Text('Copy'),
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryNavy),
          ),
          const SizedBox(width: 8),
          OutlinedButton.icon(
            onPressed: _downloadConfig,
            icon: const FaIcon(FontAwesomeIcons.download, size: 14),
            label: const Text('Download'),
          ),
        ]),
      ),
      const SizedBox(height: 20),
      const Text('Preview:', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textMain)),
      const SizedBox(height: 12),
      Container(
        height: 350,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)),
        child: SingleChildScrollView(
          child: SelectableText(_generatedConfig, style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Color(0xFFD4D4D4), height: 1.5)),
        ),
      ),
      const SizedBox(height: 20),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFFFFF7ED), borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.accentOrange.withOpacity(0.3))),
        child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            FaIcon(FontAwesomeIcons.lightbulb, size: 16, color: AppTheme.accentOrange),
            SizedBox(width: 10),
            Text('Next Steps', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textMain)),
          ]),
          SizedBox(height: 12),
          Text('1. Download or copy the wp-config.php file\n2. Upload it to your WordPress root directory\n3. Replace the existing wp-config-sample.php\n4. Continue to verify your installation', style: TextStyle(color: AppTheme.textMuted, fontSize: 13, height: 1.6)),
        ]),
      ),
    ]);
  }
}
