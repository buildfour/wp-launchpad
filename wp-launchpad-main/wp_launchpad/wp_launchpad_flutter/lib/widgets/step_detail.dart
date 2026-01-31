import 'package:flutter/material.dart';
import '../widgets/step_badge.dart';

class StepDetail extends StatelessWidget {
  final String number;
  final String title;
  final String? description;
  final Widget? child;
  final bool isCompleted;

  const StepDetail({
    super.key,
    required this.number,
    required this.title,
    this.description,
    this.child,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StepBadge(text: number, isCompleted: isCompleted),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (description != null)
          Text(
            description!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        if (child != null) ...[
          const SizedBox(height: 12),
          child!,
        ],
      ],
    );
  }
}
