
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/colors.dart';
import '../widgets/widgets.dart';
import '../models/models.dart';

class TrackingScreen extends StatefulWidget {
  final ChildProfile child;
  const TrackingScreen({super.key, required this.child});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  final Map<String, int> _vals = {
    'sleep': 3,
    'food': 3,
    'communication': 3,
    'meltdowns': 0,
    'social': 3,
  };

  final _notesCtrl = TextEditingController();
  bool _saved = false;
  bool _loading = true;

  final _metrics = [
    {'key': 'sleep', 'label': 'Sleep Quality', 'icon': '😴'},
    {'key': 'food', 'label': 'Food Intake', 'icon': '🍽️'},
    {'key': 'communication', 'label': 'Communication', 'icon': '💬'},
    {'key': 'meltdowns', 'label': 'Meltdowns (count)', 'icon': '🌊'},
    {'key': 'social', 'label': 'Social Response', 'icon': '🤝'},
  ];

  final _labels = {
    'sleep': ['', 'Very Poor', 'Poor', 'Average', 'Good', 'Excellent'],
    'food': ['', 'None', 'Very Little', 'Average', 'Good', 'All Eaten'],
    'communication': ['', 'None', 'Minimal', 'Some', 'Good', 'Excellent'],
    'meltdowns': ['None', '1×', '2×', '3×', '4×', '5+'],
    'social': ['', 'None', 'Minimal', 'Some', 'Good', 'Excellent'],
  };

  String get _todayKey {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    _loadTodayLog();
  }

  @override
  void dispose() {
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadTodayLog() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      setState(() => _loading = false);
      return;
    }

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('logs')
          .doc(_todayKey)
          .get()
          .timeout(const Duration(seconds: 5)); // ← add timeout

      if (doc.exists && mounted) {
        final data = doc.data()!;
        setState(() {
          _vals['sleep'] = (data['sleep'] as num?)?.toInt() ?? 3;
          _vals['food'] = (data['food'] as num?)?.toInt() ?? 3;
          _vals['communication'] =
              (data['communication'] as num?)?.toInt() ?? 3;
          _vals['meltdowns'] = (data['meltdowns'] as num?)?.toInt() ?? 0;
          _vals['social'] = (data['social'] as num?)?.toInt() ?? 3;
          _notesCtrl.text = data['notes'] as String? ?? '';
        });
      }
    } catch (e) {
      debugPrint('❌ Load log error: $e'); // ← will show why it's failing
    } finally {
      if (mounted) setState(() => _loading = false); // ← always stop loading
    }
  }
  
  Future<void> _saveTodayLog() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('logs')
          .doc(_todayKey)
          .set({
        'sleep': _vals['sleep'],
        'food': _vals['food'],
        'communication': _vals['communication'],
        'meltdowns': _vals['meltdowns'],
        'social': _vals['social'],
        'notes': _notesCtrl.text.trim(),
        'date': _todayKey,
      });
      debugPrint('✅ Log saved for $_todayKey');
    } catch (e) {
      debugPrint('❌ Save log error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
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
    final days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    final dateStr =
        '${days[now.weekday - 1]}, ${now.day} ${months[now.month - 1]}';

    if (_loading) {
      return const GradScaffold(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return GradScaffold(
      child: Column(
        children: [
          const SarthiTopBar(title: 'Daily Log', showBack: false),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dateStr,
                      style: const TextStyle(
                          fontSize: 13,
                          color: SC.textMuted,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 16),
                  ..._metrics.map((m) {
                    final key = m['key'] as String;
                    final val = _vals[key]!;
                    final lbl = _labels[key]![val];
                    final isMeltdown = key == 'meltdowns' && val > 2;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: SarthiCard(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${m['icon']} ${m['label']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15)),
                                SarthiBadge(
                                    label: lbl,
                                    color: isMeltdown ? SC.red : SC.purple),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: List.generate(6, (v) {
                                final sel = val == v;
                                return Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(() => _vals[key] = v),
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 180),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: sel ? SC.purple : SC.bgAlt,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: sel
                                            ? [
                                                BoxShadow(
                                                    color: SC.purple
                                                        .withOpacity(0.3),
                                                    blurRadius: 6,
                                                    offset: const Offset(0, 2))
                                              ]
                                            : [],
                                      ),
                                      child: Center(
                                        child: Text('$v',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w800,
                                                color: sel
                                                    ? Colors.white
                                                    : SC.textMuted)),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  SarthiCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('📝 Notes',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 15)),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _notesCtrl,
                          maxLines: 4,
                          style:
                              const TextStyle(fontSize: 14, color: SC.textDark),
                          decoration: InputDecoration(
                            hintText:
                                'Any observations, triggers, or wins today...',
                            hintStyle: const TextStyle(
                                color: SC.textMuted, fontSize: 13),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: SC.border)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: SC.purple, width: 1.5)),
                            fillColor: SC.bgLight,
                            filled: true,
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SarthiButton(
                    label: _saved ? '✅ Saved!' : 'Save Today\'s Log',
                    color: _saved ? SC.green : SC.btnColor,
                    onPressed: () async {
                      await _saveTodayLog();
                      setState(() => _saved = true);
                      Future.delayed(const Duration(seconds: 2), () {
                        if (mounted) setState(() => _saved = false);
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
