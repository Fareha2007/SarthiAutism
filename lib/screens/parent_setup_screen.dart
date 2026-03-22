import 'package:flutter/material.dart';
import 'package:sarthi_flutter_project/models/app_model.dart';
import '../utils/colors.dart';
import '../utils/routes.dart';
import '../widgets/widgets.dart';
import '../models/models.dart';
import 'child_setup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ParentSetupScreen extends StatefulWidget {
  const ParentSetupScreen({super.key});

  @override
  State<ParentSetupScreen> createState() => _ParentSetupScreenState();
}

class _ParentSetupScreenState extends State<ParentSetupScreen> {
  final _profile = ParentProfile();
  final _nameCtrl = TextEditingController(text: 'Priya Sharma');
  final _phoneCtrl = TextEditingController(text: '98765 43210');
  final _relationships = ['Mother', 'Father', 'Guardian'];
  final _cities = ['Pune', 'Mumbai', 'Delhi', 'Bangalore', 'Chennai', 'Other'];

  @override
  Widget build(BuildContext context) {
    return GradScaffold(
      child: Column(
        children: [
          const SarthiTopBar(title: 'Your Profile', showBack: false),
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
                                colors: [SC.lavender, SC.purple],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: SC.purple.withOpacity(0.3),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4))
                            ],
                          ),
                          child: const Icon(Icons.person_rounded,
                              size: 38, color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        stepDots(active: 0),
                        const SizedBox(height: 6),
                        const Text('STEP 1 OF 2',
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
                      label: 'Full Name',
                      hint: 'Your full name',
                      controller: _nameCtrl),
                  SectionLabel('You are the child\'s'),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _relationships
                        .map((r) => SarthiChip(
                              label: r,
                              selected: _profile.relationship == r,
                              onTap: () =>
                                  setState(() => _profile.relationship = r),
                              color: SC.purple,
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  SarthiInput(
                      label: 'Phone Number',
                      hint: '10-digit mobile number',
                      controller: _phoneCtrl,
                      keyboardType: TextInputType.phone),
                  SectionLabel('City'),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _cities
                        .map((c) => SarthiChip(
                              label: c,
                              selected: _profile.city == c,
                              onTap: () => setState(() => _profile.city = c),
                              color: SC.skyDark,
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 32),
                  SarthiButton(
                      label: 'Continue',
                      icon: Icons.arrow_forward_rounded,
                      // onPressed: () {
                      //   _profile.name = _nameCtrl.text.trim();
                      //   _profile.phone = _phoneCtrl.text.trim();
                      //   Navigator.push(
                      //       context, slideRoute(const ChildSetupScreen()));
                      // },
                      onPressed: () async {
                        _profile.name = _nameCtrl.text.trim();
                        _profile.phone = _phoneCtrl.text.trim();

                        final uid = FirebaseAuth.instance.currentUser?.uid;
                        if (uid == null) return;

                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(uid)
                            .collection('parent')
                            .doc('profile')
                            .set({
                          'name': _profile.name,
                          'phone': _profile.phone,
                          'city': _profile.city,
                          'relationship': _profile.relationship,
                        });
                        Navigator.push(
                          context,
                          slideRoute(const ChildSetupScreen()),
                        );
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
