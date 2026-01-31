import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../providers/navigation_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/project_provider.dart';
import 'onboarding_screen.dart';
import 'infrastructure_screen.dart';
import 'dns_screen.dart';
import 'provisioning_screen.dart';
import 'verification_screen.dart';
import 'support_screen.dart';
import 'history_screen.dart';
import 'profile_screen.dart';
import 'dashboard_screen.dart';
import 'settings_screen.dart';
import 'templates_screen.dart';
import 'projects_screen.dart';
import 'docs/getting_started_screen.dart';
import 'docs/dns_guide_screen.dart';
import 'docs/hosting_guide_screen.dart';
import 'docs/wordpress_guide_screen.dart';

enum AppTab { dashboard, deploy, projects, templates, history, docsGettingStarted, docsDns, docsHosting, docsWordpress, settings, profile }

final appTabProvider = StateProvider<AppTab>((ref) => AppTab.dashboard);
final sidebarCollapsedProvider = StateProvider<bool>((ref) => false);

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  @override
  Widget build(BuildContext context) {
    final currentTab = ref.watch(appTabProvider);
    final isCollapsed = ref.watch(sidebarCollapsedProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    if (isMobile) {
      return Scaffold(
        body: _buildContent(ref, currentTab),
        bottomNavigationBar: _MobileNav(currentTab: currentTab),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          _Sidebar(isCollapsed: isCollapsed),
          Expanded(
            child: Column(
              children: [
                _TopBar(currentTab: currentTab),
                Expanded(child: Container(color: AppTheme.bgLight, child: _buildContent(ref, currentTab))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(WidgetRef ref, AppTab tab) {
    switch (tab) {
      case AppTab.dashboard: return const DashboardScreen();
      case AppTab.deploy: return const _DeployFlow();
      case AppTab.projects: return const ProjectsScreen();
      case AppTab.templates: return const TemplatesScreen();
      case AppTab.history: return const HistoryScreen();
      case AppTab.docsGettingStarted: return const GettingStartedScreen();
      case AppTab.docsDns: return const DnsGuideScreen();
      case AppTab.docsHosting: return const HostingGuideScreen();
      case AppTab.docsWordpress: return const WordPressGuideScreen();
      case AppTab.settings: return const SettingsScreen();
      case AppTab.profile: return const ProfileScreen();
    }
  }
}

class _Sidebar extends ConsumerWidget {
  final bool isCollapsed;
  const _Sidebar({required this.isCollapsed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isCollapsed ? 72 : 260,
      decoration: const BoxDecoration(color: AppTheme.primaryNavy),
      child: Column(
        children: [
          Container(
            height: 64,
            padding: EdgeInsets.symmetric(horizontal: isCollapsed ? 16 : 20),
            child: Row(
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(color: AppTheme.accentOrange, borderRadius: BorderRadius.circular(10)),
                  child: const Center(child: FaIcon(FontAwesomeIcons.rocket, color: Colors.white, size: 18)),
                ),
                if (!isCollapsed) ...[
                  const SizedBox(width: 12),
                  const Expanded(child: Text('WP Launchpad', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17), overflow: TextOverflow.ellipsis)),
                ],
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _NavItem(icon: FontAwesomeIcons.house, label: 'Dashboard', tab: AppTab.dashboard, isCollapsed: isCollapsed),
                  _NavItem(icon: FontAwesomeIcons.circlePlus, label: 'New Deploy', tab: AppTab.deploy, isCollapsed: isCollapsed),
                  _NavItem(icon: FontAwesomeIcons.folderOpen, label: 'Projects', tab: AppTab.projects, isCollapsed: isCollapsed),
                  _NavItem(icon: FontAwesomeIcons.shapes, label: 'Templates', tab: AppTab.templates, isCollapsed: isCollapsed),
                  _NavItem(icon: FontAwesomeIcons.clockRotateLeft, label: 'Activity', tab: AppTab.history, isCollapsed: isCollapsed),
                  if (!isCollapsed)
                    const Padding(padding: EdgeInsets.fromLTRB(16, 24, 16, 8), child: Text('GUIDES', style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)))
                  else
                    const SizedBox(height: 16),
                  _NavItem(icon: FontAwesomeIcons.circlePlay, label: 'Getting Started', tab: AppTab.docsGettingStarted, isCollapsed: isCollapsed),
                  _NavItem(icon: FontAwesomeIcons.globe, label: 'DNS Guide', tab: AppTab.docsDns, isCollapsed: isCollapsed),
                  _NavItem(icon: FontAwesomeIcons.server, label: 'Hosting Guide', tab: AppTab.docsHosting, isCollapsed: isCollapsed),
                  _NavItem(icon: FontAwesomeIcons.wordpress, label: 'WordPress', tab: AppTab.docsWordpress, isCollapsed: isCollapsed),
                  const SizedBox(height: 16),
                  _NavItem(icon: FontAwesomeIcons.gear, label: 'Settings', tab: AppTab.settings, isCollapsed: isCollapsed),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => ref.read(sidebarCollapsedProvider.notifier).state = !isCollapsed,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(isCollapsed ? FontAwesomeIcons.angleRight : FontAwesomeIcons.angleLeft, color: Colors.white70, size: 14),
                    if (!isCollapsed) ...[const SizedBox(width: 8), const Text('Collapse', style: TextStyle(color: Colors.white70, fontSize: 13))],
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => ref.read(authProvider.notifier).logout(),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
                  children: [
                    const FaIcon(FontAwesomeIcons.rightFromBracket, color: Colors.white54, size: 16),
                    if (!isCollapsed) ...[const SizedBox(width: 12), const Text('Sign Out', style: TextStyle(color: Colors.white54, fontSize: 14))],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends ConsumerWidget {
  final IconData icon;
  final String label;
  final AppTab tab;
  final bool isCollapsed;

  const _NavItem({required this.icon, required this.label, required this.tab, required this.isCollapsed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = ref.watch(appTabProvider) == tab;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: isActive ? AppTheme.accentOrange : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => ref.read(appTabProvider.notifier).state = tab,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: isCollapsed ? 0 : 14, vertical: 11),
            child: Row(
              mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                SizedBox(width: 24, child: Center(child: FaIcon(icon, color: isActive ? Colors.white : Colors.white70, size: 16))),
                if (!isCollapsed) ...[
                  const SizedBox(width: 12),
                  Expanded(child: Text(label, style: TextStyle(color: isActive ? Colors.white : Colors.white70, fontWeight: isActive ? FontWeight.w600 : FontWeight.normal, fontSize: 14), overflow: TextOverflow.ellipsis)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TopBar extends ConsumerWidget {
  final AppTab currentTab;
  const _TopBar({required this.currentTab});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: AppTheme.cardShadow, blurRadius: 4, offset: const Offset(0, 2))]),
      child: Row(
        children: [
          Text(_getTitle(currentTab), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
          const Spacer(),
          if (userId != null) Padding(padding: const EdgeInsets.only(right: 12), child: Text(userId, style: const TextStyle(color: AppTheme.textMuted, fontFamily: 'monospace', fontSize: 12))),
          InkWell(
            onTap: () => ref.read(appTabProvider.notifier).state = AppTab.profile,
            child: Container(
              width: 36, height: 36,
              decoration: BoxDecoration(color: AppTheme.primaryNavy, borderRadius: BorderRadius.circular(8)),
              child: const Center(child: FaIcon(FontAwesomeIcons.user, size: 14, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  String _getTitle(AppTab tab) {
    switch (tab) {
      case AppTab.dashboard: return 'Dashboard';
      case AppTab.deploy: return 'New Deployment';
      case AppTab.projects: return 'My Projects';
      case AppTab.templates: return 'Templates';
      case AppTab.history: return 'Activity Log';
      case AppTab.docsGettingStarted: return 'Getting Started';
      case AppTab.docsDns: return 'DNS Setup Guide';
      case AppTab.docsHosting: return 'Hosting Setup Guide';
      case AppTab.docsWordpress: return 'WordPress Configuration';
      case AppTab.settings: return 'Settings';
      case AppTab.profile: return 'Profile';
    }
  }
}

class _MobileNav extends ConsumerWidget {
  final AppTab currentTab;
  const _MobileNav({required this.currentTab});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: AppTheme.cardShadow, blurRadius: 8, offset: const Offset(0, -2))]),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _MobileNavItem(icon: FontAwesomeIcons.house, label: 'Home', tab: AppTab.dashboard, current: currentTab),
              _MobileNavItem(icon: FontAwesomeIcons.circlePlus, label: 'Deploy', tab: AppTab.deploy, current: currentTab),
              _MobileNavItem(icon: FontAwesomeIcons.folderOpen, label: 'Projects', tab: AppTab.projects, current: currentTab),
              _MobileNavItem(icon: FontAwesomeIcons.book, label: 'Guides', tab: AppTab.docsGettingStarted, current: currentTab),
              _MobileNavItem(icon: FontAwesomeIcons.user, label: 'Profile', tab: AppTab.profile, current: currentTab),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileNavItem extends ConsumerWidget {
  final IconData icon;
  final String label;
  final AppTab tab;
  final AppTab current;

  const _MobileNavItem({required this.icon, required this.label, required this.tab, required this.current});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = current == tab;
    return InkWell(
      onTap: () => ref.read(appTabProvider.notifier).state = tab,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(icon, color: isActive ? AppTheme.accentOrange : AppTheme.textMuted, size: 18),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 11, color: isActive ? AppTheme.accentOrange : AppTheme.textMuted, fontWeight: isActive ? FontWeight.w600 : FontWeight.normal)),
        ],
      ),
    );
  }
}

class _DeployFlow extends ConsumerWidget {
  const _DeployFlow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final step = ref.watch(navigationProvider);
    final nav = ref.read(navigationProvider.notifier);
    final project = ref.watch(projectProvider);

    // Restore step from project if available
    if (project?.currentStep != null && project!.currentStep! > 0) {
      final savedStep = project.currentStep!;
      if (savedStep != step.index && savedStep < WorkflowStep.values.length) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          nav.setStepByIndex(savedStep);
        });
      }
    }

    void saveAndNext() {
      final nextIndex = step.index + 1;
      ref.read(projectProvider.notifier).updateField(currentStep: nextIndex);
      nav.next();
    }

    switch (step) {
      case WorkflowStep.onboarding: return OnboardingScreen(onNext: saveAndNext);
      case WorkflowStep.infrastructure: return InfrastructureScreen(onNext: saveAndNext, onBack: nav.previous);
      case WorkflowStep.dns: return DnsScreen(onNext: saveAndNext, onBack: nav.previous);
      case WorkflowStep.provisioning: return ProvisioningScreen(onNext: saveAndNext, onBack: nav.previous);
      case WorkflowStep.verification: return VerificationScreen(onBack: nav.previous);
      case WorkflowStep.support: return SupportScreen(onBack: () => nav.setStep(WorkflowStep.onboarding));
    }
  }
}
