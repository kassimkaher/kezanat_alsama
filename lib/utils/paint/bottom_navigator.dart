import 'package:flutter/material.dart';
import 'package:ramadan/utils/utils.dart';

class BottomSheetShape extends CustomPainter {
  BottomSheetShape(this.color);
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    const radius = 800.0;
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    Path path = Path();
    Paint paint1 = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..style = PaintingStyle.fill;
    paint1.maskFilter = MaskFilter.blur(BlurStyle.outer, 10);

    Path path1 = Path();

    path.moveTo(0, 0);
    path.lineTo(0, 0);
    path.arcToPoint(Offset(size.width / 2, 25),
        radius: const Radius.circular(radius), clockwise: false);
    path.arcToPoint(Offset(size.width, 0),
        radius: const Radius.circular(radius), clockwise: false);

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();

    path1.moveTo(0, 0);
    path1.lineTo(0, 0);
    path1.arcToPoint(Offset(size.width, 0),
        radius: const Radius.circular(radius), clockwise: false);
    path1.lineTo(size.width, 0);
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);

    path1.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path1, paint1);
    // canvas.drawShadow(path1, jbUnselectColor.withOpacity(0.2), 2.0, false);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class BottomSheetShape1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const radius = 800.0;
    const box = 35;
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path();
    Paint paint1 = Paint()
      ..color = jbUnselectColor.withOpacity(0.4)
      ..style = PaintingStyle.fill;
    paint1.maskFilter = MaskFilter.blur(BlurStyle.outer, 10);

    Path path1 = Path();

    path.moveTo(0, 0);
    path.lineTo((size.width / 2) - box - 5, 0);

    path.arcToPoint(Offset((size.width / 2) - box, 6),
        radius: const Radius.circular(20), clockwise: true);

    path.arcToPoint(Offset((size.width / 2) + box, 6),
        radius: const Radius.circular(25), clockwise: false);

    path.arcToPoint(Offset((size.width / 2) + box + 5, 0),
        radius: const Radius.circular(18), clockwise: true);
    // path.arcToPoint(Offset(size.width, 0),
    //     radius: const Radius.circular(radius), clockwise: false);

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();

    path1.moveTo(0, 1);
    path1.lineTo(0, 1);
    path1.arcToPoint(Offset(size.width, 1),
        radius: const Radius.circular(radius), clockwise: false);
    path1.lineTo(size.width, 1);
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);

    path1.close();

    canvas.drawPath(path, paint);
    //canvas.drawPath(path1, paint1);
    // canvas.drawShadow(path1, jbUnselectColor.withOpacity(0.2), 2.0, false);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
