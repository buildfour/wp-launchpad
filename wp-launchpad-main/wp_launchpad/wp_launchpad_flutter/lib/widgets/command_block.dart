import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class CommandBlock extends StatelessWidget {
  final String command;
  final String? label;

  const CommandBlock({
    super.key,
    required this.command,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.borderGray),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  command,
                  style: GoogleFonts.sourceCodePro(
                    textStyle: const TextStyle(
                      color: AppTheme.primaryNavy,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                height: 32,
                width: 1,
                color: AppTheme.borderGray,
              ),
              const SizedBox(width: 16),
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: command));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Copied to clipboard'),
                      behavior: SnackBarBehavior.floating,
                      width: 200,
                    ),
                  );
                },
                child: Row(
                  children: [
                    const Icon(Icons.copy_outlined, size: 18, color: AppTheme.primaryNavy),
                    const SizedBox(width: 8),
                    Text(
                      label ?? 'Copy Command',
                      style: const TextStyle(
                        color: AppTheme.primaryNavy,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
