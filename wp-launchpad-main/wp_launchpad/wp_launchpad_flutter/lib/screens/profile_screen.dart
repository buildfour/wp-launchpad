import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final userId = authState.userId ?? 'Not assigned';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: AppTheme.cardShadow, blurRadius: 8, offset: const Offset(0, 2))]),
            child: Row(children: [
              Container(
                width: 72, height: 72,
                decoration: BoxDecoration(color: AppTheme.primaryNavy, borderRadius: BorderRadius.circular(16)),
                child: const Center(child: FaIcon(FontAwesomeIcons.user, color: Colors.white, size: 28)),
              ),
              const SizedBox(width: 20),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(userId, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textMain, fontFamily: 'monospace')),
                const SizedBox(height: 8),
                Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: AppTheme.success.withOpacity(0.1), borderRadius: BorderRadius.circular(20)), child: const Text('Active', style: TextStyle(color: AppTheme.success, fontSize: 12, fontWeight: FontWeight.w600))),
              ])),
            ]),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: AppTheme.cardShadow, blurRadius: 8, offset: const Offset(0, 2))]),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
              const SizedBox(height: 20),
              _InfoRow(icon: FontAwesomeIcons.idCard, label: 'User ID', value: userId),
              const Divider(height: 24),
              const _InfoRow(icon: FontAwesomeIcons.key, label: 'Auth', value: 'Token-based'),
              const Divider(height: 24),
              const _InfoRow(icon: FontAwesomeIcons.clock, label: 'Validity', value: '30 days'),
            ]),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppTheme.bgLight, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.borderGray)),
            child: const Row(children: [
              FaIcon(FontAwesomeIcons.circleInfo, size: 16, color: AppTheme.textMuted),
              SizedBox(width: 12),
              Expanded(child: Text('Your User ID was generated when your access token was created by the administrator.', style: TextStyle(color: AppTheme.textMuted, fontSize: 13))),
            ]),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => ref.read(authProvider.notifier).logout(),
              icon: const FaIcon(FontAwesomeIcons.rightFromBracket, size: 16, color: AppTheme.error),
              label: const Text('Sign Out', style: TextStyle(color: AppTheme.error)),
              style: OutlinedButton.styleFrom(side: const BorderSide(color: AppTheme.error), padding: const EdgeInsets.all(16)),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(width: 36, height: 36, decoration: BoxDecoration(color: AppTheme.bgLight, borderRadius: BorderRadius.circular(8)), child: Center(child: FaIcon(icon, color: AppTheme.primaryNavy, size: 14))),
      const SizedBox(width: 12),
      Text(label, style: const TextStyle(color: AppTheme.textMuted)),
      const Spacer(),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.textMain)),
    ]);
  }
}
