import 'package:flutter/material.dart';

class CurvePainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    // Define your curve using path commands:
    path.lineTo(0, 0); // Start at the bottom-left
    path.quadraticBezierTo(
        // Example: Quadratic curve
        size.width / 2,
        size.height / 2,
        0,
        size.height);
    path.lineTo((size.width / 4) * 3, size.height);
    path.quadraticBezierTo(
        // Example: Quadratic curve
        size.width,
        size.height / 2,
        (size.width / 4) * 2.2,
        0);
    // path.quadraticBezierTo(
    //     size.width * 3 / 4, size.height * 0.6, size.width, size.height * 0.8);
    // path.lineTo(size.width, 0); // Complete the clipping path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
