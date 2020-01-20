import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shike_clock/models/time_in_shike.dart';

class ShiKeInCircle extends CustomPainter {
  final TimeInShiKe shiKeInTime;
  final DateTime now;
  final Color color;
  final Brightness brightness;
  ShiKeInCircle(
      {@required this.now, @required this.color, @required this.brightness})
      : shiKeInTime = TimeInShiKe(now);

  @override
  void paint(Canvas canvas, Size size) {
    final double radius =
        ((size.width >= size.height) ? size.height : size.width) * 0.71;

    Rect targetRect = Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        height: radius,
        width: radius);

    var paint = Paint();
    paint.style = PaintingStyle.stroke;
    paint.color = color;
    paint.strokeWidth = 1;

    canvas.drawArc(targetRect, 0, 2 * pi, false, paint);

    paint.color = this.brightness == Brightness.light
        ? Color.fromRGBO(255, 196, 8, 1)
        : Colors.red;
    // Color.fromRGBO(255, 196, 8, 1) is the color of TOHOH, source: https://nipponcolors.com/#tohoh

    paint.strokeWidth = 2;
    double oneShiInAngle = 2 * pi / 12;
    double halfShi = oneShiInAngle / 2;
    double startPointOfDay = pi + pi / 2 - halfShi;
    double startPoint = startPointOfDay + (shiKeInTime.shiIndex * halfShi * 2);
    if (startPoint > 2 * pi) {
      startPoint = startPoint - 2 * pi;
    }
    canvas.drawArc(targetRect, startPoint, oneShiInAngle, false, paint);

    paint.strokeWidth = 5;
    double oneKeInAngle = oneShiInAngle / 8;
    startPoint = startPoint + oneKeInAngle * shiKeInTime.keIndex;
    canvas.drawArc(targetRect, startPoint, oneKeInAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
