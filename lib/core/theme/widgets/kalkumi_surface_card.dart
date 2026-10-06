import 'package:flutter/material.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/resources/layout_app.dart';

class KalkumiSurfaceCard extends StatelessWidget {
  const KalkumiSurfaceCard({
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.borderRadius,
    this.borderColor = AppColors.border,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry? borderRadius;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.97),
        borderRadius:
            borderRadius ?? BorderRadius.circular(AppLayout.cardRadius),
        border: Border.all(color: borderColor),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14123A82),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}
