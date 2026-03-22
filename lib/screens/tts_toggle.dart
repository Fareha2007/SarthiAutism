import 'package:flutter/material.dart';

class TtsToggle extends StatelessWidget {
  final bool enabled;
  final ValueChanged<bool> onChanged;

  const TtsToggle({
    super.key,
    required this.enabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            '🗣️ Say name',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(width: 6),
          Switch.adaptive(
            value: enabled,
            activeColor: Colors.white,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
