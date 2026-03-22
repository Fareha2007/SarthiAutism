import 'package:flutter/material.dart';
import 'package:sarthi_flutter_project/models/app_model.dart';
import 'package:sarthi_flutter_project/screens/emotion_game_screen.dart';
import 'package:sarthi_flutter_project/screens/level_select_screen.dart';
import 'package:sarthi_flutter_project/screens/memory_card_game.dart';
import 'package:sarthi_flutter_project/screens/sound_game_screen.dart';
import '../utils/colors.dart';
import '../utils/routes.dart';
import '../widgets/widgets.dart';
import '../models/models.dart';
import 'child_profile_screen.dart';
import 'screening_result_screen.dart';
import 'color_match_game.dart';
import 'scheme_detail_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sarthi_flutter_project/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  final ChildProfile child;

  const HomeScreen({super.key, required this.child});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String parentName = '';
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadParentData();
  }

  Future<void> loadParentData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('parent')
          .doc('profile')
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        setState(() {
          parentName = data['name'] ?? '';
          loading = false;
        });
      } else {
        setState(() => loading = false);
      }
    } catch (e) {
      print("Error: $e");
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final child = widget.child;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final today = DateTime.now();

    final dayStr = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ][today.weekday - 1];

    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    final dateStr = '$dayStr, ${today.day} ${months[today.month - 1]}';
    final rc = SC.riskColor(child.screeningRisk ?? 'Medium');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: SC.purpleDark),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: screenWidth * 0.03,
            horizontal: screenWidth * 0.03,
          ),
          child: Column(
            children: [
              Text(
                dateStr,
                style: const TextStyle(fontSize: 13, color: SC.textMuted),
              ),
              const SizedBox(height: 4),

              /// 👇 DYNAMIC PARENT NAME
              Text(
                loading
                    ? "Loading..."
                    : "Hello, ${parentName.isEmpty ? 'User' : parentName} 👋",
                style: const TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: SC.purpleDark,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                "${child.name}'s daily plan is ready",
                style: const TextStyle(fontSize: 14, color: SC.textMuted),
              ),

              SizedBox(height: screenHeight * 0.03),

              /// CHILD PROFILE CARD
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    slideRoute(ChildProfileScreen(child: child)),
                  );
                },
                child: SarthiCard(
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [SC.skyLight, SC.skyDark],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            child.gender == 'Girl' ? '👧' : '👦',
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              child.name,
                              style: const TextStyle(
                                fontFamily: 'PlayfairDisplay',
                                fontSize: 17,
                                color: SC.purpleDark,
                              ),
                            ),
                            Text(
                              '${child.age} yrs · ${child.supportLevel} support',
                              style: const TextStyle(
                                fontSize: 13,
                                color: SC.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right_rounded,
                          color: SC.textMuted),
                    ],
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              /// SCREENING RESULT
              if (child.screeningRisk != null)
                SarthiCard(
                  color: rc.withOpacity(0.06),
                  border: Border.all(color: rc.withOpacity(0.2)),
                  onTap: () {
                    Navigator.push(
                      context,
                      slideRoute(ScreeningResultScreen(child: child)),
                    );
                  },
                  child: Row(
                    children: [
                      const Text('📋', style: TextStyle(fontSize: 22)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    fontSize: 14, color: SC.textDark),
                                children: [
                                  const TextSpan(
                                    text: 'Screening: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800),
                                  ),
                                  TextSpan(
                                    text: '${child.screeningRisk} Risk',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: rc,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Text(
                              'Tap to view full report',
                              style:
                                  TextStyle(fontSize: 12, color: SC.textMuted),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right_rounded, color: SC.purple),
                    ],
                  ),
                ),

              SizedBox(height: screenHeight * 0.04),

              const Text(
                "Games for Today",
                style: TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: SC.purpleDark,
                ),
              ),

              SizedBox(height: screenHeight * 0.02),

              /// GAME ROWS (UNCHANGED)
              Row(
                children: [
                  _gameCard(context, "Color Match", "🎨", screenWidth),
                  SizedBox(width: screenWidth * 0.04),
                  _gameCard(context, "Memory Cards", "🧠", screenWidth),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                children: [
                  _gameCard(context, "Shape Puzzle", "🧩", screenWidth),
                  SizedBox(width: screenWidth * 0.04),
                  _gameCard(
                      context, "Emotion Recognition Game", "🔊", screenWidth),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _gameCard(
      BuildContext context, String title, String emoji, double screenWidth) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (title == "Color Match") {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ColorMatchGame()));
          }
          if (title == "Memory Cards") {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const MemoryCardGame()));
          }
          if (title == "Shape Puzzle") {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const LevelSelectScreen()));
          }
          if (title == "Emotion Recognition Game") {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const EmotionGameScreen()));
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: screenWidth * 0.04,
            horizontal: screenWidth * 0.03,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFD9CFFF), width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 24)),
              SizedBox(height: screenWidth * 0.02),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.033,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
