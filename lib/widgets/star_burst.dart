import 'package:flutter/material.dart';
import 'dart:math' as math;

class StarBurstOverlay extends StatefulWidget {
  final Offset position;
  final Color color;
  final VoidCallback onComplete;

  const StarBurstOverlay({
    super.key,
    required this.position,
    required this.color,
    required this.onComplete,
  });

  @override
  State<StarBurstOverlay> createState() => _StarBurstOverlayState();
}

class _StarBurstOverlayState extends State<StarBurstOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_Particle> _particles;
  final _random = math.Random();

  @override
  void initState() {
    super.initState();
    _particles = List.generate(18, (_) => _Particle(_random, widget.color));
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )
      ..addListener(() => setState(() {}))
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed) widget.onComplete();
      })
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: CustomPaint(
          painter: _StarBurstPainter(
            particles: _particles,
            progress: _controller.value,
            origin: widget.position,
          ),
        ),
      ),
    );
  }
}

class _Particle {
  final double angle;
  final double speed;
  final double size;
  final Color color;
  final bool isStar;

  _Particle(math.Random r, Color baseColor)
      : angle = r.nextDouble() * math.pi * 2,
        speed = 80 + r.nextDouble() * 120,
        size = 6 + r.nextDouble() * 10,
        isStar = r.nextBool(),
        color = HSLColor.fromColor(baseColor)
            .withLightness(0.5 + r.nextDouble() * 0.3)
            .withSaturation(0.8 + r.nextDouble() * 0.2)
            .toColor();
}

class _StarBurstPainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  final Offset origin;

  _StarBurstPainter({
    required this.particles,
    required this.progress,
    required this.origin,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final ease = Curves.easeOut.transform(progress);
    for (final p in particles) {
      final opacity = (1 - ease).clamp(0.0, 1.0);
      final x = origin.dx + math.cos(p.angle) * p.speed * ease;
      final y = origin.dy + math.sin(p.angle) * p.speed * ease + 60 * ease * ease;
      final paint = Paint()..color = p.color.withOpacity(opacity);
      if (p.isStar) {
        _drawStar(canvas, Offset(x, y), p.size * (1 - ease * 0.5), paint);
      } else {
        canvas.drawCircle(Offset(x, y), p.size * (1 - ease * 0.5), paint);
      }
    }
  }

  void _drawStar(Canvas canvas, Offset center, double r, Paint paint) {
    final path = Path();
    for (int i = 0; i < 10; i++) {
      final radius = i.isEven ? r : r * 0.4;
      final angle = i * math.pi / 5 - math.pi / 2;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    canvas.drawPath(path..close(), paint);
  }

  @override
  bool shouldRepaint(_StarBurstPainter old) => old.progress != progress;
}