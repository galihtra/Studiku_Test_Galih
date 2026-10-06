import 'package:flutter/material.dart';
import 'package:kalkumi/core/theme/app_theme.dart';
import 'package:kalkumi/core/theme/widgets/backdrop_bubble.dart';

class KalkumiBackdrop extends StatelessWidget {
  const KalkumiBackdrop({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.background, Color(0xFFEAF7FF)],
              ),
            ),
          ),
        ),
        const Positioned(
          top: -70,
          right: -65,
          child: BackdropBubble(size: 210, color: Color(0x243BB8FF)),
        ),
        const Positioned(
          top: 330,
          left: -85,
          child: BackdropBubble(size: 180, color: Color(0x1C35D69F)),
        ),
        const Positioned(
          bottom: 70,
          right: -55,
          child: BackdropBubble(size: 150, color: Color(0x20FFC83D)),
        ),
        child,
      ],
    );
  }
}
