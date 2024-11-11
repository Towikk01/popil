import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final double opacity;
  final String image;
  final Widget? child;
  final double? sigmaX;
  final double? sigmaY;
  const BackgroundImage(
      {super.key,
      required this.opacity,
      required this.image,
      this.child,
      this.sigmaX,
      this.sigmaY});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(fit: StackFit.expand, children: [
          Image.asset(image, fit: BoxFit.fitHeight),
          BackdropFilter(
              filter:
                  ImageFilter.blur(sigmaX: sigmaX ?? 3, sigmaY: sigmaY ?? 3),
              child: Container(color: Colors.black.withOpacity(opacity))),
          if (child != null) child!
        ]));
  }
}
