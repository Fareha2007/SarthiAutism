import 'package:flutter/material.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

import 'home_screen.dart';
import 'activities_screen.dart';
import 'tracking_screen.dart';
import 'specialists_screen.dart';
import 'learn_screen.dart';

class MainShell extends StatefulWidget {
  final ChildProfile? child;

  const MainShell({super.key, this.child});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _idx = 0;

  late ChildProfile _child;

  @override
  void initState() {
    super.initState();

    _child = widget.child ??
        ChildProfile(
          name: 'Arjun',
          dob: DateTime(2018, 3, 12),
          gender: 'Boy',
          challenges: ['communication', 'sensory'],
          supportLevel: 'Moderate',
          screeningRisk: 'Medium',
          quizScore: 8,
        );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      HomeScreen(child: _child),
      ActivitiesScreen(child: _child),
      TrackingScreen(child: _child),
      const SpecialistsScreen(),
      const LearnScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _idx,
        children: screens,
      ),
      bottomNavigationBar: SarthiBottomNav(
        currentIndex: _idx,
        onTap: (i) {
          setState(() {
            _idx = i;
          });
        },
      ),
    );
  }
}
