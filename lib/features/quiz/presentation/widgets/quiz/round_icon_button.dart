import 'package:flutter/material.dart';
import 'package:kalkumi/core/theme/app_theme.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: tooltip,
    onPressed: onPressed,
    icon: Icon(icon),
    color: AppColors.navy,
    style: IconButton.styleFrom(
      backgroundColor: Colors.white.withValues(alpha: .94),
      side: const BorderSide(color: AppColors.border),
    ),
  );
}
