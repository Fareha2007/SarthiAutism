import 'package:flutter/material.dart';
import 'dart:math' as math;

class CelebrationScreen extends StatefulWidget {
  final String levelName;
  final bool hasNextLevel;
  final VoidCallback onNextLevel;
  final VoidCallback onReplay;

  const CelebrationScreen({
    super.key,
    required this.levelName,
    required this.hasNextLevel,
    required this.onNextLevel,
    required this.onReplay,
  });

  @override
  State<CelebrationScreen> createState() => _CelebrationScreenState();
}

class _CelebrationScreenState extends State<CelebrationScreen>
    with TickerProviderStateMixin {
  late AnimationController _confettiController;
  late AnimationController _entryController;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;
  final _random = math.Random();
  late List<_ConfettiPiece> _pieces;

  @override
  void initState() {
    super.initState();
    _pieces = List.generate(40, (_) => _ConfettiPiece(_random));

    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();

    _scaleAnim =
        CurvedAnimation(parent: _entryController, curve: Curves.elasticOut);
    _fadeAnim = CurvedAnimation(parent: _entryController, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE8D5FF), Color(0xFFD0EEFF), Color(0xFFFFE8F5)],
        ),
      ),
      child: Stack(
        children: [
          // Confetti
          AnimatedBuilder(
            animation: _confettiController,
            builder: (_, __) => CustomPaint(
              painter: _ConfettiPainter(
                pieces: _pieces,
                progress: _confettiController.value,
              ),
              size: MediaQuery.of(context).size,
            ),
          ),

          // Back button top left
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(
                      color: const Color(0xFF7C3AED).withOpacity(0.2),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF7C3AED).withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 16,
                    color: Color(0xFF6A3DE8),
                  ),
                ),
              ),
            ),
          ),

          // Card
          Center(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: ScaleTransition(
                scale: _scaleAnim,
                child: Container(
                  margin: const EdgeInsets.all(32),
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.2),
                        blurRadius: 40,
                        spreadRadius: 8,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('🎉', style: TextStyle(fontSize: 64)),
                        const SizedBox(height: 12),
                        const Text(
                          'Amazing!',
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF7B2FF7),
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${widget.levelName} Complete!',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF9B6DFF),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('⭐', style: TextStyle(fontSize: 44)),
                            Text('⭐', style: TextStyle(fontSize: 52)),
                            Text('⭐', style: TextStyle(fontSize: 44)),
                          ],
                        ),
                        const SizedBox(height: 32),
                        if (widget.hasNextLevel)
                          _BigButton(
                            label: 'Next Level →',
                            color: const Color(0xFF7B2FF7),
                            onTap: widget.onNextLevel,
                          ),
                        const SizedBox(height: 12),
                        _BigButton(
                          label: 'Play Again 🔄',
                          color: const Color(0xFF26C6DA),
                          onTap: widget.onReplay,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BigButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _BigButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _ConfettiPiece {
  final double x;
  final double speed;
  final double size;
  final Color color;
  final double offset;
  final double spin;

  _ConfettiPiece(math.Random r)
      : x = r.nextDouble(),
        speed = 0.15 + r.nextDouble() * 0.2,
        size = 8 + r.nextDouble() * 12,
        offset = r.nextDouble() * math.pi * 2,
        spin = r.nextDouble() * math.pi * 2,
        color = [
          const Color(0xFFFF6B6B),
          const Color(0xFF4ECDC4),
          const Color(0xFFFFE66D),
          const Color(0xFF95E1D3),
          const Color(0xFFF38181),
          const Color(0xFF7B2FF7),
          const Color(0xFF26C6DA),
        ][r.nextInt(7)];
}

class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiPiece> pieces;
  final double progress;

  _ConfettiPainter({required this.pieces, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in pieces) {
      final y = (progress * p.speed * 3 + p.offset / (math.pi * 2)) % 1.0;
      final x = p.x * size.width + math.sin(progress * 4 + p.offset) * 30;
      final paint = Paint()..color = p.color.withOpacity(0.8);
      canvas.save();
      canvas.translate(x, y * size.height);
      canvas.rotate(progress * p.spin * 5);
      canvas.drawRect(
        Rect.fromCenter(
            center: Offset.zero, width: p.size, height: p.size * 0.5),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => old.progress != progress;
}
