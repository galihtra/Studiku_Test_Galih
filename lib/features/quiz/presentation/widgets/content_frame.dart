import 'package:flutter/material.dart';
import 'package:kalkumi/resources/layout_app.dart';

class ContentFrame extends StatelessWidget {
  const ContentFrame({
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(20, 12, 20, 32),
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: AppLayout.contentConstraints,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
