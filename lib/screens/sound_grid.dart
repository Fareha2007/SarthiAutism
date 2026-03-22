import 'package:flutter/material.dart';
import 'package:sarthi_flutter_project/screens/sound_data.dart';
import 'package:sarthi_flutter_project/screens/sound_card.dart';

class SoundGrid extends StatelessWidget {
  final SoundCategory category;
  final String? playingId;
  final Future<void> Function(SoundItem) onTap;

  const SoundGrid({
    super.key,
    required this.category,
    required this.playingId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 0.82,
      ),
      itemCount: category.sounds.length,
      itemBuilder: (context, index) {
        final sound = category.sounds[index];
        return SoundCard(
          sound: sound,
          accentColor: category.accentColor,
          isPlaying: playingId == sound.id,
          onTap: () => onTap(sound),
        );
      },
    );
  }
}
