import 'dart:math';
import 'package:flutter/material.dart';

class EmotionGameScreen extends StatefulWidget {
  const EmotionGameScreen({super.key});

  @override
  State<EmotionGameScreen> createState() => _EmotionGameScreenState();
}

class _EmotionGameScreenState extends State<EmotionGameScreen>
    with TickerProviderStateMixin {
  // --- GAME SETTINGS ---
  final int _totalRounds = 5; // The finish line
  int _score = 0;
  bool _isGameOver = false;

  // --- DATA ---
  final List<Map<String, String>> _emotions = [
    {'emoji': '🙂', 'name': 'HAPPY'},
    {'emoji': '😢', 'name': 'SAD'},
    {'emoji': '😡', 'name': 'ANGRY'},
    {'emoji': '😮', 'name': 'SURPRISED'},
    {'emoji': '😴', 'name': 'SLEEPY'},
    {'emoji': '🤢', 'name': 'SICK'},
  ];

  final List<Color> _cardColors = [
    Colors.pink[100]!,
    Colors.blue[100]!,
    Colors.green[100]!,
    Colors.orange[100]!,
    Colors.purple[100]!,
    Colors.yellow[100]!,
  ];

  String _targetEmotion = '';
  String _targetEmoji = '';
  bool _showOverlay = false;
  Color _overlayColor = Colors.transparent;

  late AnimationController _gridController;
  late AnimationController _scoreController;
  late AnimationController _pulseController;
  late AnimationController _victoryController;

  List<Widget> _confetti = [];

  @override
  void initState() {
    super.initState();

    _gridController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scoreController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _victoryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _generateNewQuestion(start: true);
  }

  @override
  void dispose() {
    _gridController.dispose();
    _scoreController.dispose();
    _pulseController.dispose();
    _victoryController.dispose();
    super.dispose();
  }

  void _restartGame() {
    setState(() {
      _score = 0;
      _isGameOver = false;
    });
    _generateNewQuestion(start: true);
  }

  void _generateNewQuestion({bool start = false}) {
    final random = Random();
    final int index = random.nextInt(_emotions.length);

    setState(() {
      _targetEmotion = _emotions[index]['name']!;
      _targetEmoji = _emotions[index]['emoji']!;
      _emotions.shuffle();
    });

    _gridController.reset();
    _gridController.forward();
  }

  void _spawnConfetti(Offset position) {
    final random = Random();
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.purple
    ];

    setState(() {
      _confetti = List.generate(20, (index) {
        double dx = (random.nextDouble() - 0.5) * 400;
        double dy = (random.nextDouble() - 0.5) * 400;

        return _ConfettiPiece(
          color: colors[random.nextInt(colors.length)],
          startPosition: position,
          endOffset: Offset(dx, dy),
          onComplete: () {
            if (mounted) {
              setState(() => _confetti.clear());
            }
          },
        );
      });
    });
  }

  void _checkAnswer(String selectedName, int index, Offset tapPosition) async {
    if (_isGameOver) return; // Don't allow input if game over

    if (selectedName == _targetEmotion) {
      _spawnConfetti(tapPosition);

      setState(() {
        _score++;
        _overlayColor = Colors.green.withOpacity(0.3);
        _showOverlay = true;
      });

      _scoreController.forward(from: 0.0);

      await Future.delayed(const Duration(milliseconds: 600));

      setState(() {
        _showOverlay = false;
      });

      // CHECK FOR WIN CONDITION
      if (_score >= _totalRounds) {
        setState(() {
          _isGameOver = true;
        });
        _victoryController.forward();
      } else {
        await Future.delayed(const Duration(milliseconds: 400));
        _generateNewQuestion();
      }
    } else {
      setState(() {
        _overlayColor = Colors.red.withOpacity(0.3);
        _showOverlay = true;
      });

      _cardKeys[index].currentState?.shake();

      await Future.delayed(const Duration(milliseconds: 400));

      setState(() {
        _showOverlay = false;
      });
    }
  }

  final List<GlobalKey<_GameCardState>> _cardKeys =
      List.generate(6, (_) => GlobalKey<_GameCardState>());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final Size screenSize = constraints.biggest;
        final double screenWidth = screenSize.width;
        final double screenHeight = screenSize.height;

        int crossAxisCount = screenWidth > 600 ? 3 : 2;
        double questionFontSize = screenWidth * 0.09;
        double emojiFontSize = screenWidth * 0.15;

        return Stack(
          children: [
            // 1. BACKGROUND
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.indigo[50]!,
                    Colors.lightBlue[100]!,
                    Colors.purple[50]!,
                  ],
                ),
              ),
            ),

            _FloatingBubbles(screenSize: screenSize),

            // 2. OVERLAY FLASH
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              color: _showOverlay ? _overlayColor : Colors.transparent,
            ),

            // 3. CONFETTI
            ..._confetti,

            // 4. MAIN UI
            Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: _isGameOver
                    ? _buildVictoryScreen(screenSize)
                    : _buildGameUI(screenSize, crossAxisCount, questionFontSize,
                        emojiFontSize),
              ),
            ),
          ],
        );
      },
    );
  }

  // --- VICTORY SCREEN ---
  Widget _buildVictoryScreen(Size size) {
    return ScaleTransition(
      scale:
          CurvedAnimation(parent: _victoryController, curve: Curves.elasticOut),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Exit Button (Top Right)
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 5)
                    ],
                  ),
                  child: const Icon(Icons.close,
                      color: Colors.redAccent, size: 30),
                ),
              ),
            ),
          ),

          Spacer(),

          Text("🎉 YOU WIN! 🎉",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple)),
          SizedBox(height: 20),
          Text("Great Job!",
              style: TextStyle(fontSize: 28, color: Colors.purple[300])),
          SizedBox(height: 50),

          // Play Again Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[400],
                minimumSize: Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: _restartGame,
              child: Text("Play Again",
                  style: TextStyle(fontSize: 24, color: Colors.white)),
            ),
          ),
          SizedBox(height: 20),

          // Exit Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[300],
                minimumSize: Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Exit Game",
                  style: TextStyle(fontSize: 24, color: Colors.white)),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  // --- GAME UI ---
  Widget _buildGameUI(Size screenSize, int crossAxisCount,
      double questionFontSize, double emojiFontSize) {
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // --- TOP BAR ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // STOP BUTTON
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 4))
                    ],
                  ),
                  child: const Center(
                    child: Icon(Icons.close, color: Colors.redAccent, size: 35),
                  ),
                ),
              ),

              // SCORE & PROGRESS
              Column(
                children: [
                  ScaleTransition(
                    scale: Tween<double>(begin: 1.0, end: 1.5).animate(
                      CurvedAnimation(
                          parent: _scoreController, curve: Curves.elasticOut),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.purple.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 2)
                        ],
                      ),
                      child: Row(
                        children: [
                          const Text("⭐", style: TextStyle(fontSize: 24)),
                          const SizedBox(width: 10),
                          Text(
                            '$_score / $_totalRounds',
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // PROGRESS BAR
                  Container(
                    width: 120,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: _score / _totalRounds,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green[400],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // --- QUESTION ---
          ScaleTransition(
            scale: Tween<double>(begin: 1.0, end: 1.05).animate(
              CurvedAnimation(
                  parent: _pulseController, curve: Curves.easeInOut),
            ),
            child: Column(
              children: [
                Text(
                  'Which face is',
                  style: TextStyle(
                    fontSize: questionFontSize * 0.6,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  _targetEmotion + '?',
                  style: TextStyle(
                    fontSize: questionFontSize,
                    fontWeight: FontWeight.w900,
                    color: Colors.deepPurple,
                  ),
                ),
                Text(
                  _targetEmoji,
                  style: const TextStyle(fontSize: 30),
                ),
              ],
            ),
          ),

          SizedBox(height: screenHeight * 0.05),

          // --- GRID ---
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: _emotions.length,
              itemBuilder: (context, index) {
                final item = _emotions[index];

                final intervalBegin = (index * 0.1).clamp(0.0, 0.9);
                final intervalEnd = (intervalBegin + 0.4).clamp(0.0, 1.0);

                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 2.0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: _gridController,
                    curve: Interval(intervalBegin, intervalEnd,
                        curve: Curves.elasticOut),
                  )),
                  child: FadeTransition(
                    opacity: _gridController,
                    child: _GameCard(
                      key: _cardKeys[index],
                      emoji: item['emoji']!,
                      name: item['name']!,
                      color: _cardColors[index % _cardColors.length],
                      fontSize: emojiFontSize,
                      onTap: (tapPosition) =>
                          _checkAnswer(item['name']!, index, tapPosition),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------
// WIDGET: Floating Background Bubbles
// --------------------------------------------
class _FloatingBubbles extends StatefulWidget {
  final Size screenSize;
  const _FloatingBubbles({required this.screenSize});

  @override
  State<_FloatingBubbles> createState() => _FloatingBubblesState();
}

class _FloatingBubblesState extends State<_FloatingBubbles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Bubble> _bubbles = [];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat();

    final randomGenerator = Random();
    for (int i = 0; i < 10; i++) {
      _bubbles.add(_Bubble(random: randomGenerator));
    }

    _controller.addListener(() {
      for (var bubble in _bubbles) {
        bubble.updatePosition(widget.screenSize);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          clipBehavior: Clip.none,
          children: _bubbles.map((bubble) {
            return Positioned(
              left: bubble.x,
              top: bubble.y,
              child: Container(
                width: bubble.size,
                height: bubble.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: bubble.color,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _Bubble {
  final Random random;
  double x;
  double y;
  double size;
  Color color;
  double speed;

  _Bubble({required this.random})
      : x = 0,
        y = 0,
        size = 20 + random.nextDouble() * 50,
        speed = 0.5 + random.nextDouble() * 1.5,
        color = [
          Colors.pink,
          Colors.blue,
          Colors.yellow,
          Colors.green,
          Colors.purple
        ][random.nextInt(5)]
            .withOpacity(0.1) {
    x = random.nextDouble();
    y = random.nextDouble();
  }

  void updatePosition(Size screenSize) {
    y -= speed;
    if (y < -size) {
      reset(screenSize);
    }
  }

  void reset(Size screenSize) {
    x = random.nextDouble() * screenSize.width;
    y = screenSize.height + size;
    size = 20 + random.nextDouble() * 50;
    color = [
      Colors.pink,
      Colors.blue,
      Colors.yellow,
      Colors.green,
      Colors.purple
    ][random.nextInt(5)]
        .withOpacity(0.1);
  }
}

// --------------------------------------------
// WIDGET: Confetti Piece
// --------------------------------------------
class _ConfettiPiece extends StatefulWidget {
  final Color color;
  final Offset startPosition;
  final Offset endOffset;
  final VoidCallback onComplete;

  const _ConfettiPiece({
    super.key,
    required this.color,
    required this.startPosition,
    required this.endOffset,
    required this.onComplete,
  });

  @override
  State<_ConfettiPiece> createState() => _ConfettiPieceState();
}

class _ConfettiPieceState extends State<_ConfettiPiece>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _controller.forward().then((_) => widget.onComplete());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final animationValue = Curves.easeOut.transform(_controller.value);
        return Positioned(
          left:
              widget.startPosition.dx + (widget.endOffset.dx * animationValue),
          top: widget.startPosition.dy + (widget.endOffset.dy * animationValue),
          child: Opacity(
            opacity: 1 - animationValue,
            child: Transform.rotate(
              angle: animationValue * 3.14 * 4,
              child: Container(width: 10, height: 10, color: widget.color),
            ),
          ),
        );
      },
    );
  }
}

// --------------------------------------------
// WIDGET: Game Card
// --------------------------------------------
class _GameCard extends StatefulWidget {
  final String emoji;
  final String name;
  final double fontSize;
  final Color color;
  final Function(Offset tapPosition) onTap;

  const _GameCard({
    super.key,
    required this.emoji,
    required this.name,
    required this.fontSize,
    required this.color,
    required this.onTap,
  });

  @override
  State<_GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<_GameCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void shake() {
    _shakeController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: 0.0), weight: 1),
    ]).animate(
        CurvedAnimation(parent: _shakeController, curve: Curves.easeInOut));

    return AnimatedBuilder(
      animation: _shakeController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(shakeAnimation.value, 0),
          child: child,
        );
      },
      child: GestureDetector(
        onTapDown: (details) {
          widget.onTap(details.globalPosition);
        },
        child: Container(
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child:
                Text(widget.emoji, style: TextStyle(fontSize: widget.fontSize)),
          ),
        ),
      ),
    );
  }
}
