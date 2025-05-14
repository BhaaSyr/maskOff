import 'package:flutter/material.dart';

class BlackAreaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black;

    final path = Path();
    path.moveTo(0, 60);
    path.quadraticBezierTo(0, 0, 60, 0);
    path.lineTo(size.width - 60, 0);
    path.quadraticBezierTo(size.width, 0, size.width, -50);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // Gölge için ayrı bir boya
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.8)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);

    // Gölgeyi biraz sağa ve aşağıya kaydır
    canvas.drawPath(path.shift(const Offset(0, -4)), shadowPaint);

    // Ana şekli çiz
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
