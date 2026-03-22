import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sarthi_flutter_project/models/models.dart';
import 'package:sarthi_flutter_project/screens/home_screen.dart';
import 'package:sarthi_flutter_project/screens/main_shell.dart';
import 'package:sarthi_flutter_project/utils/colors.dart';
import 'package:sarthi_flutter_project/widgets/widgets.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  int _dot = 0;
  late final AnimationController _fadeCtrl;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();

    // Fade animation
    _fadeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _fadeCtrl.forward();

    // Dot animation
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 450));
      if (!mounted) return false;
      setState(() => _dot = (_dot + 1) % 3);
      return mounted;
    });

    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Run both in parallel:
    // 1. Minimum splash duration (2.6s)
    // 2. Wait for Firebase Auth to restore session (emits first event)
    final results = await Future.wait([
      Future.delayed(const Duration(milliseconds: 2600)),
      FirebaseAuth.instance.authStateChanges().first,
    ]);

    if (!mounted) return;

    final user = results[1] as User?;

    if (user != null) {
      // User is logged in — load their child profile
      try {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('child')
            .doc('profile')
            .get()
            .timeout(const Duration(seconds: 5));

        if (!mounted) return;

        final child =
            doc.exists ? ChildProfile.fromMap(doc.data()!) : ChildProfile();

        Navigator.pushReplacement(
            context,
            // MaterialPageRoute(builder: (_) => HomeScreen(child: child)),
            MaterialPageRoute(builder: (_) => MainShell(child: child)));
      } catch (_) {
        // Firestore timed out — go home anyway with empty profile
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen(child: ChildProfile())),
        );
      }
    } else {
      // Not logged in — show login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final dotColors = [SC.sky, SC.lavender, SC.mint];

    return GradScaffold(
      safeArea: false,
      child: FadeTransition(
        opacity: _fadeAnim,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/sarthi_logo.png',
              height: h * 0.22,
              errorBuilder: (_, __, ___) => Container(
                width: h * 0.22,
                height: h * 0.22,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [SC.lavender, SC.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(h * 0.06),
                  boxShadow: [
                    BoxShadow(
                        color: SC.purple.withOpacity(0.3),
                        blurRadius: 24,
                        offset: const Offset(0, 8))
                  ],
                ),
                child: const Center(
                    child: Text('∞',
                        style: TextStyle(fontSize: 64, color: Colors.white))),
              ),
            ),
            SizedBox(height: h * 0.03),
            const Text('Sarthi',
                style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 44,
                    fontWeight: FontWeight.w700,
                    color: SC.purpleDark,
                    letterSpacing: 3)),
            const SizedBox(height: 8),
            const Text('Your autism support companion',
                style: TextStyle(
                    fontSize: 15,
                    color: SC.textMuted,
                    fontWeight: FontWeight.w500)),
            SizedBox(height: h * 0.06),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  3,
                  (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: _dot == i ? 14 : 10,
                        height: _dot == i ? 14 : 10,
                        decoration: BoxDecoration(
                          color: dotColors[i],
                          shape: BoxShape.circle,
                          boxShadow: _dot == i
                              ? [
                                  BoxShadow(
                                      color: dotColors[i].withOpacity(0.5),
                                      blurRadius: 8)
                                ]
                              : [],
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
