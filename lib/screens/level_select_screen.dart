import 'package:flutter/material.dart';
import 'package:sarthi_flutter_project/screens/puzzle_screen.dart';

class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({super.key});

  static const _levels = [
    {
      'index': 0,
      'name': 'Starter',
      'emoji': '🌱',
      'shapeCount': '3 shapes',
      'color': Color(0xFF43A047),
      'desc': 'Circle · Square · Triangle',
    },
    {
      'index': 1,
      'name': 'Explorer',
      'emoji': '🌤️',
      'shapeCount': '5 shapes',
      'color': Color(0xFF1E88E5),
      'desc': 'Adds Rectangle & Star',
    },
    {
      'index': 2,
      'name': 'Champion',
      'emoji': '🌈',
      'shapeCount': '8 shapes',
      'color': Color(0xFF8E24AA),
      'desc': 'Adds Heart, Diamond & Pentagon',
    },
  ];

  void _startLevel(BuildContext ctx, int index) {
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (_) => PuzzleScreen(levelIndex: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFEDE7FF), Color(0xFFE3F2FF), Color(0xFFF3E5F5)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(
                              color: const Color(0xFF7C3AED).withOpacity(0.2)),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF7C3AED).withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded,
                            size: 16, color: Color(0xFF6A3DE8)),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shape Puzzle',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF6A3DE8),
                            height: 1.1,
                          ),
                        ),
                        Text(
                          'Choose your level',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF9575CD),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Instruction banner
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: const Color(0xFF7C3AED).withOpacity(0.15)),
                  ),
                  child: Row(
                    children: [
                      const Text('👆', style: TextStyle(fontSize: 20)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Drag shapes from the tray and drop them onto matching outlines!',
                          style: TextStyle(
                            fontSize: 13,
                            color: const Color(0xFF6A3DE8).withOpacity(0.8),
                            height: 1.4,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Level cards
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                  itemCount: _levels.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (ctx, i) {
                    final lvl = _levels[i];
                    return _LevelCard(
                      index: lvl['index'] as int,
                      name: lvl['name'] as String,
                      emoji: lvl['emoji'] as String,
                      shapeCount: lvl['shapeCount'] as String,
                      desc: lvl['desc'] as String,
                      color: lvl['color'] as Color,
                      onTap: () => _startLevel(ctx, lvl['index'] as int),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LevelCard extends StatefulWidget {
  final int index;
  final String name;
  final String emoji;
  final String shapeCount;
  final String desc;
  final Color color;
  final VoidCallback onTap;

  const _LevelCard({
    required this.index,
    required this.name,
    required this.emoji,
    required this.shapeCount,
    required this.desc,
    required this.color,
    required this.onTap,
  });

  @override
  State<_LevelCard> createState() => _LevelCardState();
}

class _LevelCardState extends State<_LevelCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 110));
    _scale = Tween(begin: 1.0, end: 0.97)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.15),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                    child: Text(widget.emoji,
                        style: const TextStyle(fontSize: 34))),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Level ${widget.index + 1} — ${widget.name}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: widget.color,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(widget.desc,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF90A4AE),
                            height: 1.4)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: widget.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.shapeCount,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: widget.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.play_circle_rounded, color: widget.color, size: 34),
            ],
          ),
        ),
      ),
    );
  }
}
