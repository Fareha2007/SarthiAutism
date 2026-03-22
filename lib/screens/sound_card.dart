import 'package:flutter/material.dart';
import 'package:sarthi_flutter_project/screens/sound_data.dart';

class SoundCard extends StatefulWidget {
  final SoundItem sound;
  final Color accentColor;
  final bool isPlaying;
  final VoidCallback onTap;

  const SoundCard({
    super.key,
    required this.sound,
    required this.accentColor,
    required this.isPlaying,
    required this.onTap,
  });

  @override
  State<SoundCard> createState() => _SoundCardState();
}

class _SoundCardState extends State<SoundCard> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _bounceController;
  late AnimationController _rippleController;
  late AnimationController _glowController;

  late Animation<double> _pulseAnim;
  late Animation<double> _bounceAnim;
  late Animation<double> _rippleAnim;
  late Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _bounceAnim = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
    );

    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _rippleAnim = Tween<double>(begin: 0.6, end: 1.4).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _glowAnim = Tween<double>(begin: 0.4, end: 0.9).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(SoundCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying && !oldWidget.isPlaying) {
      _pulseController.repeat(reverse: true);
      _glowController.repeat(reverse: true);
    } else if (!widget.isPlaying && oldWidget.isPlaying) {
      _pulseController.stop();
      _pulseController.animateTo(0);
      _glowController.stop();
      _glowController.animateTo(0);
    }
  }

  void _handleTap() {
    _bounceController.forward().then((_) => _bounceController.reverse());
    _rippleController.forward(from: 0.0);
    widget.onTap();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _bounceController.dispose();
    _rippleController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _pulseAnim,
          _bounceAnim,
          _rippleAnim,
          _glowAnim,
        ]),
        builder: (context, child) {
          return Transform.scale(
            scale:
                _bounceAnim.value * (widget.isPlaying ? _pulseAnim.value : 1.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Ripple
                if (_rippleController.isAnimating)
                  AnimatedOpacity(
                    opacity: (1.0 - _rippleController.value).clamp(0, 1),
                    duration: Duration.zero,
                    child: Transform.scale(
                      scale: _rippleAnim.value,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: widget.accentColor,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),

                // Card
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: widget.isPlaying
                          ? widget.accentColor
                          : Colors.transparent,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: widget.accentColor
                            .withOpacity(widget.isPlaying ? 0.35 : 0.15),
                        blurRadius: widget.isPlaying ? 20 : 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    // ✅ Reduced padding
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Column(
                      children: [
                        // ✅ Smaller emoji
                        Text(
                          widget.sound.emoji,
                          style: const TextStyle(fontSize: 40),
                        ),
                        const SizedBox(height: 6),
                        // ✅ Smaller name text
                        Text(
                          widget.sound.name,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: widget.isPlaying
                                ? widget.accentColor
                                : const Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // ✅ Only show wave when playing
                        if (widget.isPlaying)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.volume_up_rounded,
                                color: widget.accentColor,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              _SoundWaveIndicator(
                                color: widget.accentColor,
                                isPlaying: widget.isPlaying,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SoundWaveIndicator extends StatefulWidget {
  final Color color;
  final bool isPlaying;

  const _SoundWaveIndicator({required this.color, required this.isPlaying});

  @override
  State<_SoundWaveIndicator> createState() => _SoundWaveIndicatorState();
}

class _SoundWaveIndicatorState extends State<_SoundWaveIndicator>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _anims;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(3, (i) {
      return AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400 + i * 120),
      )..repeat(reverse: true);
    });
    _anims = _controllers.map((c) {
      return Tween<double>(begin: 4, end: 12).animate(
        CurvedAnimation(parent: c, curve: Curves.easeInOut),
      );
    }).toList();
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isPlaying) return const SizedBox.shrink();
    return AnimatedBuilder(
      animation: Listenable.merge(_controllers),
      builder: (context, _) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(3, (i) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 1.5),
              width: 3,
              height: _anims[i].value,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        );
      },
    );
  }
}
