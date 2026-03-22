import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';
import '../widgets/widgets.dart';

// ─────────────────────────────────────────────────────────────
//  DATA
// ─────────────────────────────────────────────────────────────
class _ColorItem {
  final String name;
  final Color color;
  final String emoji;
  const _ColorItem(this.name, this.color, this.emoji);
}

const List<_ColorItem> _kColors = [
  _ColorItem('Red', Colors.red, '🔴'),
  _ColorItem('Blue', Colors.blue, '🔵'),
  _ColorItem('Green', Colors.green, '🟢'),
  _ColorItem('Yellow', Colors.yellow, '🟡'),
  _ColorItem('Orange', Colors.orange, '🟠'),
  _ColorItem('Pink', Colors.pink, '🌸'),
  _ColorItem('Purple', Colors.purple, '🟣'),
  _ColorItem('Teal', Colors.teal, '💧'),
];

// ─────────────────────────────────────────────────────────────
//  ENTRY POINT — LEVEL SELECT
// ─────────────────────────────────────────────────────────────
class ColorMatchGame extends StatelessWidget {
  const ColorMatchGame({super.key});

  @override
  Widget build(BuildContext context) {
    return GradScaffold(
      child: Column(
        children: [
          const SarthiTopBar(title: 'Color Match', showBack: true),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  // Animated rainbow title
                  const _RainbowTitle(),
                  const SizedBox(height: 8),
                  const Text(
                    'Match the colours!\nGreat for focus, memory & fun 🎉',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15, color: SC.textMuted, height: 1.6),
                  ),
                  const SizedBox(height: 32),
                  // Level cards
                  _LevelCard(
                    level: 1,
                    label: 'Easy',
                    description: '4 colours · No timer · Perfect for beginners',
                    emoji: '🌈',
                    gradColors: [
                      const Color(0xFFB9FBC0),
                      const Color(0xFF98F5E1)
                    ],
                    onTap: () => _startGame(context, 1),
                  ),
                  const SizedBox(height: 16),
                  _LevelCard(
                    level: 2,
                    label: 'Medium',
                    description: '6 colours · 45 second timer',
                    emoji: '⚡',
                    gradColors: [
                      const Color(0xFFBDE0FE),
                      const Color(0xFFA2D2FF)
                    ],
                    onTap: () => _startGame(context, 2),
                  ),
                  const SizedBox(height: 16),
                  _LevelCard(
                    level: 3,
                    label: 'Hard',
                    description: '8 colours · 30 second timer · High score',
                    emoji: '🏆',
                    gradColors: [
                      const Color(0xFFFFD6FF),
                      const Color(0xFFE7C6FF)
                    ],
                    onTap: () => _startGame(context, 3),
                  ),
                  const SizedBox(height: 32),
                  // How to play
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: SC.border),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('How to Play',
                              style: TextStyle(
                                  fontFamily: 'PlayfairDisplay',
                                  fontSize: 17,
                                  color: SC.purpleDark)),
                          const SizedBox(height: 12),
                          _HowToRow(
                              '👆', 'A big coloured blob appears on screen'),
                          _HowToRow(
                              '🎨', 'Four coloured buttons appear below it'),
                          _HowToRow('✅',
                              'Tap the button that matches the blob colour'),
                          _HowToRow('⭐', 'Earn stars for every correct match!'),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startGame(BuildContext ctx, int level) {
    Navigator.push(
        ctx,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (_, a, __) =>
              FadeTransition(opacity: a, child: _GameScreen(level: level)),
        ));
  }
}

class _HowToRow extends StatelessWidget {
  final String emoji, text;
  const _HowToRow(this.emoji, this.text);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Expanded(
              child: Text(text,
                  style: const TextStyle(
                      fontSize: 14, color: SC.textDark, height: 1.4))),
        ]),
      );
}

class _LevelCard extends StatelessWidget {
  final int level;
  final String label, description, emoji;
  final List<Color> gradColors;
  final VoidCallback onTap;
  const _LevelCard(
      {required this.level,
      required this.label,
      required this.description,
      required this.emoji,
      required this.gradColors,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: gradColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
                color: gradColors[0].withOpacity(0.5),
                blurRadius: 14,
                offset: const Offset(0, 6))
          ],
        ),
        child: Row(children: [
          Text(emoji, style: const TextStyle(fontSize: 40)),
          const SizedBox(width: 16),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text('Level $level  ·  $label',
                    style: const TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: 18,
                        color: SC.purpleDark)),
                const SizedBox(height: 4),
                Text(description,
                    style: const TextStyle(fontSize: 13, color: SC.textMuted)),
              ])),
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6), shape: BoxShape.circle),
            child: const Icon(Icons.play_arrow_rounded,
                color: SC.purpleDark, size: 22),
          ),
        ]),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  GAME SCREEN
// ─────────────────────────────────────────────────────────────
enum _GameState { waiting, showing, result, finished }

class _GameScreen extends StatefulWidget {
  final int level;
  const _GameScreen({required this.level});

  @override
  State<_GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<_GameScreen>
    with TickerProviderStateMixin {
  // Config per level
  int get _colorCount => widget.level == 1
      ? 4
      : widget.level == 2
          ? 6
          : 8;
  int get _timerSeconds => widget.level == 1
      ? 0
      : widget.level == 2
          ? 45
          : 30;
  int get _totalRounds => 10;

  // State
  _GameState _state = _GameState.waiting;
  int _round = 0;
  int _score = 0;
  int _streak = 0;
  int _bestStreak = 0;
  int _timeLeft = 0;
  bool? _lastCorrect;
  _ColorItem? _target;
  List<_ColorItem> _choices = [];
  Timer? _timer;

  // Animations
  late AnimationController _blobCtrl;
  late AnimationController _bounceCtrl;
  late AnimationController _shakeCtrl;
  late AnimationController _celebCtrl;
  late AnimationController _pulseCtrl;
  late Animation<double> _blobScale;
  late Animation<double> _bounceScale;
  late Animation<Offset> _shakeOffset;
  late Animation<double> _celebScale;
  late Animation<double> _pulseOpacity;

  final _rng = Random();
  List<_ColorItem> _usedColors = [];

  @override
  void initState() {
    super.initState();

    _blobCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _blobScale = CurvedAnimation(parent: _blobCtrl, curve: Curves.elasticOut);

    _bounceCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _bounceScale = Tween<double>(begin: 1.0, end: 1.18).animate(
      CurvedAnimation(parent: _bounceCtrl, curve: Curves.easeOutBack),
    );

    _shakeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _shakeOffset =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0.04, 0)).animate(
      CurvedAnimation(parent: _shakeCtrl, curve: Curves.elasticIn),
    );

    _celebCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _celebScale = CurvedAnimation(parent: _celebCtrl, curve: Curves.elasticOut);

    _pulseCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat(reverse: true);
    _pulseOpacity = Tween<double>(begin: 0.5, end: 1.0).animate(_pulseCtrl);

    _timeLeft = _timerSeconds;
    _nextRound();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _blobCtrl.dispose();
    _bounceCtrl.dispose();
    _shakeCtrl.dispose();
    _celebCtrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  void _nextRound() {
    if (_round >= _totalRounds) {
      _endGame();
      return;
    }

    // Pick target not used recently
    _ColorItem target;
    do {
      target = _kColors[_rng.nextInt(_colorCount)];
    } while (_usedColors.contains(target) && _usedColors.length < _colorCount);
    _usedColors.add(target);
    if (_usedColors.length > 3) _usedColors.removeAt(0);

    // Build choices (target + 3 distractors), shuffled
    final pool = List<_ColorItem>.from(_kColors.take(_colorCount))
      ..remove(target);
    pool.shuffle(_rng);
    final choices = [target, ...pool.take(3)]..shuffle(_rng);

    setState(() {
      _target = target;
      _choices = choices;
      _state = _GameState.showing;
      _round++;
      _lastCorrect = null;
    });

    _blobCtrl.forward(from: 0);
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    if (_timerSeconds == 0) return;
    _timeLeft = _timerSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() => _timeLeft--);
      if (_timeLeft <= 0) {
        t.cancel();
        _onTimeout();
      }
    });
  }

  void _onTimeout() {
    _timer?.cancel();
    setState(() {
      _streak = 0;
      _state = _GameState.finished;
    });
    _shakeCtrl.forward(from: 0).then((_) => _shakeCtrl.reverse());
    HapticFeedback.heavyImpact();
    Future.delayed(const Duration(milliseconds: 800), _endGame);
  }

  void _onTap(_ColorItem choice) {
    if (_state != _GameState.showing) return;
    _timer?.cancel();
    _pulseCtrl.stop();

    final correct = choice.name == _target!.name;
    HapticFeedback.lightImpact();

    if (correct) {
      _streak++;
      if (_streak > _bestStreak) _bestStreak = _streak;
      _score += 10 + (_streak > 1 ? (_streak - 1) * 5 : 0); // streak bonus
      _bounceCtrl.forward(from: 0).then((_) => _bounceCtrl.reverse());
      _celebCtrl.forward(from: 0);
    } else {
      _streak = 0;
      _shakeCtrl.forward(from: 0).then((_) => _shakeCtrl.reverse());
    }

    setState(() {
      _lastCorrect = correct;
      _state = _GameState.result;
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      _pulseCtrl.repeat(reverse: true);
      _nextRound();
    });
  }

  void _endGame() {
    if (!mounted) return;
    setState(() => _state = _GameState.finished);
    _timer?.cancel();
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, a, __) => FadeTransition(
            opacity: a,
            child: _ResultScreen(
                score: _score,
                bestStreak: _bestStreak,
                rounds: _round,
                level: widget.level),
          ),
        ));
  }

  String get _streakLabel {
    if (_streak >= 5) return '🔥 ${_streak}x Streak!';
    if (_streak >= 3) return '⚡ ${_streak}x Streak!';
    if (_streak >= 2) return '✨ ${_streak}x Combo!';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    if (_target == null) return const SizedBox.shrink();
    final t = _target!;

    return GradScaffold(
      child: Column(
        children: [
          // ── Top HUD ─────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 52, 20, 0),
            child: Row(children: [
              GestureDetector(
                onTap: () {
                  _timer?.cancel();
                  Navigator.pop(context);
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.close_rounded,
                      color: SC.purpleDark, size: 20),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Round $_round / $_totalRounds',
                          style: const TextStyle(
                              fontSize: 12,
                              color: SC.textMuted,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: _round / _totalRounds,
                          backgroundColor: SC.border,
                          valueColor: AlwaysStoppedAnimation<Color>(t.color),
                          minHeight: 7,
                        ),
                      ),
                    ]),
              ),
              const SizedBox(width: 12),
              // Score
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: SC.border),
                ),
                child: Row(children: [
                  const Text('⭐', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 4),
                  Text('$_score',
                      style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: SC.purpleDark)),
                ]),
              ),
            ]),
          ),

          // ── Timer bar ────────────────────────────────────────
          if (_timerSeconds > 0) ...[
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [
                FadeTransition(
                  opacity: _timeLeft <= 10
                      ? _pulseOpacity
                      : const AlwaysStoppedAnimation(1.0),
                  child: Text(
                    '⏱ ${_timeLeft}s',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: _timeLeft <= 10 ? SC.red : SC.textMuted,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: _timeLeft / _timerSeconds,
                      backgroundColor: SC.border,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          _timeLeft <= 10 ? SC.red : SC.green),
                      minHeight: 7,
                    ),
                  ),
                ),
              ]),
            ),
          ],

          // ── Streak label ─────────────────────────────────────
          SizedBox(
            height: 32,
            child: Center(
              child: AnimatedOpacity(
                opacity: _streakLabel.isNotEmpty ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Text(_streakLabel,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: SC.amber)),
              ),
            ),
          ),

          // ── BIG COLOUR BLOB ───────────────────────────────────
          Expanded(
            flex: 5,
            child: Center(
              child: SlideTransition(
                position: _shakeOffset,
                child: ScaleTransition(
                  scale: _state == _GameState.result && _lastCorrect == true
                      ? _bounceScale
                      : _blobScale,
                  child: Stack(alignment: Alignment.center, children: [
                    // Outer glow ring
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: t.color.withOpacity(0.18),
                        boxShadow: [
                          BoxShadow(
                              color: t.color.withOpacity(0.35),
                              blurRadius: 40,
                              spreadRadius: 10),
                        ],
                      ),
                    ),
                    // Main blob
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: t.color,
                        boxShadow: [
                          BoxShadow(
                              color: t.color.withOpacity(0.5),
                              blurRadius: 24,
                              offset: const Offset(0, 8))
                        ],
                      ),
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(t.emoji,
                                  style: const TextStyle(fontSize: 52)),
                              if (_state == _GameState.result) ...[
                                const SizedBox(height: 4),
                              ],
                            ]),
                      ),
                    ),
                    // Confetti burst on correct
                    if (_state == _GameState.result && _lastCorrect == true)
                      ScaleTransition(
                          scale: _celebScale, child: const _ConfsettiBurst()),
                  ]),
                ),
              ),
            ),
          ),

          // ── Instruction ───────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: AnimatedOpacity(
              opacity: _state == _GameState.result ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: Text(
                'Tap the ${t.name} button! ${t.emoji}',
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: SC.purpleDark),
              ),
            ),
          ),

          // ── CHOICE BUTTONS ────────────────────────────────────
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 2.8,
                physics: const NeverScrollableScrollPhysics(),
                children: _choices
                    .map((c) => _ChoiceButton(
                          item: c,
                          state: _state,
                          isTarget: c.name == _target!.name,
                          onTap: () => _onTap(c),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  CHOICE BUTTON
// ─────────────────────────────────────────────────────────────
class _ChoiceButton extends StatefulWidget {
  final _ColorItem item;
  final _GameState state;
  final bool isTarget;
  final VoidCallback onTap;
  const _ChoiceButton(
      {required this.item,
      required this.state,
      required this.isTarget,
      required this.onTap});

  @override
  State<_ChoiceButton> createState() => _ChoiceButtonState();
}

class _ChoiceButtonState extends State<_ChoiceButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressCtrl;
  late Animation<double> _pressScale;

  @override
  void initState() {
    super.initState();
    _pressCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 120));
    _pressScale = Tween<double>(begin: 1.0, end: 0.92)
        .animate(CurvedAnimation(parent: _pressCtrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _pressCtrl.dispose();
    super.dispose();
  }

  Color get _overlayColor {
    if (widget.state != _GameState.result) return Colors.transparent;
    if (widget.isTarget) return Colors.white.withOpacity(0.25);
    return Colors.black.withOpacity(0.35);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _pressCtrl.forward(),
      onTapUp: (_) {
        _pressCtrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _pressCtrl.reverse(),
      child: ScaleTransition(
        scale: _pressScale,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: widget.item.color,
            border: widget.state == _GameState.result && widget.isTarget
                ? Border.all(color: Colors.white, width: 3)
                : null,
            boxShadow: [
              BoxShadow(
                color: widget.item.color.withOpacity(
                    widget.state == _GameState.result && !widget.isTarget
                        ? 0.15
                        : 0.5),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Dim overlay for wrong answers
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: _overlayColor,
                ),
              ),
              // Label
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.item.emoji,
                        style: const TextStyle(fontSize: 22)),
                    const SizedBox(width: 8),
                    Text(
                      widget.item.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2))
                        ],
                      ),
                    ),
                    if (widget.state == _GameState.result &&
                        widget.isTarget) ...[
                      const SizedBox(width: 6),
                      const Text('✓',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w900)),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  CONFETTI BURST (pure canvas, no packages)
// ─────────────────────────────────────────────────────────────
class _ConfsettiBurst extends StatelessWidget {
  const _ConfsettiBurst();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 240,
      child: CustomPaint(painter: _ConfettiPainter()),
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  final _colors = const [
    Color(0xFFFF5252),
    Color(0xFF448AFF),
    Color(0xFF69F0AE),
    Color(0xFFFFD740),
    Color(0xFFFF4081),
    Color(0xFFCE93D8),
    Color(0xFFFF6D00),
    Color(0xFF1DE9B6),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final rng = Random(42);
    final cx = size.width / 2;
    final cy = size.height / 2;
    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < 28; i++) {
      final angle = (i / 28) * pi * 2;
      final dist = 60 + rng.nextDouble() * 55;
      final x = cx + cos(angle) * dist;
      final y = cy + sin(angle) * dist;
      final w = 8 + rng.nextDouble() * 8;
      final h = 5 + rng.nextDouble() * 5;
      paint.color = _colors[i % _colors.length].withOpacity(0.85);
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(angle + pi / 4);
      canvas.drawRRect(
          RRect.fromRectAndRadius(
              Rect.fromCenter(center: Offset.zero, width: w, height: h),
              const Radius.circular(3)),
          paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

// ─────────────────────────────────────────────────────────────
//  RESULT SCREEN
// ─────────────────────────────────────────────────────────────
class _ResultScreen extends StatefulWidget {
  final int score, bestStreak, rounds, level;
  const _ResultScreen(
      {required this.score,
      required this.bestStreak,
      required this.rounds,
      required this.level});

  @override
  State<_ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<_ResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();
    HapticFeedback.mediumImpact();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  int get _stars {
    if (widget.score >= 80) return 3;
    if (widget.score >= 50) return 2;
    return 1;
  }

  String get _message {
    if (_stars == 3) return 'Amazing! You\'re a colour star! 🌟';
    if (_stars == 2) return 'Great job! Keep practising! 💪';
    return 'Good try! Let\'s play again! 😊';
  }

  @override
  Widget build(BuildContext context) {
    return GradScaffold(
      child: FadeTransition(
        opacity: _fade,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 40),
            child: Column(
              children: [
                // Trophy / star
                ScaleTransition(
                  scale: _scale,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFD740), Color(0xFFFF9100)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xFFFFD740).withOpacity(0.6),
                            blurRadius: 36,
                            spreadRadius: 6)
                      ],
                    ),
                    child: Center(
                        child: Text(
                            _stars == 3
                                ? '🏆'
                                : _stars == 2
                                    ? '🌟'
                                    : '👏',
                            style: const TextStyle(fontSize: 64))),
                  ),
                ),
                const SizedBox(height: 24),

                Text('Colour Match',
                    style: const TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: 16,
                        color: SC.textMuted)),
                const SizedBox(height: 6),
                Text('Level ${widget.level} Complete!',
                    style: const TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: 28,
                        color: SC.purpleDark)),
                const SizedBox(height: 12),
                Text(_message,
                    style: const TextStyle(
                        fontSize: 16, color: SC.textDark, height: 1.5),
                    textAlign: TextAlign.center),
                const SizedBox(height: 10),

                // Stars row
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (i) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: Text(i < _stars ? '⭐' : '☆',
                                  style: TextStyle(
                                      fontSize: 36,
                                      color: i < _stars
                                          ? const Color(0xFFFFD740)
                                          : SC.border)),
                            ))),
                const SizedBox(height: 32),

                // Stats row
                Row(children: [
                  _StatBox(
                      emoji: '⭐',
                      label: 'Score',
                      value: '${widget.score}',
                      color: const Color(0xFFFFD740)),
                  const SizedBox(width: 12),
                  _StatBox(
                      emoji: '🔥',
                      label: 'Best Streak',
                      value: '${widget.bestStreak}x',
                      color: SC.red),
                  const SizedBox(width: 12),
                  _StatBox(
                      emoji: '🎯',
                      label: 'Rounds',
                      value: '${widget.rounds}',
                      color: SC.skyDark),
                ]),
                const SizedBox(height: 32),

                // Buttons
                SarthiButton(
                  label: '🔄  Play Again',
                  color: SC.purple,
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 400),
                        pageBuilder: (_, a, __) => FadeTransition(
                            opacity: a,
                            child: _GameScreen(level: widget.level)),
                      )),
                ),
                const SizedBox(height: 12),
                SarthiButton(
                  label: '🎮  Change Level',
                  outline: true,
                  color: SC.purple,
                  onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 400),
                      pageBuilder: (_, a, __) => FadeTransition(
                          opacity: a, child: const ColorMatchGame()),
                    ),
                    (r) => r.isFirst,
                  ),
                ),
                const SizedBox(height: 12),
                SarthiButton(
                  label: '← Back to Games',
                  outline: true,
                  color: SC.textMuted,
                  onPressed: () =>
                      Navigator.popUntil(context, (r) => r.isFirst),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String emoji, label, value;
  final Color color;
  const _StatBox(
      {required this.emoji,
      required this.label,
      required this.value,
      required this.color});

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.09),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: color.withOpacity(0.25)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 6),
              Text(value,
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w900, color: color)),
              const SizedBox(height: 2),
              Text(label,
                  style: const TextStyle(
                      fontSize: 11,
                      color: SC.textMuted,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      );
}

// ─────────────────────────────────────────────────────────────
//  RAINBOW ANIMATED TITLE
// ─────────────────────────────────────────────────────────────
class _RainbowTitle extends StatefulWidget {
  const _RainbowTitle();
  @override
  State<_RainbowTitle> createState() => _RainbowTitleState();
}

class _RainbowTitleState extends State<_RainbowTitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        const letters = 'Colour Match 🎨';
        final colors = [
          const Color(0xFFFF5252),
          const Color(0xFFFF9100),
          const Color(0xFFFFD740),
          const Color(0xFF69F0AE),
          const Color(0xFF448AFF),
          const Color(0xFFCE93D8),
          const Color(0xFFFF4081),
        ];
        return Wrap(
          alignment: WrapAlignment.center,
          children: List.generate(letters.length, (i) {
            final phase = (_ctrl.value + i / letters.length) % 1.0;
            final ci =
                (phase * colors.length).floor().clamp(0, colors.length - 1);
            return Text(
              letters[i],
              style: TextStyle(
                fontFamily: 'PlayfairDisplay',
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: colors[ci],
                shadows: [
                  Shadow(
                      color: colors[ci].withOpacity(0.4),
                      blurRadius: 6,
                      offset: const Offset(0, 2))
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
