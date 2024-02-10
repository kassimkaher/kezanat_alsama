import 'dart:ui';

import 'package:flutter/material.dart';

class BlureWidget extends StatelessWidget {
  const BlureWidget({
    required this.child,
    this.borderRadius,
    this.margin,
    this.height,
    this.width,
    this.sigmaX,
    this.sigmaY,
    super.key,
  });
  final Widget child;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? width;
  final double? sigmaX;
  final double? sigmaY;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
            child: BackdropFilter(
              filter:
                  ImageFilter.blur(sigmaX: sigmaX ?? 10, sigmaY: sigmaY ?? 10),
              child: Container(
                margin: const EdgeInsets.all(16),
                height: height,
              ),
            ),
          ),
          child
        ],
      ),
    );
  }
}
