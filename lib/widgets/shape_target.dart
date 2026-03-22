
import 'package:flutter/material.dart';
import '../models/shape_model.dart';
import '../painters/shape_painters.dart';

class ShapeTarget extends StatefulWidget {
  final ShapeModel shape;
  final double size;
  final bool isPlaced;
  final VoidCallback onCorrect;
  final VoidCallback onWrong;

  const ShapeTarget({
    super.key,
    required this.shape,
    required this.size,
    required this.isPlaced,
    required this.onCorrect,
    required this.onWrong,
  });

  @override
  State<ShapeTarget> createState() => _ShapeTargetState();
}

class _ShapeTargetState extends State<ShapeTarget>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _snapController;
  late AnimationController _shakeController;
  late Animation<double> _pulse;
  late Animation<double> _snap;
  late Animation<double> _shake;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _pulse = Tween<double>(begin: 0.97, end: 1.03).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _snapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _snap = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _snapController, curve: Curves.elasticOut),
    );

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shake = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -8.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: -6.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -6.0, end: 6.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 6.0, end: 0.0), weight: 1),
    ]).animate(_shakeController);
  }

  @override
  void didUpdateWidget(ShapeTarget old) {
    super.didUpdateWidget(old);
    if (widget.isPlaced && !old.isPlaced) {
      _snapController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _snapController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  void _triggerShake() {
    _shakeController.forward(from: 0);
    widget.onWrong();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<ShapeModel>(
      onWillAcceptWithDetails: (details) {
        final incoming = details.data;
        setState(() => _isHovered = incoming.type == widget.shape.type);
        return true;
      },
      onLeave: (_) => setState(() => _isHovered = false),
      onAcceptWithDetails: (details) {
        setState(() => _isHovered = false);
        if (details.data.type == widget.shape.type) {
          widget.onCorrect();
        } else {
          _triggerShake();
        }
      },
      builder: (context, candidateData, rejectedData) {
        final isHovered = _isHovered && !widget.isPlaced;

        return AnimatedBuilder(
          animation: Listenable.merge([_pulse, _snap, _shake]),
          builder: (_, __) {
            return Transform.translate(
              offset: Offset(_shake.value, 0),
              child: Transform.scale(
                scale: widget.isPlaced
                    ? _snap.value.clamp(0.0, 1.0) * 0.08 + 0.92
                    : _pulse.value,
                child: _buildTarget(isHovered),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTarget(bool isHovered) {
    final size = widget.size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size + 16,
          height: size + 16,
          decoration: isHovered
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: widget.shape.color.withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 4,
                    ),
                  ],
                )
              : null,
          child: Center(
            child: SizedBox(
              width: size,
              height: size,
              child: widget.isPlaced
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          size: Size(size, size),
                          painter: FilledShapePainter(
                            type: widget.shape.type,
                            color: widget.shape.color,
                          ),
                        ),
                        const Positioned(
                          top: 0,
                          right: 0,
                          child: Text('✅', style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    )
                  : CustomPaint(
                      size: Size(size, size),
                      painter: OutlineShapePainter(
                        type: widget.shape.type,
                        color: widget.shape.color,
                        glowing: isHovered,
                      ),
                    ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          widget.shape.name,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: widget.isPlaced
                ? widget.shape.color
                : Colors.grey.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}