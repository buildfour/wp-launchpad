import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class StepBadge extends StatelessWidget {
  final String text;
  final bool isCompleted;
  final bool isActive;

  const StepBadge({
    super.key,
    required this.text,
    this.isCompleted = false,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    if (isCompleted) {
      return Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: Color(0xFF10B981),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, color: Colors.white, size: 20),
      );
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isActive ? AppTheme.accentOrange : AppTheme.borderGray,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
