import 'package:flutter/material.dart';
import 'package:sarthi_flutter_project/models/app_model.dart';
import '../utils/colors.dart';
import '../utils/routes.dart';
import '../widgets/widgets.dart';
import '../models/models.dart';
import 'screening_result_screen.dart';

class ChildProfileScreen extends StatefulWidget {
  final ChildProfile child;
  const ChildProfileScreen({super.key, required this.child});

  @override
  State<ChildProfileScreen> createState() => _ChildProfileScreenState();
}

class _ChildProfileScreenState extends State<ChildProfileScreen> {
  bool _editing = false;
  final _therapistCtrl = TextEditingController();
  final _therapyTypeCtrl = TextEditingController();

  @override
  void dispose() {
    _therapistCtrl.dispose();
    _therapyTypeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.child;
    final rc = SC.riskColor(c.screeningRisk ?? 'Medium');
    final challenges = [
      {'key': 'communication', 'icon': '💬'},
      {'key': 'sensory', 'icon': '🤲'},
      {'key': 'behaviour', 'icon': '🌟'},
      {'key': 'routine', 'icon': '⏰'},
    ];

    return GradScaffold(
      child: Column(
        children: [
          SarthiTopBar(
            title: 'Child Profile',
            action: GestureDetector(
              onTap: () => setState(() => _editing = !_editing),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                    color: SC.lavLight,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: SC.lavender)),
                child: Text(_editing ? 'Save' : 'Edit',
                    style: const TextStyle(
                        color: SC.purple,
                        fontWeight: FontWeight.w800,
                        fontSize: 13)),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [SC.skyLight, SC.skyDark],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: SC.skyDark.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 6))
                      ],
                    ),
                    child: Center(
                        child: Text(c.gender == 'Girl' ? '👧' : '👦',
                            style: const TextStyle(fontSize: 44))),
                  ),
                  const SizedBox(height: 12),
                  Text(c.name,
                      style: const TextStyle(
                          fontFamily: 'PlayfairDisplay',
                          fontSize: 24,
                          color: SC.purpleDark)),
                  Text('${c.age} years old · ${c.gender}',
                      style:
                          const TextStyle(fontSize: 14, color: SC.textMuted)),
                  const SizedBox(height: 20),
                  SarthiCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('AUTISM PROFILE',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: SC.textMuted,
                                letterSpacing: 1)),
                        const SizedBox(height: 14),
                        _profileRow(
                          'Screening Result',
                          Row(children: [
                            SarthiBadge(
                                label: '${c.screeningRisk} Risk', color: rc),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () => Navigator.push(context,
                                  slideRoute(ScreeningResultScreen(child: c))),
                              child: const Text('View →',
                                  style: TextStyle(
                                      color: SC.purple,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800)),
                            ),
                          ]),
                        ),
                        const Divider(color: SC.border, height: 20),
                        _profileRow(
                            'Support Level',
                            SarthiBadge(
                                label: c.supportLevel, color: SC.skyDark)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  SarthiCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('CHALLENGE AREAS',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: SC.textMuted,
                                letterSpacing: 1)),
                        const SizedBox(height: 14),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: challenges.map((ch) {
                            final key = ch['key'] as String;
                            final sel = c.challenges.contains(key);
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 7),
                              decoration: BoxDecoration(
                                color: sel ? SC.lavLight : SC.bgAlt,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: sel ? SC.purple : SC.border,
                                    width: 1.5),
                              ),
                              child: Text(
                                '${ch['icon']} ${key[0].toUpperCase()}${key.substring(1)}',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: sel ? SC.purple : SC.textMuted),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  if (_editing) ...[
                    SarthiCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('THERAPY INFO (Optional)',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: SC.textMuted,
                                  letterSpacing: 1)),
                          const SizedBox(height: 14),
                          SarthiInput(
                              label: 'Therapist Name',
                              hint: 'e.g. Dr. Sunita Rao',
                              controller: _therapistCtrl),
                          SarthiInput(
                              label: 'Therapy Type',
                              hint: 'e.g. ABA, Speech Therapy',
                              controller: _therapyTypeCtrl),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                  ],
                  SarthiCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("THIS WEEK'S PROGRESS",
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: SC.textMuted,
                                letterSpacing: 1)),
                        const SizedBox(height: 14),
                        const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Activities completed',
                                  style: TextStyle(fontSize: 14)),
                              Text('8 / 12',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: SC.purple)),
                            ]),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: const LinearProgressIndicator(
                              value: 8 / 12,
                              backgroundColor: SC.border,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(SC.purple),
                              minHeight: 8),
                        ),
                        const SizedBox(height: 10),
                        const Text('Last logged: Today, 9:30 AM',
                            style:
                                TextStyle(fontSize: 12, color: SC.textMuted)),
                      ],
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

  Widget _profileRow(String label, Widget value) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
          value
        ],
      );
}
