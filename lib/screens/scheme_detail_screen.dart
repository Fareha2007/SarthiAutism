import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';
import '../widgets/widgets.dart';
import '../models/models.dart';
import 'package:url_launcher/url_launcher.dart';

class SchemeDetailScreen extends StatefulWidget {
  final GovtScheme scheme;
  const SchemeDetailScreen({super.key, required this.scheme});

  @override
  State<SchemeDetailScreen> createState() => _SchemeDetailScreenState();
}

class _SchemeDetailScreenState extends State<SchemeDetailScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _heroCtrl;
  late final Animation<double> _heroFade;
  late final Animation<Offset> _heroSlide;

  @override
  void initState() {
    super.initState();
    _heroCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _heroFade = CurvedAnimation(parent: _heroCtrl, curve: Curves.easeOut);
    _heroSlide = Tween(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(CurvedAnimation(parent: _heroCtrl, curve: Curves.easeOut));
    _heroCtrl.forward();
  }

  @override
  void dispose() {
    _heroCtrl.dispose();
    super.dispose();
  }

  // ── URL launcher ──────────────────────────────────────────────
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) _showSnack('Could not open the website', SC.purple);
    }
  }

  void _copyPhone(String phone) {
    Clipboard.setData(ClipboardData(text: phone));
    _showSnack('$phone copied to clipboard', SC.skyDark);
  }

  void _showSnack(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      duration: const Duration(seconds: 2),
    ));
  }

  // ── Parse description into sections ──────────────────────────
  List<_DescSection> _parseSections(String raw) {
    final lines = raw.trim().split('\n');
    final sections = <_DescSection>[];
    String? currentHeading;
    final currentLines = <String>[];

    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) {
        if (currentLines.isNotEmpty) currentLines.add('');
        continue;
      }
      final isHeading = trimmed == trimmed.toUpperCase() &&
          trimmed.length > 4 &&
          !trimmed.startsWith('•') &&
          !RegExp(r'^\d').hasMatch(trimmed);

      if (isHeading) {
        if (currentLines.isNotEmpty || currentHeading != null) {
          sections.add(_DescSection(
            heading: currentHeading,
            lines: List.from(currentLines),
          ));
          currentLines.clear();
        }
        currentHeading = trimmed;
      } else {
        currentLines.add(trimmed);
      }
    }
    if (currentLines.isNotEmpty || currentHeading != null) {
      sections.add(_DescSection(
        heading: currentHeading,
        lines: List.from(currentLines),
      ));
    }
    return sections;
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.scheme;
    final sections = _parseSections(s.description);

    return GradScaffold(
      child: Column(
        children: [
          // ── Top bar ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 52, 16, 0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: SC.border),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 17,
                      color: SC.purpleDark,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    s.name,
                    style: const TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontSize: 18,
                      color: SC.purpleDark,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // ── Body ─────────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: FadeTransition(
                opacity: _heroFade,
                child: SlideTransition(
                  position: _heroSlide,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Hero Header ────────────────────────
                      _HeroHeader(scheme: s),
                      const SizedBox(height: 16),

                      // ── Eligibility Box ────────────────────
                      _EligibilityBox(text: s.eligibility),
                      const SizedBox(height: 16),

                      // ── Description Sections ───────────────
                      ...sections.map((sec) => Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: _SectionCard(section: sec),
                          )),

                      // ── Action Buttons ─────────────────────
                      if (s.applyUrl.isNotEmpty || s.phone.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        const _SectionLabel('Take Action'),
                        const SizedBox(height: 10),
                        if (s.applyUrl.isNotEmpty)
                          _ApplyButton(
                            url: s.applyUrl,
                            onTap: () => _launchUrl(s.applyUrl),
                          ),
                        if (s.phone.isNotEmpty) ...[
                          const SizedBox(height: 10),
                          _HelplineCard(
                            phone: s.phone,
                            onTap: () => _copyPhone(s.phone),
                          ),
                        ],
                        const SizedBox(height: 16),
                      ],

                      // ── Disclaimer ─────────────────────────
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF8E7),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFFFD22E).withOpacity(0.4),
                          ),
                        ),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('⚠️', style: TextStyle(fontSize: 16)),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Scheme details are accurate as of 2024-25. Always verify the latest eligibility and benefit amounts at the official government portal before applying.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF856404),
                                  height: 1.65,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
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

// ══════════════════════════════════════════════════════════════
//  HERO HEADER
// ══════════════════════════════════════════════════════════════
class _HeroHeader extends StatelessWidget {
  final GovtScheme scheme;
  const _HeroHeader({required this.scheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6A1FCC), Color(0xFF9B46FF), Color(0xFFB87FFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6A1FCC).withOpacity(0.38),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon circle
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.35),
                width: 1.5,
              ),
            ),
            child: const Center(
              child: Icon(Icons.badge_rounded, size: 34, color: Colors.white),
            ),
          ),
          const SizedBox(height: 14),

          // Scheme name
          Text(
            scheme.name,
            style: const TextStyle(
              fontFamily: 'PlayfairDisplay',
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 8),

          // Ministry badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.account_balance_rounded,
                    size: 12, color: Colors.white70),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    scheme.ministry,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  ELIGIBILITY BOX
// ══════════════════════════════════════════════════════════════
class _EligibilityBox extends StatelessWidget {
  final String text;
  const _EligibilityBox({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF3CD98F).withOpacity(0.45),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3CD98F).withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFF3CD98F).withOpacity(0.18),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text('✅', style: TextStyle(fontSize: 18)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'WHO IS ELIGIBLE',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0FAB5E),
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: Color(0xFF065F46),
                    height: 1.65,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  DESCRIPTION SECTION (data class)
// ══════════════════════════════════════════════════════════════
class _DescSection {
  final String? heading;
  final List<String> lines;
  const _DescSection({this.heading, required this.lines});
}

// ══════════════════════════════════════════════════════════════
//  SECTION CARD
// ══════════════════════════════════════════════════════════════
class _SectionCard extends StatelessWidget {
  final _DescSection section;
  const _SectionCard({required this.section});

  static const _headingIcons = {
    'WHAT IT GIVES YOU': '🎁',
    'WHAT IS COVERED': '📦',
    'WHAT RBSK SCREENS FOR': '🔍',
    'WHAT NIRAMAYA COVERS': '💊',
    'WHAT VIKAAS COVERS': '🎯',
    'HOW TO APPLY': '📝',
    'HOW TO ACCESS': '📍',
    'DOCUMENTS NEEDED': '📁',
    'IMPORTANT NOTE': 'ℹ️',
    'INCOME LIMIT': '💰',
    'EARLY INTERVENTION': '🌱',
    'SUPPORT AVAILABLE': '🤝',
    'ADDITIONAL BENEFITS': '⭐',
  };

  @override
  Widget build(BuildContext context) {
    final heading = section.heading;
    final icon = heading != null ? (_headingIcons[heading] ?? '📌') : null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: SC.border),
        boxShadow: [
          BoxShadow(
            color: SC.purple.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (heading != null)
            Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
              decoration: BoxDecoration(
                color: SC.lavLight.withOpacity(0.5),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(18)),
              ),
              child: Row(
                children: [
                  if (icon != null) ...[
                    Text(icon, style: const TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: Text(
                      heading,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: SC.purple,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, heading != null ? 10 : 16, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: section.lines
                  .where((l) => l.isNotEmpty)
                  .map((line) => _RichLine(line: line))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Individual line renderer ──────────────────────────────────
class _RichLine extends StatelessWidget {
  final String line;
  const _RichLine({required this.line});

  @override
  Widget build(BuildContext context) {
    // Bullet point
    if (line.startsWith('•')) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 7,
              height: 7,
              margin: const EdgeInsets.only(top: 6, right: 10),
              decoration: const BoxDecoration(
                color: SC.purple,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: Text(
                line.substring(1).trim(),
                style: const TextStyle(
                  fontSize: 13.5,
                  color: SC.textDark,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Numbered step (e.g. "1. Go to website")
    final numMatch = RegExp(r'^(\d+)\.\s+(.+)$').firstMatch(line);
    if (numMatch != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 22,
              height: 22,
              margin: const EdgeInsets.only(top: 1, right: 10),
              decoration: BoxDecoration(
                color: SC.purple.withOpacity(0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  numMatch.group(1)!,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: SC.purple,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                numMatch.group(2)!,
                style: const TextStyle(
                  fontSize: 13.5,
                  color: SC.textDark,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Plain paragraph
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        line,
        style: const TextStyle(
          fontSize: 13.5,
          color: SC.textDark,
          height: 1.7,
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  APPLY ONLINE BUTTON
// ══════════════════════════════════════════════════════════════
class _ApplyButton extends StatefulWidget {
  final String url;
  final VoidCallback onTap;
  const _ApplyButton({required this.url, required this.onTap});

  @override
  State<_ApplyButton> createState() => _ApplyButtonState();
}

class _ApplyButtonState extends State<_ApplyButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scale = Tween(begin: 1.0, end: 0.96).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  String get _displayUrl => widget.url
      .replaceFirst('https://', '')
      .replaceFirst('http://', '')
      .replaceFirst('www.', '');

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
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6A1FCC), Color(0xFF9B46FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6A1FCC).withOpacity(0.38),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.open_in_new_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Apply Online',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _displayUrl,
                      style:
                          const TextStyle(fontSize: 11, color: Colors.white70),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white70,
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  HELPLINE CARD — tap to copy
// ══════════════════════════════════════════════════════════════
class _HelplineCard extends StatefulWidget {
  final String phone;
  final VoidCallback onTap;
  const _HelplineCard({required this.phone, required this.onTap});

  @override
  State<_HelplineCard> createState() => _HelplineCardState();
}

class _HelplineCardState extends State<_HelplineCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  bool _copied = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scale = Tween(begin: 1.0, end: 0.96).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _handleTap() {
    _ctrl.reverse();
    widget.onTap();
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _handleTap(),
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: _copied ? const Color(0xFFECFDF5) : const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: _copied
                  ? const Color(0xFF3CD98F).withOpacity(0.5)
                  : const Color(0xFF4E90FF).withOpacity(0.35),
            ),
            boxShadow: [
              BoxShadow(
                color: (_copied
                        ? const Color(0xFF3CD98F)
                        : const Color(0xFF4E90FF))
                    .withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: (_copied
                          ? const Color(0xFF3CD98F)
                          : const Color(0xFF4E90FF))
                      .withOpacity(0.14),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _copied ? Icons.check_rounded : Icons.phone_rounded,
                  color: _copied
                      ? const Color(0xFF0FAB5E)
                      : const Color(0xFF4E90FF),
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        _copied ? 'Copied to clipboard!' : 'Helpline Number',
                        key: ValueKey(_copied),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: _copied
                              ? const Color(0xFF0FAB5E)
                              : const Color(0xFF4E90FF),
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      widget.phone,
                      style: TextStyle(
                        fontSize: 20,
                        color: _copied
                            ? const Color(0xFF0FAB5E)
                            : const Color(0xFF1D4ED8),
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  _copied ? Icons.check_circle_rounded : Icons.copy_rounded,
                  key: ValueKey(_copied),
                  color: _copied
                      ? const Color(0xFF0FAB5E)
                      : const Color(0xFF94A3B8),
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Helper label ──────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(
          fontFamily: 'PlayfairDisplay',
          fontSize: 17,
          color: SC.purpleDark,
          fontWeight: FontWeight.w700,
        ),
      );
}
