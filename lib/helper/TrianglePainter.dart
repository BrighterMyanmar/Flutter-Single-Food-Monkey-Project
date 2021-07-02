import 'package:app/util/Constants.dart';
import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  var mSize;
  TrianglePainter(this.mSize);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Constants.accent;

    var upPath = Path();
    upPath.moveTo(mSize.width / 3, 0);
    upPath.lineTo(mSize.width, 0);
    upPath.lineTo(mSize.width, mSize.height / 3);
    upPath.close();

    var downPath = Path();
    downPath.moveTo(0, (mSize.height / 3) * 2);
    downPath.lineTo(0, mSize.height);
    downPath.lineTo((mSize.width / 5) * 3, mSize.height);
    downPath.close();

    canvas.drawPath(upPath, paint);
    canvas.drawPath(downPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
