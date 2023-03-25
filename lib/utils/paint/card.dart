import 'package:flutter/material.dart';
import 'package:ramadan/utils/utils.dart';
import 'dart:math' as math;

class CardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const radius = 13.0;

    Paint paint1 = Paint()
      ..color = jbUnselectColor.withOpacity(0.2)
      ..style = PaintingStyle.fill;
    paint1.maskFilter = MaskFilter.blur(BlurStyle.outer, 2);

    Path path1 = Path();

    path1.lineTo(size.width - radius, 0);
    path1.arcToPoint(Offset(size.width, radius),
        radius: const Radius.circular(radius), clockwise: true);
    // path.quadraticBezierTo(size.width - radius, 0, size.width, radius);

    path1.lineTo(size.width, size.height - radius);
    path1.arcToPoint(Offset(size.width - radius, size.height),
        radius: const Radius.circular(radius), clockwise: true);
    path1.lineTo(radius, size.height);
    path1.arcToPoint(Offset(0, size.height - radius),
        radius: const Radius.circular(radius), clockwise: true);
    path1.lineTo(0, radius);

    path1.arcToPoint(Offset(radius, 0),
        radius: const Radius.circular(radius), clockwise: true);

    canvas.drawPath(path1, paint1);
    // canvas.drawShadow(path1, jbUnselectColor.withOpacity(0.2), 2.0, false);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
