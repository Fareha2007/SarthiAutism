import 'package:flutter/material.dart';
import 'package:sarthi_flutter_project/models/app_model.dart';
import '../utils/colors.dart';
import '../widgets/widgets.dart';
import '../models/models.dart';

class ActivityDetailScreen extends StatefulWidget {
  final Activity activity;
  const ActivityDetailScreen({super.key, required this.activity});

  @override
  State<ActivityDetailScreen> createState() => _ActivityDetailScreenState();
}

class _ActivityDetailScreenState extends State<ActivityDetailScreen> {
  bool _done = false;

  @override
  Widget build(BuildContext context) {
    final a = widget.activity;
    return GradScaffold(
      child: Column(
//         Column(
//   mainAxisSize: MainAxisSize.min,
//   children: [
//     Text("Hello"),
//   ],
// )
        children: [
          const SarthiTopBar(title: 'Activity Detail'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
//                 Column(
//   mainAxisSize: MainAxisSize.min,
//   children: [
//     Text("Hello"),
//   ],
// )
                children: [
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      color: SC.lavLight,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                            color: SC.purple.withOpacity(0.15),
                            blurRadius: 16,
                            offset: const Offset(0, 4))
                      ],
                    ),
                    child: Center(
                        child:
                            Text(a.icon, style: const TextStyle(fontSize: 44))),
                  ),
                  const SizedBox(height: 14),
                  Text(a.title,
                      style: const TextStyle(
                          fontFamily: 'PlayfairDisplay',
                          fontSize: 24,
                          color: SC.purpleDark),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 10),
                  Wrap(spacing: 8, children: [
                    SarthiBadge(label: a.category, color: SC.purple),
                    SarthiBadge(label: '⏱ ${a.duration}', color: SC.skyDark),
                  ]),
                  const SizedBox(height: 20),
                  SarthiCard(
                      child: Column(
                          
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        const Text('How to do it',
                            style: TextStyle(
                                fontFamily: 'PlayfairDisplay',
                                fontSize: 17,
                                color: SC.purpleDark)),
                        const SizedBox(height: 10),
                        Text(a.instructions,
                            style: const TextStyle(
                                fontSize: 14, color: SC.textDark, height: 1.8)),
                      ])),
                  const SizedBox(height: 14),
                  SarthiCard(
                      child: Column(
              
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        const Text('Suitable for',
                            style: TextStyle(
                                fontFamily: 'PlayfairDisplay',
                                fontSize: 15,
                                color: SC.purpleDark)),
                        const SizedBox(height: 10),
                        Wrap(spacing: 6, runSpacing: 6, children: [
                          ...a.ageGroups.map((x) =>
                              SarthiBadge(label: 'Age $x', color: SC.skyDark)),
                          ...a.supportLevels.map((x) => SarthiBadge(
                              label: '$x support', color: SC.purple)),
                        ]),
                      ])),
                  const SizedBox(height: 14),
                  SarthiCard(
                    color: SC.bgAlt,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('📖 Source: ${a.source}',
                              style: const TextStyle(
                                  fontSize: 12, color: SC.textMuted)),
                          const SizedBox(height: 6),
                          const Text(
                              "⚠️ Consult your child's therapist before starting new activities.",
                              style:
                                  TextStyle(fontSize: 12, color: SC.textMuted)),
                        ]),
                  ),
                  const SizedBox(height: 24),
                  SarthiButton(
                    label: _done ? '✅ Marked as Done!' : 'Mark as Done',
                    color: _done ? SC.green : SC.btnColor,
                    outline: _done,
                    onPressed: () => setState(() => _done = !_done),
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
