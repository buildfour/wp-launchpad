import 'package:flutter_riverpod/flutter_riverpod.dart';

enum WorkflowStep {
  onboarding,    // 0
  infrastructure, // 1
  dns,           // 2
  provisioning,  // 3
  verification,  // 4
  support        // 5
}

class NavigationNotifier extends StateNotifier<WorkflowStep> {
  NavigationNotifier() : super(WorkflowStep.onboarding);

  void setStep(WorkflowStep step) => state = step;

  void setStepByIndex(int index) {
    if (index >= 0 && index < WorkflowStep.values.length) {
      state = WorkflowStep.values[index];
    }
  }

  void next() {
    final index = state.index;
    // Skip support (index 5) in normal flow
    if (index < WorkflowStep.verification.index) {
      state = WorkflowStep.values[index + 1];
    }
  }

  void previous() {
    final index = state.index;
    if (index > 0 && state != WorkflowStep.support) {
      state = WorkflowStep.values[index - 1];
    }
  }

  void reset() => state = WorkflowStep.onboarding;
}

final navigationProvider = StateNotifierProvider<NavigationNotifier, WorkflowStep>((ref) {
  return NavigationNotifier();
});
