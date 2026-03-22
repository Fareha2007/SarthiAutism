import 'package:flutter/material.dart';
import 'package:sarthi_flutter_project/models/app_model.dart';
import '../utils/colors.dart';
import '../utils/routes.dart';
import '../widgets/widgets.dart';
import '../models/models.dart';
import '../data/static_data.dart';
import 'activity_detail_screen.dart';

class ActivitiesScreen extends StatefulWidget {
  final ChildProfile child;
  const ActivitiesScreen({super.key, required this.child});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  String _cat = 'all';
  final _cats = ['all', 'communication', 'sensory', 'behaviour', 'routine'];

  List<Activity> get _filtered => _cat == 'all'
      ? kActivities
      : kActivities.where((a) => a.category == _cat).toList();

  @override
  Widget build(BuildContext context) {
    return GradScaffold(
      child: Column(
        children: [
          const SarthiTopBar(title: 'Activities', showBack: false),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'For ${widget.child.name} · ${widget.child.supportLevel} support',
                    style: const TextStyle(fontSize: 13, color: SC.textMuted)),
                const SizedBox(height: 10),
                SizedBox(
                  height: 38,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: _cats
                        .map((c) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: SarthiChip(
                                label: c == 'all'
                                    ? '✨ All'
                                    : c[0].toUpperCase() + c.substring(1),
                                selected: _cat == c,
                                onTap: () => setState(() => _cat = c),
                                color: SC.purple,
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              itemCount: _filtered.length,
              itemBuilder: (ctx, i) {
                final a = _filtered[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SarthiCard(
                    onTap: () => Navigator.push(
                        ctx, slideRoute(ActivityDetailScreen(activity: a))),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                                color: SC.lavLight,
                                borderRadius: BorderRadius.circular(14)),
                            child: Center(
                                child: Text(a.icon,
                                    style: const TextStyle(fontSize: 26))),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text(a.title,
                                    style: const TextStyle(
                                        fontFamily: 'PlayfairDisplay',
                                        fontSize: 16,
                                        color: SC.purpleDark)),
                                const SizedBox(height: 4),
                                Text(
                                  a.instructions.length > 65
                                      ? '${a.instructions.substring(0, 65)}…'
                                      : a.instructions,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: SC.textMuted,
                                      height: 1.4),
                                ),
                                const SizedBox(height: 8),
                                Wrap(spacing: 6, children: [
                                  SarthiBadge(
                                      label: '⏱ ${a.duration}',
                                      color: SC.skyDark),
                                  SarthiBadge(
                                      label: a.category, color: SC.purple),
                                ]),
                              ])),
                        ]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
