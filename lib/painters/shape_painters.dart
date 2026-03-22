import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/shape_model.dart';

// ─── Filled Shape Painter ────────────────────────────────────────────────────

class FilledShapePainter extends CustomPainter {
  final ShapeType type;
  final Color color;
  final double opacity;

  FilledShapePainter({
    required this.type,
    required this.color,
    this.opacity = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(opacity)
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = color.withOpacity(opacity * 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final path = _buildPath(size);
    canvas.drawPath(path, shadowPaint);
    canvas.drawPath(path, paint);

    // Highlight
    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    canvas.save();
    canvas.clipPath(path);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.38, size.height * 0.3),
        width: size.width * 0.4,
        height: size.height * 0.25,
      ),
      highlightPaint,
    );
    canvas.restore();
  }

  Path _buildPath(Size size) {
    switch (type) {
      case ShapeType.circle:
        return Path()..addOval(Rect.fromLTWH(0, 0, size.width, size.height));
      case ShapeType.square:
        return Path()
          ..addRRect(RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height),
            const Radius.circular(12),
          ));
      case ShapeType.triangle:
        return Path()
          ..moveTo(size.width / 2, 0)
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close();
      case ShapeType.rectangle:
        return Path()
          ..addRRect(RRect.fromRectAndRadius(
            Rect.fromLTWH(0, size.height * 0.15, size.width, size.height * 0.7),
            const Radius.circular(10),
          ));
      case ShapeType.star:
        return _starPath(size, 5, size.width / 2, size.height / 2,
            size.width / 2 * 0.9, size.width / 2 * 0.4);
      case ShapeType.heart:
        return _heartPath(size);
      case ShapeType.diamond:
        return Path()
          ..moveTo(size.width / 2, 0)
          ..lineTo(size.width, size.height / 2)
          ..lineTo(size.width / 2, size.height)
          ..lineTo(0, size.height / 2)
          ..close();
      case ShapeType.pentagon:
        return _polygonPath(size, 5);
    }
  }

  Path _starPath(Size size, int points, double cx, double cy, double outerR,
      double innerR) {
    final path = Path();
    final angle = (math.pi * 2) / points;
    for (int i = 0; i < points * 2; i++) {
      final r = i.isEven ? outerR : innerR;
      final a = i * angle / 2 - math.pi / 2;
      final x = cx + r * math.cos(a);
      final y = cy + r * math.sin(a);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    return path..close();
  }

  Path _heartPath(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;
    path.moveTo(w / 2, h * 0.85);
    path.cubicTo(w * -0.1, h * 0.55, w * -0.1, h * 0.1, w / 2, h * 0.35);
    path.cubicTo(w * 1.1, h * 0.1, w * 1.1, h * 0.55, w / 2, h * 0.85);
    return path;
  }

  Path _polygonPath(Size size, int sides) {
    final path = Path();
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2 * 0.92;
    final angle = (math.pi * 2) / sides;
    for (int i = 0; i < sides; i++) {
      final a = i * angle - math.pi / 2;
      final x = cx + r * math.cos(a);
      final y = cy + r * math.sin(a);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    return path..close();
  }

  @override
  bool shouldRepaint(FilledShapePainter old) =>
      old.color != color || old.opacity != opacity || old.type != type;
}

// ─── Outline Shape Painter ───────────────────────────────────────────────────

class OutlineShapePainter extends CustomPainter {
  final ShapeType type;
  final Color color;
  final bool filled;
  final bool glowing;

  OutlineShapePainter({
    required this.type,
    required this.color,
    this.filled = false,
    this.glowing = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (glowing) {
      final glowPaint = Paint()
        ..color = color.withOpacity(0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 18
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
      canvas.drawPath(_buildPath(size), glowPaint);
    }

    final paint = Paint()
      ..color = filled ? color : color.withOpacity(0.5)
      ..style = filled ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 3.5;

    if (!filled) {
      // Dashed stroke
      final dashPaint = Paint()
        ..color = color.withOpacity(0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5
        ..strokeCap = StrokeCap.round;
      _drawDashedPath(canvas, _buildPath(size), dashPaint);
    } else {
      canvas.drawPath(_buildPath(size), paint);
    }
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    const dashLength = 10.0;
    const gapLength = 6.0;
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double distance = 0;
      bool draw = true;
      while (distance < metric.length) {
        final len = draw ? dashLength : gapLength;
        if (draw) {
          canvas.drawPath(
            metric.extractPath(distance, distance + len),
            paint,
          );
        }
        distance += len;
        draw = !draw;
      }
    }
  }

  Path _buildPath(Size size) {
    final painter = FilledShapePainter(type: type, color: color);
    return painter._buildPath(size);
  }

  @override
  bool shouldRepaint(OutlineShapePainter old) =>
      old.filled != filled || old.glowing != glowing || old.color != color;
}
