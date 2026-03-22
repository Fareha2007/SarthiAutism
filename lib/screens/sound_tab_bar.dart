import 'package:flutter/material.dart';
import 'package:sarthi_flutter_project/screens/sound_data.dart';

class SoundTabBar extends StatelessWidget {
  final TabController controller;
  final List<SoundCategory> categories;
  final int selectedTab;

  const SoundTabBar({
    super.key,
    required this.controller,
    required this.categories,
    required this.selectedTab,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TabBar(
        controller: controller,
        isScrollable: false,
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelPadding: EdgeInsets.zero,
        tabs: List.generate(categories.length, (i) {
          final cat = categories[i];
          final isSelected = i == selectedTab;
          return Tab(
            height: 52,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(cat.emoji, style: const TextStyle(fontSize: 20)),
                Text(
                  cat.name,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? cat.accentColor : Colors.white,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
