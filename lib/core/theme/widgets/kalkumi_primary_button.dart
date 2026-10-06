import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/resources/layout_app.dart';
import 'package:kalkumi/resources/values_app.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class KalkumiPrimaryButton extends StatelessWidget {
  const KalkumiPrimaryButton({
    required this.label,
    required this.onPressed,
    this.icon = Icons.play_arrow_rounded,
    this.keyValue,
    this.enabled = true,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData icon;
  final Key? keyValue;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final active = enabled && onPressed != null;
    return AnimatedOpacity(
      duration: AppValues.buttonAnimation,
      opacity: active ? 1 : 0.5,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: active
              ? const [
                  BoxShadow(
                    color: Color(0x383BB8FF),
                    blurRadius: 18,
                    offset: Offset(0, 9),
                  ),
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18.r),
          child: ShadButton(
            key: keyValue,
            width: double.infinity,
            height: AppLayout.buttonHeight,
            enabled: active,
            onPressed: active ? onPressed : null,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            leading: Icon(icon),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}
