
import 'package:flutter/material.dart';
import 'package:sarthi_flutter_project/widgets/shape_card.dart';
import 'package:sarthi_flutter_project/widgets/shape_target.dart';
import 'package:sarthi_flutter_project/widgets/star_burst.dart';
import 'package:sarthi_flutter_project/models/shape_model.dart';
import 'package:sarthi_flutter_project/models/audio_services.dart';
import 'celebration_screen.dart';

class PuzzleScreen extends StatefulWidget {
  final int levelIndex;

  const PuzzleScreen({
    super.key,
    required this.levelIndex,
  });

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  late LevelData _level;
  late List<bool> _placed;
  final AudioService _audio = AudioService();
  final List<_BurstData> _bursts = [];
  bool _showCelebration = false;
  final GlobalKey _boardKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadLevel();
    _audio.init();
  }

  void _loadLevel() {
    _level = getLevel(widget.levelIndex);
    for (final shape in _level.shapes) {
      shape.isPlaced = false;
    }
    _placed = List.filled(_level.shapes.length, false);
    _showCelebration = false;
    _bursts.clear();
  }

  void _onCorrectDrop(int index, Offset globalPos) {
    setState(() {
      _placed[index] = true;
      _level.shapes[index].isPlaced = true;

      final box = _boardKey.currentContext?.findRenderObject() as RenderBox?;
      final local = box?.globalToLocal(globalPos) ?? globalPos;
      _bursts.add(_BurstData(
        position: local,
        color: _level.shapes[index].color,
        id: DateTime.now().microsecondsSinceEpoch,
      ));
    });

    _audio.playCorrect();
    _audio.speakShape(
      _level.shapes[index].name,
      _level.shapes[index].colorName,
    );

    if (_placed.every((p) => p)) {
      Future.delayed(const Duration(milliseconds: 1200), () {
        _audio.playFanfare();
        _audio.speakText('Amazing! You did it!');
        setState(() => _showCelebration = true);
      });
    }
  }

  void _onWrongDrop() {}

  void _removeBurst(int id) {
    setState(() => _bursts.removeWhere((b) => b.id == id));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 400;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFEDE7FF),
                  Color(0xFFE3F2FF),
                  Color(0xFFF8F0FF),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
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
                                color: const Color(0xFF7C3AED).withOpacity(0.2),
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 16,
                              color: Color(0xFF6A3DE8),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '${_level.emoji} ${_level.name}',
                            style: TextStyle(
                              fontSize: isSmall ? 20 : 24,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF6A3DE8),
                            ),
                          ),
                        ),
                        Row(
                          children: List.generate(
                            _level.shapes.length,
                            (i) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              width: _placed[i] ? 12 : 8,
                              height: _placed[i] ? 12 : 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _placed[i]
                                    ? _level.shapes[i].color
                                    : Colors.grey.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Stack(
                      key: _boardKey,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 12,
                              runSpacing: 12,
                              children: List.generate(
                                _level.shapes.length,
                                (i) => ShapeTarget(
                                  shape: _level.shapes[i],
                                  size: _level.targetSize,
                                  isPlaced: _placed[i],
                                  onCorrect: () =>
                                      _onCorrectDrop(i, Offset.zero),
                                  onWrong: _onWrongDrop,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ..._bursts.map((b) => StarBurstOverlay(
                              key: ValueKey(b.id),
                              position: b.position,
                              color: b.color,
                              onComplete: () => _removeBurst(b.id),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    height: 2,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple.withOpacity(0.1),
                          Colors.purple.withOpacity(0.3),
                          Colors.purple.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            'Pick a shape!',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.purple.withOpacity(0.5),
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  _level.shapes.length,
                                  (i) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    child: ShapeCard(
                                      shape: _level.shapes[i],
                                      size: isSmall ? 52 : 62,
                                      isPlaced: _placed[i],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_showCelebration)
            CelebrationScreen(
              levelName: '${_level.emoji} ${_level.name}',
              hasNextLevel: widget.levelIndex < 2,
              onNextLevel: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        PuzzleScreen(levelIndex: widget.levelIndex + 1),
                  ),
                );
              },
              onReplay: () => setState(_loadLevel),
            ),
        ],
      ),
    );
  }
}

class _BurstData {
  final Offset position;
  final Color color;
  final int id;
  _BurstData({required this.position, required this.color, required this.id});
}