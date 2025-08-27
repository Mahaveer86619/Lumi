import 'package:flutter/material.dart';

// The breakpoint where the layout switches from mobile to desktop.
const double kDesktopBreakpoint = 600.0;

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobileLayout,
    this.desktopLayout,
  });

  final Widget mobileLayout;
  final Widget? desktopLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > kDesktopBreakpoint &&
            desktopLayout != null) {
          return desktopLayout!;
        } else {
          return mobileLayout;
        }
      },
    );
  }
}
