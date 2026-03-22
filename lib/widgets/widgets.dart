import 'package:flutter/material.dart';
import '../utils/colors.dart';

// ─── Gradient background scaffold ───────────────────────────
class GradScaffold extends StatelessWidget {
  final Widget child;
  final bool safeArea;
  const GradScaffold({super.key, required this.child, this.safeArea = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.15, 0.61, 1.0],
            colors: [SC.gradTop, SC.gradMid, SC.gradBot],
          ),
        ),
        child: safeArea ? SafeArea(child: child) : child,
      ),
    );
  }
}

// ─── Top bar ────────────────────────────────────────────────
class SarthiTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final Widget? action;
  const SarthiTopBar(
      {super.key, required this.title, this.showBack = true, this.action});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
      child: Row(
        children: [
          if (showBack)
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: SC.border),
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded,
                    size: 18, color: SC.purpleDark),
              ),
            )
          else
            const SizedBox(width: 40),
          const Spacer(),
          Text(title,
              style: const TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: SC.purpleDark)),
          const Spacer(),
          action ?? const SizedBox(width: 40),
        ],
      ),
    );
  }
}

// ─── Primary button ──────────────────────────────────────────
class SarthiButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool outline;
  final Color? color;
  final IconData? icon;
  const SarthiButton(
      {super.key,
      required this.label,
      this.onPressed,
      this.outline = false,
      this.color,
      this.icon});

  @override
  Widget build(BuildContext context) {
    final col = color ?? SC.btnColor;
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: outline ? Colors.transparent : col,
          foregroundColor: outline ? col : SC.btnText,
          disabledBackgroundColor: SC.border,
          elevation: onPressed != null && !outline ? 4 : 0,
          shadowColor: SC.purple.withOpacity(0.3),
          side: outline ? BorderSide(color: col, width: 2) : BorderSide.none,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4)),
            if (icon != null) ...[
              const SizedBox(width: 8),
              Icon(icon, size: 20)
            ],
          ],
        ),
      ),
    );
  }
}

// ─── Card ────────────────────────────────────────────────────
class SarthiCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? color;
  final VoidCallback? onTap;
  final Border? border;
  const SarthiCard(
      {super.key,
      required this.child,
      this.padding,
      this.color,
      this.onTap,
      this.border});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color ?? SC.card,
          borderRadius: BorderRadius.circular(18),
          border: border ?? Border.all(color: SC.border),
          boxShadow: [
            BoxShadow(
                color: SC.purple.withOpacity(0.07),
                blurRadius: 12,
                offset: const Offset(0, 3))
          ],
        ),
        child: child,
      ),
    );
  }
}

// ─── Chip / pill selector ────────────────────────────────────
class SarthiChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color? color;
  const SarthiChip(
      {super.key,
      required this.label,
      required this.selected,
      required this.onTap,
      this.color});

  @override
  Widget build(BuildContext context) {
    final col = color ?? SC.purple;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? col : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: selected ? col : SC.border, width: 1.5),
          boxShadow: selected
              ? [
                  BoxShadow(
                      color: col.withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 2))
                ]
              : [],
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: selected ? Colors.white : SC.textMuted)),
      ),
    );
  }
}

// ─── Badge ───────────────────────────────────────────────────
class SarthiBadge extends StatelessWidget {
  final String label;
  final Color? color;
  const SarthiBadge({super.key, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    final col = color ?? SC.purple;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: col.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: col.withOpacity(0.25)),
      ),
      child: Text(label,
          style:
              TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: col)),
    );
  }
}

// ─── Section label ───────────────────────────────────────────
class SectionLabel extends StatelessWidget {
  final String text;
  const SectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: SC.textMuted)),
      );
}

// ─── Input field ─────────────────────────────────────────────
class SarthiInput extends StatelessWidget {
  final String label, hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final void Function(String)? onChanged;
  const SarthiInput(
      {super.key,
      required this.label,
      required this.hint,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(label),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: SC.border, width: 1.5),
            boxShadow: [
              BoxShadow(
                  color: SC.purple.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2))
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            onChanged: onChanged,
            style: const TextStyle(fontSize: 15, color: SC.textDark),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: SC.textMuted, fontSize: 14),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// ─── Bottom navigation ───────────────────────────────────────
class SarthiBottomNav extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;
  const SarthiBottomNav(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.home_rounded, 'label': 'Home'},
      {'icon': Icons.self_improvement_rounded, 'label': 'Activities'},
      {'icon': Icons.bar_chart_rounded, 'label': 'Log'},
      {'icon': Icons.medical_services_rounded, 'label': 'Doctors'},
      {'icon': Icons.menu_book_rounded, 'label': 'Learn'},
    ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: SC.border)),
        boxShadow: [
          BoxShadow(
              color: SC.purple.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, -3))
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: List.generate(items.length, (i) {
              final selected = i == currentIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(i),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(items[i]['icon'] as IconData,
                          size: 24, color: selected ? SC.purple : SC.textMuted),
                      const SizedBox(height: 3),
                      Text(items[i]['label'] as String,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: selected ? SC.purple : SC.textMuted)),
                      const SizedBox(height: 3),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: selected ? 16 : 0,
                        height: 3,
                        decoration: BoxDecoration(
                            color: SC.purple,
                            borderRadius: BorderRadius.circular(2)),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
