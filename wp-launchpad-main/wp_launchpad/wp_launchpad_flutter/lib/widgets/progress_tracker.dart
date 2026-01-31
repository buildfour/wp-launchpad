import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum StepStatus { completed, active, pending }

class ProgressStep {
  final String label;
  final StepStatus status;
  ProgressStep({required this.label, required this.status});
}

// Standard step labels
const _stepLabels = ['Hosting', 'Server Setup', 'WP Config', 'Launch'];

/// Generate progress steps for a given active step index (1-4)
List<ProgressStep> buildProgressSteps(int activeStep) {
  return List.generate(4, (i) {
    final stepNum = i + 1;
    StepStatus status;
    if (stepNum < activeStep) {
      status = StepStatus.completed;
    } else if (stepNum == activeStep) {
      status = StepStatus.active;
    } else {
      status = StepStatus.pending;
    }
    return ProgressStep(label: _stepLabels[i], status: status);
  });
}

class ProgressTracker extends StatelessWidget {
  final List<ProgressStep> steps;

  const ProgressTracker({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderGray.withOpacity(0.5)),
      ),
      child: Row(children: _buildSteps()),
    );
  }

  List<Widget> _buildSteps() {
    List<Widget> widgets = [];
    for (int i = 0; i < steps.length; i++) {
      final step = steps[i];
      widgets.add(Row(mainAxisSize: MainAxisSize.min, children: [
        _buildIcon(step),
        const SizedBox(width: 8),
        Text(step.label, style: TextStyle(
          fontWeight: step.status == StepStatus.active ? FontWeight.bold : FontWeight.normal,
          color: step.status == StepStatus.pending ? AppTheme.textMuted : AppTheme.textMain,
          fontSize: 13,
        )),
      ]));
      if (i < steps.length - 1) {
        widgets.add(Expanded(child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          height: 2,
          color: steps[i + 1].status == StepStatus.pending ? Colors.grey[300] : AppTheme.success.withOpacity(0.5),
        )));
      }
    }
    return widgets;
  }

  Widget _buildIcon(ProgressStep step) {
    switch (step.status) {
      case StepStatus.completed:
        return const Icon(Icons.check_circle, color: AppTheme.success, size: 20);
      case StepStatus.active:
        return Container(
          width: 20, height: 20,
          decoration: const BoxDecoration(color: AppTheme.accentOrange, shape: BoxShape.circle),
          child: const Center(child: Icon(Icons.play_arrow, color: Colors.white, size: 12)),
        );
      case StepStatus.pending:
        return Icon(Icons.circle_outlined, color: Colors.grey[400], size: 20);
    }
  }
}
