import 'package:flutter/material.dart';

Route fadeRoute(Widget page) => PageRouteBuilder(
  pageBuilder: (_, __, ___) => page,
  transitionsBuilder: (_, anim, __, child) => FadeTransition(opacity: anim, child: child),
  transitionDuration: const Duration(milliseconds: 300),
);

Route slideRoute(Widget page) => PageRouteBuilder(
  pageBuilder: (_, __, ___) => page,
  transitionsBuilder: (_, anim, __, child) => SlideTransition(
    position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
    child: child,
  ),
  transitionDuration: const Duration(milliseconds: 280),
);

Widget stepDots({required int active}) => Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: List.generate(2, (i) => AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    margin: const EdgeInsets.symmetric(horizontal: 4),
    width: i == active ? 20 : 8,
    height: 6,
    decoration: BoxDecoration(
      color: i == active ? const Color(0xFF8B5BA6) : const Color(0xFFE0D4F0),
      borderRadius: BorderRadius.circular(3),
    ),
  )),
);

extension Let<T> on T {
  R let<R>(R Function(T) f) => f(this);
}
