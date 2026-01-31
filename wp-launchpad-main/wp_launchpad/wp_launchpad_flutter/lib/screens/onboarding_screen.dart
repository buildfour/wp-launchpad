import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../providers/navigation_provider.dart';
import '../providers/project_provider.dart';
import 'app_shell.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  const OnboardingScreen({super.key, required this.onNext});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isCreating = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final project = ref.watch(projectProvider);
    final hasProject = project != null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Hero
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [AppTheme.primaryNavy, AppTheme.primaryNavy.withOpacity(0.85)]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(children: [
                const FaIcon(FontAwesomeIcons.rocket, color: AppTheme.accentOrange, size: 36),
                const SizedBox(height: 16),
                const Text('WordPress Installation Guide', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Step-by-step guidance to set up WordPress on your server', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 24),
                
                if (hasProject) ...[
                  // Current project info
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      const FaIcon(FontAwesomeIcons.folderOpen, color: AppTheme.accentOrange, size: 16),
                      const SizedBox(width: 12),
                      Text(project.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                      const SizedBox(width: 16),
                      TextButton(
                        onPressed: () {
                          ref.read(projectProvider.notifier).clearProject();
                          ref.read(navigationProvider.notifier).reset();
                        },
                        child: const Text('Start New', style: TextStyle(color: Colors.white54, fontSize: 12)),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: widget.onNext,
                    icon: const FaIcon(FontAwesomeIcons.arrowRight, size: 14),
                    label: const Text('Continue Setup'),
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accentOrange, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14)),
                  ),
                ] else ...[
                  // Create new project form
                  Form(
                    key: _formKey,
                    child: SizedBox(
                      width: 350,
                      child: TextFormField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Project name (e.g., My Blog)',
                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                        ),
                        validator: (v) => v == null || v.trim().isEmpty ? 'Enter a name' : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _isCreating ? null : _createProject,
                    icon: _isCreating 
                        ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const FaIcon(FontAwesomeIcons.plus, size: 14),
                    label: Text(_isCreating ? 'Creating...' : 'Create Project'),
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accentOrange, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14)),
                  ),
                ],
              ]),
            ),
            const SizedBox(height: 32),

            // Steps
            const Text('What You\'ll Do', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(children: [
              _StepCard(num: '1', title: 'Choose Hosting', icon: FontAwesomeIcons.server, done: hasProject && (project.currentStep ?? 0) >= 1),
              const SizedBox(width: 12),
              _StepCard(num: '2', title: 'Server Setup', icon: FontAwesomeIcons.terminal, done: hasProject && (project.currentStep ?? 0) >= 2),
              const SizedBox(width: 12),
              _StepCard(num: '3', title: 'WP Config', icon: FontAwesomeIcons.fileCode, done: hasProject && (project.currentStep ?? 0) >= 3),
              const SizedBox(width: 12),
              _StepCard(num: '4', title: 'Launch', icon: FontAwesomeIcons.rocket, done: hasProject && (project.currentStep ?? 0) >= 4),
            ]),
            const SizedBox(height: 32),

            // Quick links
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Guides', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _LinkTile(icon: FontAwesomeIcons.book, label: 'Getting Started', onTap: () => ref.read(appTabProvider.notifier).state = AppTab.docsGettingStarted),
                _LinkTile(icon: FontAwesomeIcons.server, label: 'Hosting Guide', onTap: () => ref.read(appTabProvider.notifier).state = AppTab.docsHosting),
                _LinkTile(icon: FontAwesomeIcons.globe, label: 'DNS Guide', onTap: () => ref.read(appTabProvider.notifier).state = AppTab.docsDns),
              ])),
              const SizedBox(width: 24),
              Expanded(child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFFFFF7ED), borderRadius: BorderRadius.circular(12)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Row(children: [
                    FaIcon(FontAwesomeIcons.lightbulb, size: 14, color: AppTheme.accentOrange),
                    SizedBox(width: 8),
                    Text('You\'ll Need', style: TextStyle(fontWeight: FontWeight.bold)),
                  ]),
                  const SizedBox(height: 12),
                  _checkItem('Domain name'),
                  _checkItem('Hosting account'),
                  _checkItem('~30 minutes'),
                ]),
              )),
            ]),
          ]),
        ),
      ),
    );
  }

  Widget _checkItem(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(children: [
      const FaIcon(FontAwesomeIcons.check, size: 10, color: AppTheme.success),
      const SizedBox(width: 8),
      Text(text, style: const TextStyle(fontSize: 13, color: AppTheme.textMuted)),
    ]),
  );

  Future<void> _createProject() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isCreating = true);
    final success = await ref.read(projectProvider.notifier).createProject(_nameController.text.trim());
    setState(() => _isCreating = false);
    if (success) {
      ref.invalidate(projectsListProvider);
      ref.read(navigationProvider.notifier).setStep(WorkflowStep.infrastructure);
      widget.onNext();
    }
  }
}

class _StepCard extends StatelessWidget {
  final String num, title;
  final IconData icon;
  final bool done;
  const _StepCard({required this.num, required this.title, required this.icon, this.done = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: done ? AppTheme.success : AppTheme.borderGray),
        ),
        child: Column(children: [
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(
              color: done ? AppTheme.success : AppTheme.primaryNavy.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: done 
                ? const FaIcon(FontAwesomeIcons.check, size: 12, color: Colors.white)
                : Text(num, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppTheme.primaryNavy))),
          ),
          const SizedBox(height: 12),
          FaIcon(icon, size: 20, color: done ? AppTheme.success : AppTheme.primaryNavy),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: done ? AppTheme.success : AppTheme.textMain)),
        ]),
      ),
    );
  }
}

class _LinkTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _LinkTile({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppTheme.borderGray)),
          child: Row(children: [
            FaIcon(icon, size: 14, color: AppTheme.primaryNavy),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500))),
            const FaIcon(FontAwesomeIcons.arrowRight, size: 10, color: AppTheme.textMuted),
          ]),
        ),
      ),
    );
  }
}
