import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';
import '../widgets/widgets.dart';

class _CardPair {
  final String emoji;
  final String label;
  final Color color;
  const _CardPair(this.emoji, this.label, this.color);
}

const List<_CardPair> _kPairs = [
  _CardPair('🐶', 'Dog', Color(0xFFFF8C38)),
  _CardPair('🐱', 'Cat', Color(0xFFFF71B8)),
  _CardPair('🐸', 'Frog', Color(0xFF3CD98F)),
  _CardPair('🦋', 'Butterfly', Color(0xFFAA66FF)),
  _CardPair('🌟', 'Star', Color(0xFFFFD22E)),
  _CardPair('🍎', 'Apple', Color(0xFFFF4E6A)),
  _CardPair('🚀', 'Rocket', Color(0xFF4E90FF)),
  _CardPair('🌈', 'Rainbow', Color(0xFF38D9D9)),
  _CardPair('🦁', 'Lion', Color(0xFFFF9F40)),
  _CardPair('🐧', 'Penguin', Color(0xFF7C83FD)),
  _CardPair('🌸', 'Flower', Color(0xFFFF71B8)),
  _CardPair('🍦', 'Ice Cream', Color(0xFFFFD22E)),
];

class _LevelConfig {
  final String label, emoji, description;
  final int pairs, cols;
  final int? timeSec;
  final List<Color> grad;
  const _LevelConfig({
    required this.label,
    required this.emoji,
    required this.description,
    required this.pairs,
    required this.cols,
    this.timeSec,
    required this.grad,
  });
}

const _kLevels = [
  _LevelConfig(
      label: 'Easy',
      emoji: '🌱',
      description: '6 pairs · No timer',
      pairs: 6,
      cols: 3,
      timeSec: null,
      grad: [Color(0xFF98F5E1), Color(0xFF3CD98F)]),
  _LevelConfig(
      label: 'Medium',
      emoji: '⚡',
      description: '8 pairs · 90 sec timer',
      pairs: 8,
      cols: 4,
      timeSec: 90,
      grad: [Color(0xFFBDE0FE), Color(0xFF4E90FF)]),
  _LevelConfig(
      label: 'Hard',
      emoji: '🔥',
      description: '12 pairs · 120 sec timer',
      pairs: 12,
      cols: 4,
      timeSec: 120,
      grad: [Color(0xFFFFD6FF), Color(0xFFAA66FF)]),
];

class MemoryCardGame extends StatefulWidget {
  const MemoryCardGame({super.key});
  @override
  State<MemoryCardGame> createState() => _MemoryCardGameState();
}

class _MemoryCardGameState extends State<MemoryCardGame>
    with TickerProviderStateMixin {
  late final AnimationController _floatCtrl;
  late final AnimationController _titleCtrl;

  @override
  void initState() {
    super.initState();
    _floatCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat(reverse: true);
    _titleCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800))
      ..forward();
  }

  @override
  void dispose() {
    _floatCtrl.dispose();
    _titleCtrl.dispose();
    super.dispose();
  }

  void _startGame(int levelIdx) {
    Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 450),
          pageBuilder: (_, a, __) => FadeTransition(
            opacity: CurvedAnimation(parent: a, curve: Curves.easeOut),
            child: _GameScreen(level: _kLevels[levelIdx]),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GradScaffold(
      child: Column(
        children: [
          const SarthiTopBar(title: 'Memory Cards', showBack: true),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: _floatCtrl,
                    builder: (_, __) => SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: ['🐶', '🌟', '🚀', '🐸', '🦋', '🍎']
                            .asMap()
                            .entries
                            .map((e) {
                          final wave =
                              sin((_floatCtrl.value + e.key * 0.2) * pi) * 10;
                          return Transform.translate(
                            offset: Offset(0, wave),
                            child: Text(e.value,
                                style: const TextStyle(fontSize: 32)),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  FadeTransition(
                    opacity: _titleCtrl,
                    child: const Column(
                      children: [
                        Text('🧠', style: TextStyle(fontSize: 56)),
                        SizedBox(height: 8),
                        Text(
                          'Memory Cards',
                          style: TextStyle(
                              fontFamily: 'PlayfairDisplay',
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: SC.purpleDark),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Find all matching pairs!\nGreat for memory & focus 🌟',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, color: SC.textMuted, height: 1.6),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  ..._kLevels.asMap().entries.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: _LevelButton(
                            config: e.value, onTap: () => _startGame(e.key)),
                      )),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: SC.border),
                      boxShadow: [
                        BoxShadow(
                            color: SC.purple.withOpacity(0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 3))
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('How to Play',
                            style: TextStyle(
                                fontFamily: 'PlayfairDisplay',
                                fontSize: 18,
                                color: SC.purpleDark)),
                        const SizedBox(height: 14),
                        _HowToRow('👆', 'Tap any card to flip it over'),
                        _HowToRow('🔍', 'Remember where each emoji lives'),
                        _HowToRow('✅', 'Flip two matching cards to win them'),
                        _HowToRow(
                            '🏆', 'Match all pairs to complete the game!'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HowToRow extends StatelessWidget {
  final String emoji, text;
  const _HowToRow(this.emoji, this.text);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
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

class _LevelButton extends StatefulWidget {
  final _LevelConfig config;
  final VoidCallback onTap;
  const _LevelButton({required this.config, required this.onTap});
  @override
  State<_LevelButton> createState() => _LevelButtonState();
}

class _LevelButtonState extends State<_LevelButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 110));
    _scale = Tween(begin: 1.0, end: 0.95)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.config;
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: c.grad,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                  color: c.grad[1].withOpacity(0.4),
                  blurRadius: 14,
                  offset: const Offset(0, 5))
            ],
          ),
          child: Row(children: [
            Text(c.emoji, style: const TextStyle(fontSize: 38)),
            const SizedBox(width: 16),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(c.label,
                    style: const TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: 20,
                        color: SC.purpleDark,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 3),
                Text(c.description,
                    style: const TextStyle(
                        fontSize: 13,
                        color: SC.textMuted,
                        fontWeight: FontWeight.w600)),
              ],
            )),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.55),
                  shape: BoxShape.circle),
              child: const Icon(Icons.play_arrow_rounded,
                  color: SC.purpleDark, size: 24),
            ),
          ]),
        ),
      ),
    );
  }
}

class _Card {
  final int id;
  final _CardPair pair;
  final bool isFlipped;
  final bool isMatched;
  const _Card(
      {required this.id,
      required this.pair,
      this.isFlipped = false,
      this.isMatched = false});

  _Card copyWith({bool? isFlipped, bool? isMatched}) => _Card(
        id: id,
        pair: pair,
        isFlipped: isFlipped ?? this.isFlipped,
        isMatched: isMatched ?? this.isMatched,
      );
}

class _GameScreen extends StatefulWidget {
  final _LevelConfig level;
  const _GameScreen({required this.level});
  @override
  State<_GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<_GameScreen>
    with TickerProviderStateMixin {
  late List<_Card> _cards;
  int? _firstIdx, _secondIdx;
  bool _isChecking = false;
  int _moves = 0;
  int _matches = 0;
  int _timeLeft = 0;
  bool _gameOver = false;
  bool _won = false;
  Timer? _timer;
  int _score = 0;
  final _rng = Random();
  final List<_Particle> _particles = [];
  late final AnimationController _winCtrl;

  @override
  void initState() {
    super.initState();
    _winCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _timeLeft = widget.level.timeSec ?? 0;
    _buildCards();
    if (widget.level.timeSec != null) _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _winCtrl.dispose();
    super.dispose();
  }

  void _buildCards() {
    final pairs =
        (_kPairs.toList()..shuffle(_rng)).take(widget.level.pairs).toList();
    final list = <_Card>[];
    for (int i = 0; i < pairs.length; i++) {
      list.add(_Card(id: i * 2, pair: pairs[i]));
      list.add(_Card(id: i * 2 + 1, pair: pairs[i]));
    }
    list.shuffle(_rng);
    setState(() => _cards = list);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _timeLeft--);
      if (_timeLeft <= 0) {
        _timer?.cancel();
        if (!_won) _endGame(won: false);
      }
    });
  }

  void _onTap(int idx) {
    if (_isChecking) return;
    if (_cards[idx].isFlipped || _cards[idx].isMatched) return;
    HapticFeedback.lightImpact();
    setState(() => _cards[idx] = _cards[idx].copyWith(isFlipped: true));
    if (_firstIdx == null) {
      _firstIdx = idx;
    } else {
      _secondIdx = idx;
      _moves++;
      _isChecking = true;
      Future.delayed(const Duration(milliseconds: 900), _checkMatch);
    }
  }

  void _checkMatch() {
    if (!mounted) return;
    final fi = _firstIdx!;
    final si = _secondIdx!;
    final a = _cards[fi];
    final b = _cards[si];
    _firstIdx = null;
    _secondIdx = null;

    if (a.pair.emoji == b.pair.emoji) {
      HapticFeedback.mediumImpact();
      setState(() {
        _cards[fi] = _cards[fi].copyWith(isMatched: true);
        _cards[si] = _cards[si].copyWith(isMatched: true);
        _matches++;
        _score += max(10, 30 - _moves);
        _isChecking = false;
      });
      _spawnParticles(a.pair.color);
      if (_matches == widget.level.pairs) {
        Future.delayed(
            const Duration(milliseconds: 400), () => _endGame(won: true));
      }
    } else {
      HapticFeedback.heavyImpact();
      Future.delayed(const Duration(milliseconds: 600), () {
        if (!mounted) return;
        setState(() {
          _cards[fi] = _cards[fi].copyWith(isFlipped: false);
          _cards[si] = _cards[si].copyWith(isFlipped: false);
          _isChecking = false;
        });
      });
    }
  }

  void _endGame({required bool won}) {
    _timer?.cancel();
    setState(() {
      _gameOver = true;
      _won = won;
    });
    if (won) {
      _score += (_timeLeft * 2);
      _winCtrl.forward();
      _spawnParticles(const Color(0xFFFFD22E), count: 40);
    }
  }

  void _spawnParticles(Color color, {int count = 14}) {
    setState(() {
      for (int i = 0; i < count; i++) {
        _particles.add(_Particle(
          x: 0.2 + _rng.nextDouble() * 0.6,
          y: 0.2 + _rng.nextDouble() * 0.5,
          color: Color.lerp(color, Colors.white, _rng.nextDouble() * 0.35)!,
          size: 7 + _rng.nextDouble() * 13,
          vx: (_rng.nextDouble() - 0.5) * 5,
          vy: (_rng.nextDouble() - 0.5) * 5 - 2.5,
        ));
      }
    });
    Timer.periodic(const Duration(milliseconds: 40), (t) {
      if (!mounted || t.tick > 35) {
        t.cancel();
        return;
      }
      setState(() {
        for (final p in _particles) {
          p.x += p.vx * 0.018;
          p.y += p.vy * 0.018;
          p.vy += 0.18;
          p.opacity -= 0.025;
        }
        _particles.removeWhere((p) => p.opacity <= 0);
      });
    });
  }

  void _restart() {
    _timer?.cancel();
    _winCtrl.reset();
    setState(() {
      _moves = 0;
      _matches = 0;
      _timeLeft = widget.level.timeSec ?? 0;
      _gameOver = false;
      _won = false;
      _score = 0;
      _firstIdx = null;
      _secondIdx = null;
      _isChecking = false;
      _particles.clear();
    });
    _buildCards();
    if (widget.level.timeSec != null) _startTimer();
  }

  Color get _timerColor {
    if (_timeLeft > 30) return SC.green;
    if (_timeLeft > 10) return SC.amber;
    return SC.red;
  }

  @override
  Widget build(BuildContext context) {
    return GradScaffold(
      child: Stack(
        children: [
          if (_particles.isNotEmpty)
            IgnorePointer(
              child: LayoutBuilder(
                  builder: (ctx, c) => Stack(
                        children: _particles
                            .map((p) => Positioned(
                                  left: p.x * c.maxWidth - p.size / 2,
                                  top: p.y * c.maxHeight - p.size / 2,
                                  child: Opacity(
                                    opacity: p.opacity.clamp(0.0, 1.0),
                                    child: Container(
                                      width: p.size,
                                      height: p.size,
                                      decoration: BoxDecoration(
                                          color: p.color,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                                color: p.color.withOpacity(0.5),
                                                blurRadius: 5)
                                          ]),
                                    ),
                                  ),
                                ))
                            .toList(),
                      )),
            ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 48, 16, 0),
                child: Row(children: [
                  GestureDetector(
                    onTap: () {
                      _timer?.cancel();
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: SC.border)),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 18, color: SC.purpleDark),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _StatPill(
                              icon: '🎯',
                              value: '$_matches/${widget.level.pairs}',
                              label: 'Pairs'),
                          _StatPill(
                              icon: '👆', value: '$_moves', label: 'Moves'),
                          _StatPill(
                              icon: '⭐', value: '$_score', label: 'Score'),
                        ]),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: _restart,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: SC.border)),
                      child: const Icon(Icons.refresh_rounded,
                          color: SC.purpleDark, size: 22),
                    ),
                  ),
                ]),
              ),
              if (widget.level.timeSec != null) ...[
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(children: [
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        fontSize: _timeLeft <= 10 ? 20 : 16,
                        fontWeight: FontWeight.w900,
                        color: _timerColor,
                      ),
                      child: Text('⏱ ${_timeLeft}s'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: _timeLeft / widget.level.timeSec!,
                          minHeight: 9,
                          backgroundColor: Colors.white.withOpacity(0.4),
                          valueColor: AlwaysStoppedAnimation(_timerColor),
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
              const SizedBox(height: 12),
              Text(
                '${widget.level.emoji} ${widget.level.label} — ${widget.level.pairs} pairs',
                style: const TextStyle(
                    fontSize: 13,
                    color: SC.textMuted,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.level.cols,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: widget.level.pairs == 12 ? 0.85 : 0.9,
                    ),
                    itemCount: _cards.length,
                    itemBuilder: (_, i) => _MemoryCard(
                      key: ValueKey(_cards[i].id),
                      card: _cards[i],
                      onTap: () => _onTap(i),
                      isSelected: _firstIdx == i || _secondIdx == i,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
            ],
          ),
          if (_gameOver)
            _ResultOverlay(
              won: _won,
              score: _score,
              moves: _moves,
              matches: _matches,
              total: widget.level.pairs,
              onRestart: _restart,
              onHome: () => Navigator.pop(context),
            ),
        ],
      ),
    );
  }
}

class _MemoryCard extends StatefulWidget {
  final _Card card;
  final VoidCallback onTap;
  final bool isSelected;
  const _MemoryCard(
      {super.key,
      required this.card,
      required this.onTap,
      required this.isSelected});
  @override
  State<_MemoryCard> createState() => _MemoryCardState();
}

class _MemoryCardState extends State<_MemoryCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _anim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic),
    );
    if (widget.card.isFlipped || widget.card.isMatched) {
      _ctrl.value = 1.0;
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(_MemoryCard old) {
    super.didUpdateWidget(old);
    final shouldShow = widget.card.isFlipped || widget.card.isMatched;
    if (shouldShow &&
        _ctrl.status != AnimationStatus.forward &&
        _ctrl.status != AnimationStatus.completed) {
      _ctrl.forward();
    } else if (!shouldShow &&
        _ctrl.status != AnimationStatus.reverse &&
        _ctrl.status != AnimationStatus.dismissed) {
      _ctrl.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _anim,
        builder: (_, __) {
          final angle = _anim.value * pi;
          final showFront = angle > pi / 2;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(showFront ? angle - pi : angle),
            child:
                showFront ? _CardFront(card: widget.card) : const _CardBack(),
          );
        },
      ),
    );
  }
}

class _CardBack extends StatelessWidget {
  const _CardBack();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFD9B8FF), Color(0xFF8B5BA6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF8B5BA6).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4))
        ],
      ),
      child: Stack(children: [
        ...List.generate(
            6,
            (i) => Positioned(
                  left: (i % 3) * 28.0 + 8,
                  top: (i ~/ 3) * 28.0 + 8,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle),
                  ),
                )),
        const Center(child: Text('❓', style: TextStyle(fontSize: 30))),
      ]),
    );
  }
}

class _CardFront extends StatefulWidget {
  final _Card card;
  const _CardFront({required this.card});
  @override
  State<_CardFront> createState() => _CardFrontState();
}

class _CardFrontState extends State<_CardFront>
    with SingleTickerProviderStateMixin {
  late final AnimationController _matchCtrl;
  late final Animation<double> _matchScale;

  @override
  void initState() {
    super.initState();
    _matchCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _matchScale = Tween(begin: 1.0, end: 1.12)
        .animate(CurvedAnimation(parent: _matchCtrl, curve: Curves.elasticOut));
    if (widget.card.isMatched) _matchCtrl.forward();
  }

  @override
  void didUpdateWidget(_CardFront old) {
    super.didUpdateWidget(old);
    if (widget.card.isMatched && !old.card.isMatched) _matchCtrl.forward();
  }

  @override
  void dispose() {
    _matchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.card.pair;
    return ScaleTransition(
      scale: _matchScale,
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Color.lerp(c.color, Colors.white, 0.3)!, c.color],
            center: const Alignment(-0.3, -0.4),
            radius: 1.3,
          ),
          borderRadius: BorderRadius.circular(16),
          border: widget.card.isMatched
              ? Border.all(color: Colors.white, width: 2.5)
              : null,
          boxShadow: [
            BoxShadow(
                color: c.color.withOpacity(0.45),
                blurRadius: 10,
                offset: const Offset(0, 4)),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 6,
              left: 6,
              child: Container(
                width: 28,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(c.emoji, style: const TextStyle(fontSize: 32)),
                  const SizedBox(height: 3),
                  Text(
                    c.label,
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        shadows: [
                          Shadow(color: Colors.black26, blurRadius: 3)
                        ]),
                  ),
                ],
              ),
            ),
            if (widget.card.isMatched)
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(Icons.check_rounded,
                      size: 12, color: Color(0xFF3CD98F)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  final String icon, value, label;
  const _StatPill(
      {required this.icon, required this.value, required this.label});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: SC.border),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(icon, style: const TextStyle(fontSize: 13)),
                const SizedBox(width: 4),
                Text(value,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: SC.purpleDark)),
              ],
            ),
            Text(label,
                style: const TextStyle(
                    fontSize: 9,
                    color: SC.textMuted,
                    fontWeight: FontWeight.w700)),
          ],
        ),
      );
}

class _ResultOverlay extends StatefulWidget {
  final bool won;
  final int score, moves, matches, total;
  final VoidCallback onRestart, onHome;
  const _ResultOverlay(
      {required this.won,
      required this.score,
      required this.moves,
      required this.matches,
      required this.total,
      required this.onRestart,
      required this.onHome});
  @override
  State<_ResultOverlay> createState() => _ResultOverlayState();
}

class _ResultOverlayState extends State<_ResultOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _ctrl.forward();
    HapticFeedback.mediumImpact();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  String get _title => widget.won
      ? (widget.moves <= widget.total + 2 ? '🏆 Perfect!' : '🎉 You Won!')
      : '⏰ Time\'s Up!';
  String get _msg => widget.won
      ? (widget.moves <= widget.total + 2
          ? 'Amazing memory! You\'re a star! 🌟'
          : 'Great job! All pairs matched! 🥳')
      : 'Almost! Try again, you can do it! 💪';

  int get _stars {
    if (!widget.won) return 0;
    if (widget.moves <= widget.total + 2) return 3;
    if (widget.moves <= widget.total * 2) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: Container(
        color: Colors.black.withOpacity(0.55),
        child: Center(
          child: ScaleTransition(
            scale: _scale,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.won
                      ? [const Color(0xFFFFFDE7), const Color(0xFFF3EEFF)]
                      : [const Color(0xFFFFEBEE), const Color(0xFFF3EEFF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: (widget.won ? const Color(0xFFFFD22E) : SC.red)
                        .withOpacity(0.3),
                    blurRadius: 32,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.won ? '🏆' : '😢',
                      style: const TextStyle(fontSize: 68)),
                  const SizedBox(height: 6),
                  if (_stars > 0) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          3,
                          (i) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  i < _stars ? '⭐' : '☆',
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: i < _stars
                                          ? const Color(0xFFFFD22E)
                                          : SC.border),
                                ),
                              )),
                    ),
                    const SizedBox(height: 8),
                  ],
                  Text(_title,
                      style: const TextStyle(
                          fontFamily: 'PlayfairDisplay',
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: SC.purpleDark)),
                  const SizedBox(height: 6),
                  Text(_msg,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 15, color: SC.textMuted, height: 1.5)),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 16),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(18)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _ResStat('⭐', 'Score', '${widget.score}'),
                          _ResStat('🎯', 'Matched',
                              '${widget.matches}/${widget.total}'),
                          _ResStat('👆', 'Moves', '${widget.moves}'),
                        ]),
                  ),
                  const SizedBox(height: 22),
                  Row(children: [
                    Expanded(
                        child: _ActionBtn(
                      label: 'Play Again',
                      icon: '🔄',
                      colors: [
                        const Color(0xFF3CD98F),
                        const Color(0xFF0FAB5E)
                      ],
                      onTap: widget.onRestart,
                    )),
                    const SizedBox(width: 12),
                    Expanded(
                        child: _ActionBtn(
                      label: 'Home',
                      icon: '🏠',
                      colors: [
                        const Color(0xFFAA66FF),
                        const Color(0xFF6A1FCC)
                      ],
                      onTap: widget.onHome,
                    )),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ResStat extends StatelessWidget {
  final String icon, label, value;
  const _ResStat(this.icon, this.label, this.value);
  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 2),
          Text(value,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: SC.purpleDark)),
          Text(label,
              style: const TextStyle(
                  fontSize: 10,
                  color: SC.textMuted,
                  fontWeight: FontWeight.w700)),
        ],
      );
}

class _ActionBtn extends StatefulWidget {
  final String label, icon;
  final List<Color> colors;
  final VoidCallback onTap;
  const _ActionBtn(
      {required this.label,
      required this.icon,
      required this.colors,
      required this.onTap});
  @override
  State<_ActionBtn> createState() => _ActionBtnState();
}

class _ActionBtnState extends State<_ActionBtn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    _scale = Tween(begin: 1.0, end: 0.93).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTapDown: (_) => _ctrl.forward(),
        onTapUp: (_) {
          _ctrl.reverse();
          widget.onTap();
        },
        onTapCancel: () => _ctrl.reverse(),
        child: ScaleTransition(
          scale: _scale,
          child: Container(
            height: 54,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: widget.colors),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: widget.colors[1].withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 4))
              ],
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(widget.icon, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(widget.label,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Colors.white)),
            ]),
          ),
        ),
      );
}

class _Particle {
  double x, y, vx, vy, opacity, size;
  final Color color;
  _Particle(
      {required this.x,
      required this.y,
      required this.vx,
      required this.vy,
      required this.color,
      required this.size,
      this.opacity = 1.0});
}
