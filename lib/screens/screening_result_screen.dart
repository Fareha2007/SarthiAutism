import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sarthi_flutter_project/models/app_model.dart';
import '../utils/colors.dart';
import '../utils/routes.dart';
import '../widgets/widgets.dart';
import '../models/models.dart';
import 'main_shell.dart';

class ScreeningResultScreen extends StatefulWidget {
  final ChildProfile child;
  const ScreeningResultScreen({super.key, required this.child});

  @override
  State<ScreeningResultScreen> createState() => _ScreeningResultScreenState();
}

class _ScreeningResultScreenState extends State<ScreeningResultScreen> {
  @override
  void initState() {
    super.initState();
    _saveScreeningResult();
  }

  Future<void> _saveScreeningResult() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    debugPrint('🔑 Screening UID: $uid');
    debugPrint(
        '📊 Risk: ${widget.child.screeningRisk}, Score: ${widget.child.quizScore}');

    if (uid == null) {
      debugPrint('❌ No user — cannot save screening');
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('screening')
          .doc('result')
          .set({
        'risk': widget.child.screeningRisk ?? 'Medium',
        'score': widget.child.quizScore ?? 0,
        'date': DateTime.now().toIso8601String(),
      });
      debugPrint('✅ Screening saved!');
    } catch (e) {
      debugPrint('❌ Screening error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final risk = widget.child.screeningRisk ?? 'Medium';
    final score = widget.child.quizScore ?? 0;
    final rc = SC.riskColor(risk);

    final msgs = {
      'Low':
          'Your responses suggest low likelihood of ASD. Continue monitoring and speak with a paediatrician if concerns arise.',
      'Medium':
          'Some areas of concern identified. We recommend a full evaluation by a developmental paediatrician.',
      'High':
          'Significant areas of concern. Please consult a developmental paediatrician or autism specialist as soon as possible.',
    };

    final steps = [
      'Consult a developmental paediatrician',
      'Share this result with your doctor',
      'Explore home therapy activities',
      'Find a specialist near you',
    ];

    return GradScaffold(
      child: Column(
        children: [
          const SarthiTopBar(title: 'Screening Result', showBack: false),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: rc.withOpacity(0.1),
                      border: Border.all(color: rc, width: 4),
                      boxShadow: [
                        BoxShadow(
                            color: rc.withOpacity(0.25),
                            blurRadius: 20,
                            offset: const Offset(0, 6))
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$score',
                          style: TextStyle(
                              fontFamily: 'PlayfairDisplay',
                              fontSize: 38,
                              fontWeight: FontWeight.w700,
                              color: rc),
                        ),
                        Text(
                          '/ 20',
                          style: TextStyle(
                              fontSize: 12,
                              color: rc,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SarthiBadge(label: '$risk Risk', color: rc),
                  const SizedBox(height: 10),
                  Text(
                    '$risk Likelihood of ASD',
                    style: const TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: 22,
                        color: SC.textDark),
                  ),
                  const SizedBox(height: 24),
                  SarthiCard(
                    color: rc.withOpacity(0.06),
                    border: Border.all(color: rc.withOpacity(0.2)),
                    child: Text(
                      msgs[risk]!,
                      style: const TextStyle(
                          fontSize: 14, color: SC.textDark, height: 1.75),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SarthiCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Recommended Next Steps',
                          style: TextStyle(
                              fontFamily: 'PlayfairDisplay',
                              fontSize: 17,
                              color: SC.purpleDark),
                        ),
                        const SizedBox(height: 14),
                        ...steps.asMap().entries.map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 28,
                                      height: 28,
                                      decoration: const BoxDecoration(
                                          color: SC.lavLight,
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: Text(
                                          '${e.key + 1}',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800,
                                              color: SC.purple),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          e.value,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: SC.textDark,
                                              height: 1.5),
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
                  const SizedBox(height: 16),
                  SarthiCard(
                    color: SC.bgAlt,
                    padding: const EdgeInsets.all(12),
                    child: const Text(
                      '⚠️ This is a screening tool only — not a clinical diagnosis. Based on M-CHAT-R/F. Please consult a certified professional for evaluation.',
                      style: TextStyle(
                          fontSize: 12, color: SC.textMuted, height: 1.6),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SarthiButton(
                    label: 'Continue to Sarthi',
                    icon: Icons.arrow_forward_rounded,
                    onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      fadeRoute(MainShell(child: widget.child)),
                      (_) => false,
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
