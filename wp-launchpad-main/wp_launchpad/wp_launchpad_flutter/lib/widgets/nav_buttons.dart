import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';

class NavButtons extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onNext;
  final VoidCallback? onSave;
  final String nextLabel;

  const NavButtons({
    super.key,
    this.onBack,
    this.onNext,
    this.onSave,
    this.nextLabel = 'Next',
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      if (onBack != null)
        OutlinedButton.icon(
          onPressed: onBack,
          icon: const FaIcon(FontAwesomeIcons.arrowLeft, size: 14),
          label: const Text('Back'),
        )
      else
        const SizedBox.shrink(),
      if (onSave != null) ...[
        const SizedBox(width: 12),
        TextButton.icon(
          onPressed: onSave,
          icon: const FaIcon(FontAwesomeIcons.floppyDisk, size: 14, color: AppTheme.textMuted),
          label: const Text('Save & Exit', style: TextStyle(color: AppTheme.textMuted)),
        ),
      ],
      const Spacer(),
      if (onNext != null)
        ElevatedButton.icon(
          onPressed: onNext,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.accentOrange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
          icon: const FaIcon(FontAwesomeIcons.arrowRight, size: 14),
          label: Text(nextLabel),
        )
      else
        ElevatedButton.icon(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
          icon: const FaIcon(FontAwesomeIcons.arrowRight, size: 14),
          label: Text(nextLabel),
        ),
    ]);
  }
}
