import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../providers/project_provider.dart';
import '../widgets/progress_tracker.dart';

class InfrastructureScreen extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const InfrastructureScreen({super.key, required this.onNext, required this.onBack});

  @override
  ConsumerState<InfrastructureScreen> createState() => _InfrastructureScreenState();
}

class _InfrastructureScreenState extends ConsumerState<InfrastructureScreen> {
  String? _selectedProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final projectState = ref.read(projectProvider);
      if (projectState != null) {
        setState(() => _selectedProvider = projectState.hostingProvider);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final projectState = ref.watch(projectProvider);

    // If no project, show message
    if (projectState == null) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.triangleExclamation, size: 48, color: AppTheme.warning),
              const SizedBox(height: 24),
              const Text('No Project Selected', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
              const SizedBox(height: 8),
              const Text('Please start from the onboarding step or create a project first.', style: TextStyle(color: AppTheme.textMuted), textAlign: TextAlign.center),
              const SizedBox(height: 24),
              OutlinedButton(onPressed: widget.onBack, child: const Text('Go Back')),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: AppTheme.cardShadow, blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: Row(
              children: [
                Container(
                  width: 56, height: 56,
                  decoration: BoxDecoration(color: AppTheme.primaryNavy.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: const Center(child: FaIcon(FontAwesomeIcons.server, color: AppTheme.primaryNavy, size: 24)),
                ),
                const SizedBox(width: 20),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Configure Your Hosting', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
                      SizedBox(height: 4),
                      Text('Select your hosting provider to get customized setup instructions', style: TextStyle(color: AppTheme.textMuted)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Provider Selection
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: AppTheme.cardShadow, blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 28, height: 28,
                      decoration: BoxDecoration(color: AppTheme.accentOrange, borderRadius: BorderRadius.circular(8)),
                      child: const Center(child: Text('1', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                    ),
                    const SizedBox(width: 12),
                    const Text('Select Your Hosting Provider', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
                  ],
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _ProviderOption(name: 'cPanel', icon: FontAwesomeIcons.gaugeHigh, value: 'cpanel', selected: _selectedProvider, onSelect: _selectProvider),
                    _ProviderOption(name: 'DigitalOcean', icon: FontAwesomeIcons.digitalOcean, value: 'digitalocean', selected: _selectedProvider, onSelect: _selectProvider),
                    _ProviderOption(name: 'AWS Lightsail', icon: FontAwesomeIcons.aws, value: 'aws', selected: _selectedProvider, onSelect: _selectProvider),
                    _ProviderOption(name: 'Managed', icon: FontAwesomeIcons.wandMagicSparkles, value: 'managed', selected: _selectedProvider, onSelect: _selectProvider),
                    _ProviderOption(name: 'Custom', icon: FontAwesomeIcons.screwdriverWrench, value: 'custom', selected: _selectedProvider, onSelect: _selectProvider),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Provider-specific instructions
          if (_selectedProvider != null) ...[
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: AppTheme.cardShadow, blurRadius: 8, offset: const Offset(0, 2))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 28, height: 28,
                        decoration: BoxDecoration(color: AppTheme.accentOrange, borderRadius: BorderRadius.circular(8)),
                        child: const Center(child: Text('2', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                      ),
                      const SizedBox(width: 12),
                      Text('${_getProviderName(_selectedProvider!)} Setup', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(_getProviderInstructions(_selectedProvider!), style: const TextStyle(color: AppTheme.textMuted, height: 1.6)),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: AppTheme.success.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        const FaIcon(FontAwesomeIcons.circleCheck, color: AppTheme.success, size: 18),
                        const SizedBox(width: 12),
                        Expanded(child: Text('You\'ve selected ${_getProviderName(_selectedProvider!)}. All following steps will be customized for this platform.', style: const TextStyle(color: AppTheme.textMain, fontSize: 13))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
          // Progress Tracker
          ProgressTracker(steps: buildProgressSteps(1)),
          const SizedBox(height: 24),
          // Navigation
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: widget.onBack,
                icon: const FaIcon(FontAwesomeIcons.arrowLeft, size: 14),
                label: const Text('Back'),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: _selectedProvider != null ? widget.onNext : null,
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accentOrange, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14)),
                icon: const FaIcon(FontAwesomeIcons.arrowRight, size: 14),
                label: const Text('Continue to Server Setup'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _selectProvider(String value) {
    setState(() => _selectedProvider = value);
    ref.read(projectProvider.notifier).updateField(hostingProvider: value);
  }

  String _getProviderName(String provider) {
    switch (provider) {
      case 'cpanel': return 'cPanel';
      case 'digitalocean': return 'DigitalOcean';
      case 'aws': return 'AWS Lightsail';
      case 'managed': return 'Managed Hosting';
      case 'custom': return 'Custom Server';
      default: return provider;
    }
  }

  String _getProviderInstructions(String provider) {
    switch (provider) {
      case 'cpanel': return 'cPanel is the most common shared hosting control panel.\n\nYou\'ll need:\n• Your cPanel login credentials\n• Access to MySQL Databases section\n• Access to File Manager';
      case 'digitalocean': return 'DigitalOcean provides cloud VPS hosting with full server control.\n\nYou\'ll need:\n• A DigitalOcean account\n• SSH access to your Droplet\n• Basic command line knowledge';
      case 'aws': return 'AWS Lightsail offers simplified cloud hosting from Amazon.\n\nYou\'ll need:\n• An AWS account\n• Lightsail instance running\n• SSH key pair configured';
      case 'managed': return 'Managed WordPress hosts handle technical details for you.\n\nYou\'ll need:\n• Your hosting dashboard access\n• Domain pointing instructions from your host';
      case 'custom': return 'Setting up your own server gives you complete control.\n\nYou\'ll need:\n• A server with PHP 7.4+ and MySQL 5.7+\n• Web server (Apache or Nginx)\n• SSH/SFTP access';
      default: return '';
    }
  }
}

class _ProviderOption extends StatelessWidget {
  final String name;
  final IconData icon;
  final String value;
  final String? selected;
  final Function(String) onSelect;

  const _ProviderOption({required this.name, required this.icon, required this.value, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final isSelected = selected == value;
    return InkWell(
      onTap: () => onSelect(value),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryNavy : AppTheme.bgLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? AppTheme.primaryNavy : AppTheme.borderGray, width: 2),
        ),
        child: Column(
          children: [
            FaIcon(icon, color: isSelected ? Colors.white : AppTheme.primaryNavy, size: 24),
            const SizedBox(height: 10),
            Text(name, style: TextStyle(fontWeight: FontWeight.w600, color: isSelected ? Colors.white : AppTheme.textMain, fontSize: 13), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
