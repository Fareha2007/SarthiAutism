import 'package:flutter/material.dart';
import 'package:sarthi_flutter_project/models/models.dart';
import 'package:sarthi_flutter_project/screens/screening_result_screen.dart';

// ── M-CHAT Questions ──────────────────────────────────────────────────────────
const List<String> kMCHAT = [
  "If you point at something across the room, does your child look at it?",
  "Have you ever wondered if your child might be deaf?",
  "Does your child play pretend or make-believe?",
  "Does your child like climbing on things?",
  "Does your child make unusual finger movements near their eyes?",
  "Does your child point with one finger to ask for something?",
  "Does your child point with one finger to show you something interesting?",
  "Is your child interested in other children?",
  "Does your child show you things by bringing them to you or holding them up?",
  "Does your child respond to their name when called?",
  "When you smile at your child, do they smile back?",
  "Does your child get upset by everyday noises?",
  "Does your child walk?",
  "Does your child look you in the eye when you talk or play?",
  "Does your child try to copy what you do?",
  "If you turn your head to look at something, does your child look too?",
  "Does your child try to get you to watch them?",
  "Does your child understand when you tell them to do something?",
  "If something new happens, does your child look at your face to see how you feel?",
  "Does your child like movement activities like being swung or bounced?",
];

// ── Colors ────────────────────────────────────────────────────────────────────
const _purple = Color(0xFF8B5BA6);
const _purpleDark = Color(0xFF5C3578);
const _lavLight = Color(0xFFF3EEFF);
const _lavender = Color(0xFFD9B8FF);
const _mintDark = Color(0xFF3A9E74);
const _red = Color(0xFFD95B5B);
const _border = Color(0xFFE0D4F0);
const _bgAlt = Color(0xFFF0EBF9);
const _textDark = Color(0xFF2A1A3E);
const _textMuted = Color(0xFF8A7A9A);
const _gradTop = Color(0xFFB4E2FC);
const _gradMid = Color(0xFFF2EFE6);
const _gradBot = Color(0xFFE8D5F2);

// ─────────────────────────────────────────────────────────────
//  QUIZ SCREEN — all 20 questions, navigates to ScreeningResultScreen
// ─────────────────────────────────────────────────────────────
class QuizScreen extends StatefulWidget {
  final ChildProfile child;
  const QuizScreen({super.key, required this.child});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final Map<int, String> _answers = {};
  bool _isAnimating = false;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // ── Answer selected ───────────────────────────────────────
  void _onAnswer(String value) {
    if (_isAnimating) return;

    _answers[_currentIndex] = value;
    _isAnimating = true;

    if (_currentIndex < kMCHAT.length - 1) {
      final next = _currentIndex + 1;
      _pageController
          .animateToPage(
        next,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeInOut,
      )
          .then((_) {
        if (!mounted) return;
        setState(() {
          _currentIndex = next;
          _isAnimating = false;
        });
      });
    } else {
      _finishQuiz();
    }
  }

  // ── Back button ───────────────────────────────────────────
  void _onBack() {
    if (_isAnimating) return;
    if (_currentIndex == 0) {
      Navigator.pop(context);
      return;
    }
    _isAnimating = true;
    final prev = _currentIndex - 1;
    _pageController
        .animateToPage(
      prev,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeInOut,
    )
        .then((_) {
      if (!mounted) return;
      setState(() {
        _currentIndex = prev;
        _isAnimating = false;
      });
    });
  }

  // ── Calculate score and navigate ──────────────────────────
  void _finishQuiz() {
    final yesCount = _answers.values.where((v) => v == 'Yes').length;
    final risk = yesCount <= 2
        ? 'Low'
        : yesCount <= 7
            ? 'Medium'
            : 'High';

    if (!mounted) return;
    setState(() => _isAnimating = false);

    // ✅ Navigate to ScreeningResultScreen with updated ChildProfile
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ScreeningResultScreen(
          child: widget.child.copyWith(
            screeningRisk: risk,
            quizScore: yesCount,
          ),
        ),
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final pct = (_currentIndex + 1) / kMCHAT.length;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.15, 0.61, 1.0],
            colors: [_gradTop, _gradMid, _gradBot],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildTopBar(),
              _buildProgressBar(pct),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: kMCHAT.length,
                  itemBuilder: (context, index) => _buildQuestionPage(index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Top bar ───────────────────────────────────────────────
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 16, 4),
      child: Row(
        children: [
          GestureDetector(
            onTap: _onBack,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _border),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  size: 18, color: _purpleDark),
            ),
          ),
          const Spacer(),
          const Text(
            'M-CHAT Screening',
            style: TextStyle(
              fontFamily: 'PlayfairDisplay',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: _purpleDark,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _border),
            ),
            child: Text(
              '${_currentIndex + 1} / ${kMCHAT.length}',
              style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w800, color: _purple),
            ),
          ),
        ],
      ),
    );
  }

  // ── Progress bar ──────────────────────────────────────────
  Widget _buildProgressBar(double pct) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: pct),
          duration: const Duration(milliseconds: 400),
          builder: (_, val, __) => LinearProgressIndicator(
            value: val,
            backgroundColor: _border,
            valueColor: const AlwaysStoppedAnimation<Color>(_purple),
            minHeight: 8,
          ),
        ),
      ),
    );
  }

  // ── Question page ─────────────────────────────────────────
  Widget _buildQuestionPage(int index) {
    final question = kMCHAT[index];
    final answered = _answers[index];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _lavLight,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _lavender, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: _purple.withOpacity(0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _purple.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'QUESTION ${index + 1}',
                    style: const TextStyle(
                      fontSize: 10,
                      color: _purple,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  question,
                  style: const TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: _textDark,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          const Text(
            'Your answer',
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w700, color: _textMuted),
          ),
          const SizedBox(height: 12),

          _buildAnswerOption(
              index: index,
              label: 'Yes',
              icon: Icons.check_circle_rounded,
              color: _mintDark,
              answered: answered),
          const SizedBox(height: 12),
          _buildAnswerOption(
              index: index,
              label: 'No',
              icon: Icons.cancel_rounded,
              color: _red,
              answered: answered),
          const SizedBox(height: 12),
          _buildAnswerOption(
              index: index,
              label: 'Sometimes',
              icon: Icons.help_rounded,
              color: _purple,
              answered: answered),
          const SizedBox(height: 24),

          // Disclaimer
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _bgAlt,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _border),
            ),
            child: const Text(
              '⚠️ Based on M-CHAT-R/F. This is a screening tool only — not a diagnosis. Always consult a certified professional.',
              style: TextStyle(fontSize: 12, color: _textMuted, height: 1.6),
            ),
          ),
        ],
      ),
    );
  }

  // ── Answer option ─────────────────────────────────────────
  Widget _buildAnswerOption({
    required int index,
    required String label,
    required IconData icon,
    required Color color,
    required String? answered,
  }) {
    final isSelected = answered == label;

    return GestureDetector(
      onTap: () => _onAnswer(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : _border,
            width: isSelected ? 2.5 : 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                      color: color.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4))
                ]
              : [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2))
                ],
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? color.withOpacity(0.15) : _bgAlt,
                shape: BoxShape.circle,
              ),
              child:
                  Icon(icon, color: isSelected ? color : _textMuted, size: 22),
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: isSelected ? color : _textDark,
              ),
            ),
            const Spacer(),
            if (isSelected) Icon(Icons.check_rounded, color: color, size: 20),
          ],
        ),
      ),
    );
  }
}
