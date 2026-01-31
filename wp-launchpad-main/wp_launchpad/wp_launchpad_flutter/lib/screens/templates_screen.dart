import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../providers/project_provider.dart';
import 'app_shell.dart';

final _templates = [
  _Template(id: 'blog', title: 'Blog', desc: 'For writers & content creators', icon: FontAwesomeIcons.penNib, color: AppTheme.accentOrange,
    features: ['Clean reading experience', 'SEO optimized', 'Social sharing', 'Comment system'],
    plugins: ['Yoast SEO', 'Akismet', 'Jetpack'],
    theme: 'Developer Blog Theme'),
  _Template(id: 'ecommerce', title: 'E-Commerce', desc: 'Online store with WooCommerce', icon: FontAwesomeIcons.cartShopping, color: AppTheme.success,
    features: ['Product catalog', 'Shopping cart', 'Payment gateway', 'Order management'],
    plugins: ['WooCommerce', 'Stripe Gateway', 'Yoast SEO'],
    theme: 'Storefront'),
  _Template(id: 'portfolio', title: 'Portfolio', desc: 'Showcase your work', icon: FontAwesomeIcons.images, color: const Color(0xFF8B5CF6),
    features: ['Gallery layouts', 'Project showcase', 'Contact form', 'About page'],
    plugins: ['Elementor', 'Contact Form 7', 'Lightbox'],
    theme: 'Flavor Portfolio Theme'),
  _Template(id: 'business', title: 'Business', desc: 'Professional company site', icon: FontAwesomeIcons.building, color: AppTheme.primaryNavy,
    features: ['Services section', 'Team profiles', 'Testimonials', 'Contact info'],
    plugins: ['Elementor', 'Contact Form 7', 'Yoast SEO'],
    theme: 'flavor Business Theme'),
];

class _Template {
  final String id, title, desc, theme;
  final IconData icon;
  final Color color;
  final List<String> features, plugins;
  const _Template({required this.id, required this.title, required this.desc, required this.icon, required this.color, required this.features, required this.plugins, required this.theme});
}

class TemplatesScreen extends ConsumerWidget {
  const TemplatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Quick Start Templates', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
        const SizedBox(height: 8),
        const Text('Pre-configured setups to get you started faster', style: TextStyle(color: AppTheme.textMuted)),
        const SizedBox(height: 24),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.6,
          children: _templates.map((t) => _TemplateCard(template: t, onTap: () => _showTemplateDetails(context, ref, t))).toList(),
        ),
        const SizedBox(height: 32),
        _CustomSetupCard(ref: ref),
      ]),
    );
  }

  void _showTemplateDetails(BuildContext context, WidgetRef ref, _Template t) {
    final nameController = TextEditingController(text: '${t.title} Site');
    
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(width: 48, height: 48, decoration: BoxDecoration(color: t.color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Center(child: FaIcon(t.icon, color: t.color, size: 20))),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(t.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(t.desc, style: const TextStyle(color: AppTheme.textMuted, fontSize: 13)),
              ])),
              IconButton(onPressed: () => Navigator.pop(ctx), icon: const Icon(Icons.close, size: 20)),
            ]),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Project Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Features', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...t.features.map((f) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(children: [FaIcon(FontAwesomeIcons.check, size: 10, color: t.color), const SizedBox(width: 8), Text(f, style: const TextStyle(fontSize: 13))]),
            )),
            const SizedBox(height: 16),
            const Text('Recommended Plugins', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(spacing: 6, runSpacing: 6, children: t.plugins.map((p) => Chip(label: Text(p, style: const TextStyle(fontSize: 11)), backgroundColor: AppTheme.bgLight, padding: EdgeInsets.zero, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)).toList()),
            const SizedBox(height: 12),
            Text('Theme: ${t.theme}', style: const TextStyle(fontSize: 13, color: AppTheme.textMuted)),
            const SizedBox(height: 24),
            Row(children: [
              Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel'))),
              const SizedBox(width: 12),
              Expanded(child: ElevatedButton(
                onPressed: () async {
                  Navigator.pop(ctx);
                  final name = nameController.text.trim().isEmpty ? '${t.title} Site' : nameController.text.trim();
                  final success = await ref.read(projectProvider.notifier).createProjectWithTemplate(name, t.id);
                  if (success) {
                    ref.invalidate(projectsListProvider);
                    ref.read(appTabProvider.notifier).state = AppTab.deploy;
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: t.color, foregroundColor: Colors.white),
                child: const Text('Use Template'),
              )),
            ]),
          ]),
        ),
      ),
    );
  }
}

class _TemplateCard extends StatelessWidget {
  final _Template template;
  final VoidCallback onTap;
  const _TemplateCard({required this.template, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: AppTheme.cardShadow, blurRadius: 6)]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(width: 40, height: 40, decoration: BoxDecoration(color: template.color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
              child: Center(child: FaIcon(template.icon, color: template.color, size: 16))),
            const Spacer(),
            FaIcon(FontAwesomeIcons.arrowRight, size: 12, color: template.color),
          ]),
          const Spacer(),
          Text(template.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(template.desc, style: const TextStyle(color: AppTheme.textMuted, fontSize: 12)),
        ]),
      ),
    );
  }
}

class _CustomSetupCard extends StatelessWidget {
  final WidgetRef ref;
  const _CustomSetupCard({required this.ref});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.bgLight, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppTheme.borderGray)),
      child: Row(children: [
        const FaIcon(FontAwesomeIcons.screwdriverWrench, color: AppTheme.primaryNavy, size: 18),
        const SizedBox(width: 14),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Custom Setup', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Start from scratch', style: TextStyle(color: AppTheme.textMuted, fontSize: 12)),
        ])),
        OutlinedButton(
          onPressed: () {
            ref.read(projectProvider.notifier).clearProject();
            ref.read(appTabProvider.notifier).state = AppTab.deploy;
          },
          child: const Text('Start Blank'),
        ),
      ]),
    );
  }
}
