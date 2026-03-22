import 'package:flutter/material.dart';
import 'package:sarthi_flutter_project/models/app_model.dart';
import '../utils/colors.dart';
import '../utils/routes.dart';
import '../widgets/widgets.dart';
import '../models/models.dart';
import 'quiz_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChildSetupScreen extends StatefulWidget {
  const ChildSetupScreen({super.key});

  @override
  State<ChildSetupScreen> createState() => _ChildSetupScreenState();
}

class _ChildSetupScreenState extends State<ChildSetupScreen> {
  final _nameCtrl = TextEditingController();
  final _profile = ChildProfile();
  final _genders = ['Boy', 'Girl', 'Other'];
  final _supports = ['Mild', 'Moderate', 'High', 'Not sure'];
  final _challenges = [
    {'key': 'communication', 'label': 'Communication', 'icon': '💬'},
    {'key': 'sensory', 'label': 'Sensory', 'icon': '🤲'},
    {'key': 'behaviour', 'label': 'Behaviour', 'icon': '🌟'},
    {'key': 'routine', 'label': 'Routine', 'icon': '⏰'},
  ];

  bool get _valid => _nameCtrl.text.trim().isNotEmpty && _profile.dob != null;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final p = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 5),
      firstDate: DateTime(now.year - 18),
      lastDate: DateTime(now.year - 1),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
            colorScheme: const ColorScheme.light(
                primary: SC.purple, onPrimary: Colors.white)),
        child: child!,
      ),
    );
    if (p != null) setState(() => _profile.dob = p);
  }

  void _toggleChallenge(String key) {
    setState(() {
      final list = List<String>.from(_profile.challenges);
      list.contains(key) ? list.remove(key) : list.add(key);
      _profile.challenges = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dob = _profile.dob;
    return GradScaffold(
      child: Column(
        children: [
          const SarthiTopBar(title: 'Child Profile'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 76,
                          height: 76,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [SC.skyLight, SC.skyDark],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: SC.skyDark.withOpacity(0.3),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4))
                            ],
                          ),
                          child: Center(
                              child: Text(
                                  _profile.gender == 'Girl' ? '👧' : '👦',
                                  style: const TextStyle(fontSize: 38))),
                        ),
                        const SizedBox(height: 10),
                        stepDots(active: 1),
                        const SizedBox(height: 6),
                        const Text('STEP 2 OF 2',
                            style: TextStyle(
                                fontSize: 11,
                                color: SC.purple,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SarthiInput(
                      label: "Child's Name",
                      hint: "Enter child's name",
                      controller: _nameCtrl,
                      onChanged: (_) => setState(() {})),
                  SectionLabel('Date of Birth'),
                  GestureDetector(
                    onTap: _pickDate,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: SC.border, width: 1.5)),
                      child: Row(children: [
                        Icon(Icons.calendar_today_rounded,
                            size: 18,
                            color: dob == null ? SC.textMuted : SC.purple),
                        const SizedBox(width: 10),
                        Text(
                          dob == null
                              ? 'Select date of birth'
                              : '${dob.day.toString().padLeft(2, '0')} / ${dob.month.toString().padLeft(2, '0')} / ${dob.year}',
                          style: TextStyle(
                              fontSize: 15,
                              color: dob == null ? SC.textMuted : SC.textDark,
                              fontWeight: dob == null
                                  ? FontWeight.w400
                                  : FontWeight.w600),
                        ),
                      ]),
                    ),
                  ),
                  if (dob != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 6, bottom: 4),
                      child: Text('Age: ${_profile.age} years old',
                          style: const TextStyle(
                              fontSize: 12,
                              color: SC.skyDark,
                              fontWeight: FontWeight.w700)),
                    ),
                  const SizedBox(height: 20),
                  SectionLabel('Gender'),
                  Wrap(
                    spacing: 10,
                    children: _genders
                        .map((g) => SarthiChip(
                              label: g,
                              selected: _profile.gender == g,
                              onTap: () => setState(() => _profile.gender = g),
                              color: SC.purple,
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  SectionLabel('Primary Challenge Areas'),
                  const Text('Select all that apply',
                      style: TextStyle(fontSize: 12, color: SC.textMuted)),
                  const SizedBox(height: 10),
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 2.8,
                    children: _challenges.map((c) {
                      final key = c['key'] as String;
                      final sel = _profile.challenges.contains(key);
                      return GestureDetector(
                        onTap: () => _toggleChallenge(key),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: sel ? SC.lavLight : Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                                color: sel ? SC.purple : SC.border, width: 1.5),
                            boxShadow: sel
                                ? [
                                    BoxShadow(
                                        color: SC.purple.withOpacity(0.15),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2))
                                  ]
                                : [],
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(c['icon'] as String,
                                    style: const TextStyle(fontSize: 18)),
                                const SizedBox(width: 8),
                                Text(c['label'] as String,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: sel ? SC.purple : SC.textMuted)),
                              ]),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  SectionLabel('Support Level Needed'),
                  const Text('You can change this anytime',
                      style: TextStyle(fontSize: 12, color: SC.textMuted)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _supports
                        .map((s) => SarthiChip(
                              label: s,
                              selected: _profile.supportLevel == s,
                              onTap: () =>
                                  setState(() => _profile.supportLevel = s),
                              color: SC.purpleDark,
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 32),
                  SarthiButton(
                    label: 'Continue to Screening',
                    icon: Icons.arrow_forward_rounded,
                    onPressed: _valid
                        ? () async {
                            _profile.name = _nameCtrl.text.trim();

                            final uid = FirebaseAuth.instance.currentUser?.uid;
                            if (uid == null) return;

                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(uid)
                                .collection('child')
                                .doc('profile')
                                .set({
                              'name': _profile.name,
                              //     'dob': _profile.dob?.toString(),
                              'dob': _profile.dob,
                              'gender': _profile.gender,
                              'challenges': _profile.challenges,
                              'supportLevel': _profile.supportLevel,
                            });

                            Navigator.push(
                              context,
                              slideRoute(QuizScreen(child: _profile)),
                            );
                          }
                        : null,
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
