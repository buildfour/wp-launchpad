import 'package:flutter/material.dart';

class WorkflowScreen extends StatelessWidget {
  final Widget heroCard;
  final Widget? sidebarCard;
  final Widget mainContent;
  final Widget? progressTracker;
  final Widget navButtons;

  const WorkflowScreen({
    super.key,
    required this.heroCard,
    this.sidebarCard,
    required this.mainContent,
    this.progressTracker,
    required this.navButtons,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: heroCard),
                    if (sidebarCard != null) ...[
                      const SizedBox(width: 24),
                      Expanded(child: sidebarCard!),
                    ],
                  ],
                ),
                const SizedBox(height: 32),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        mainContent,
                        if (progressTracker != null) ...[
                          const SizedBox(height: 48),
                          progressTracker!,
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                navButtons,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
