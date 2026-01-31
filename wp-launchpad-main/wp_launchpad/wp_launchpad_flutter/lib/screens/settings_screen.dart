import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';

final notificationsEnabledProvider = StateProvider<bool>((ref) => true);

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsEnabled = ref.watch(notificationsEnabledProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: AppTheme.cardShadow, blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Preferences', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
                const SizedBox(height: 20),
                _SettingsTile(
                  icon: FontAwesomeIcons.bell,
                  title: 'Notifications',
                  subtitle: 'Deployment alerts and updates',
                  trailing: Switch(
                    value: notificationsEnabled,
                    onChanged: (v) => ref.read(notificationsEnabledProvider.notifier).state = v,
                    activeColor: AppTheme.accentOrange,
                  ),
                ),
                const Divider(height: 32),
                _SettingsTile(
                  icon: FontAwesomeIcons.moon,
                  title: 'Dark Mode',
                  subtitle: 'Coming soon',
                  trailing: Switch(value: false, onChanged: null, activeColor: AppTheme.accentOrange),
                ),
                const Divider(height: 32),
                _SettingsTile(
                  icon: FontAwesomeIcons.language,
                  title: 'Language',
                  subtitle: 'English',
                  trailing: const FaIcon(FontAwesomeIcons.chevronRight, size: 14, color: AppTheme.textMuted),
                  onTap: () => _showLanguageDialog(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: AppTheme.cardShadow, blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Data', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
                const SizedBox(height: 20),
                _SettingsTile(
                  icon: FontAwesomeIcons.download,
                  title: 'Export All Data',
                  subtitle: 'Download your project configurations',
                  trailing: const FaIcon(FontAwesomeIcons.chevronRight, size: 14, color: AppTheme.textMuted),
                  onTap: () => _showExportDialog(context),
                ),
                const Divider(height: 32),
                _SettingsTile(
                  icon: FontAwesomeIcons.trash,
                  title: 'Clear History',
                  subtitle: 'Remove all activity logs',
                  trailing: const FaIcon(FontAwesomeIcons.chevronRight, size: 14, color: AppTheme.error),
                  onTap: () => _showClearHistoryDialog(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: AppTheme.cardShadow, blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('About', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
                const SizedBox(height: 20),
                _SettingsTile(icon: FontAwesomeIcons.circleInfo, title: 'Version', subtitle: '1.0.0', trailing: const SizedBox()),
                const Divider(height: 32),
                _SettingsTile(
                  icon: FontAwesomeIcons.fileLines,
                  title: 'Terms of Service',
                  subtitle: '',
                  trailing: const FaIcon(FontAwesomeIcons.arrowUpRightFromSquare, size: 14, color: AppTheme.textMuted),
                  onTap: () {},
                ),
                const Divider(height: 32),
                _SettingsTile(
                  icon: FontAwesomeIcons.shieldHalved,
                  title: 'Privacy Policy',
                  subtitle: '',
                  trailing: const FaIcon(FontAwesomeIcons.arrowUpRightFromSquare, size: 14, color: AppTheme.textMuted),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Text('🇺🇸'),
              title: const Text('English'),
              trailing: const FaIcon(FontAwesomeIcons.check, size: 14, color: AppTheme.success),
              onTap: () => Navigator.pop(ctx),
            ),
            ListTile(
              leading: const Text('🇪🇸'),
              title: const Text('Español'),
              subtitle: const Text('Coming soon', style: TextStyle(fontSize: 12)),
              enabled: false,
            ),
            ListTile(
              leading: const Text('🇫🇷'),
              title: const Text('Français'),
              subtitle: const Text('Coming soon', style: TextStyle(fontSize: 12)),
              enabled: false,
            ),
          ],
        ),
      ),
    );
  }

  void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Export Data'),
        content: const Text('This will download all your project configurations as a JSON file.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Export started...')));
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryNavy),
            child: const Text('Export'),
          ),
        ],
      ),
    );
  }

  void _showClearHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Clear History'),
        content: const Text('This will permanently delete all activity logs. This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('History cleared')));
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget trailing;
  final VoidCallback? onTap;

  const _SettingsTile({required this.icon, required this.title, required this.subtitle, required this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: AppTheme.bgLight, borderRadius: BorderRadius.circular(10)),
            child: Center(child: FaIcon(icon, color: AppTheme.primaryNavy, size: 16)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.textMain)),
                if (subtitle.isNotEmpty) Text(subtitle, style: const TextStyle(color: AppTheme.textMuted, fontSize: 13)),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
