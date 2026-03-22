import 'package:flutter/material.dart';
import '../models/shape_model.dart';
import '../painters/shape_painters.dart';

class ShapeCard extends StatefulWidget {
  final ShapeModel shape;
  final double size;
  final bool isPlaced;

  const ShapeCard({
    super.key,
    required this.shape,
    required this.size,
    this.isPlaced = false,
  });

  @override
  State<ShapeCard> createState() => _ShapeCardState();
}

class _ShapeCardState extends State<ShapeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _floatAnim = Tween<double>(begin: -4, end: 4).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isPlaced) {
      return SizedBox(
        width: widget.size + 20,
        height: widget.size + 40,
        child: Opacity(opacity: 0.2, child: _buildCard(false)),
      );
    }

    return Draggable<ShapeModel>(
      data: widget.shape,
      feedback: _DragFeedback(shape: widget.shape, size: widget.size),
      childWhenDragging: SizedBox(
        width: widget.size + 20,
        height: widget.size + 40,
        child: Opacity(opacity: 0.25, child: _buildCard(false)),
      ),
      child: AnimatedBuilder(
        animation: _floatAnim,
        builder: (_, __) => Transform.translate(
          offset: Offset(0, _floatAnim.value),
          child: _buildCard(false),
        ),
      ),
    );
  }

  Widget _buildCard(bool isDragging) {
    return Container(
      width: widget.size + 20,
      height: widget.size + 40,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: widget.shape.color.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: widget.size,
            height: widget.size,
            child: CustomPaint(
              painter: FilledShapePainter(
                type: widget.shape.type,
                color: widget.shape.color,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.shape.name,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: widget.shape.color.withOpacity(0.9),
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _DragFeedback extends StatefulWidget {
  final ShapeModel shape;
  final double size;

  const _DragFeedback({required this.shape, required this.size});

  @override
  State<_DragFeedback> createState() => _DragFeedbackState();
}

class _DragFeedbackState extends State<_DragFeedback>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
    _pulse = Tween<double>(begin: 1.05, end: 1.12).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (_, __) => Transform.scale(
        scale: _pulse.value,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: widget.size + 20,
            height: widget.size + 40,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.92),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: widget.shape.color.withOpacity(0.5),
                  blurRadius: 24,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: widget.size,
                  height: widget.size,
                  child: CustomPaint(
                    painter: FilledShapePainter(
                      type: widget.shape.type,
                      color: widget.shape.color,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.shape.name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: widget.shape.color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
