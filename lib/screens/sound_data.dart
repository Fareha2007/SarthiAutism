import 'package:flutter/material.dart';

class SoundItem {
  final String id;
  final String emoji;
  final String name;
  final String audioAsset;

  const SoundItem({
    required this.id,
    required this.emoji,
    required this.name,
    required this.audioAsset,
  });
}

class SoundCategory {
  final String name;
  final String emoji;
  final Color accentColor;
  final Color bgColor1;
  final Color bgColor2;
  final List<SoundItem> sounds;

  const SoundCategory({
    required this.name,
    required this.emoji,
    required this.accentColor,
    required this.bgColor1,
    required this.bgColor2,
    required this.sounds,
  });
}

class SoundData {
  static final List<SoundCategory> categories = [
    SoundCategory(
      name: 'Animals',
      emoji: '🐾',
      accentColor: const Color(0xFFFF7043),
      bgColor1: const Color(0xFFFFE0B2),
      bgColor2: const Color(0xFFFFCCBC),
      sounds: const [
        SoundItem(
            id: 'dog',
            emoji: '🐶',
            name: 'Dog',
            audioAsset: 'assets/sounds/dog.mp3'),
        SoundItem(
            id: 'cat',
            emoji: '🐱',
            name: 'Cat',
            audioAsset: 'assets/sounds/cat.mp3'),
        SoundItem(
            id: 'cow',
            emoji: '🐮',
            name: 'Cow',
            audioAsset: 'assets/sounds/cow.mp3'),
        SoundItem(
            id: 'duck',
            emoji: '🦆',
            name: 'Duck',
            audioAsset: 'assets/sounds/duck.mp3'),
        SoundItem(
            id: 'lion',
            emoji: '🦁',
            name: 'Lion',
            audioAsset: 'assets/sounds/lion.mp3'),
        SoundItem(
            id: 'elephant',
            emoji: '🐘',
            name: 'Elephant',
            audioAsset: 'assets/sounds/elephant.mp3'),
        SoundItem(
            id: 'frog',
            emoji: '🐸',
            name: 'Frog',
            audioAsset: 'assets/sounds/frog.mp3'),
        SoundItem(
            id: 'bird',
            emoji: '🐦',
            name: 'Bird',
            audioAsset: 'assets/sounds/bird.mp3'),
      ],
    ),
    SoundCategory(
      name: 'Nature',
      emoji: '🌍',
      accentColor: const Color(0xFF43A047),
      bgColor1: const Color(0xFFC8E6C9),
      bgColor2: const Color(0xFFB2DFDB),
      sounds: const [
        SoundItem(
            id: 'rain',
            emoji: '🌧️',
            name: 'Rain',
            audioAsset: 'assets/sounds/rain.mp3'),
        SoundItem(
            id: 'thunder',
            emoji: '⛈️',
            name: 'Thunder',
            audioAsset: 'assets/sounds/thunder.mp3'),
        SoundItem(
            id: 'wind',
            emoji: '💨',
            name: 'Wind',
            audioAsset: 'assets/sounds/wind.mp3'),
        SoundItem(
            id: 'ocean',
            emoji: '🌊',
            name: 'Ocean',
            audioAsset: 'assets/sounds/ocean.mp3'),
        SoundItem(
            id: 'fire',
            emoji: '🔥',
            name: 'Fire',
            audioAsset: 'assets/sounds/fire.mp3'),
      ],
    ),
    SoundCategory(
      name: 'Home',
      emoji: '🏠',
      accentColor: const Color(0xFF1E88E5),
      bgColor1: const Color(0xFFBBDEFB),
      bgColor2: const Color(0xFFB3E5FC),
      sounds: const [
        SoundItem(
            id: 'doorbell',
            emoji: '🔔',
            name: 'Doorbell',
            audioAsset: 'assets/sounds/doorbell.mp3'),
        SoundItem(
            id: 'phone',
            emoji: '📞',
            name: 'Phone',
            audioAsset: 'assets/sounds/phone.mp3'),
        SoundItem(
            id: 'clock',
            emoji: '🕐',
            name: 'Clock',
            audioAsset: 'assets/sounds/clock.mp3'),
        SoundItem(
            id: 'flush',
            emoji: '🚽',
            name: 'Flush',
            audioAsset: 'assets/sounds/flush.mp3'),
        SoundItem(
            id: 'knock',
            emoji: '🚪',
            name: 'Knock',
            audioAsset: 'assets/sounds/knock.mp3'),
      ],
    ),
    SoundCategory(
      name: 'Music',
      emoji: '🎵',
      accentColor: const Color(0xFF8E24AA),
      bgColor1: const Color(0xFFE1BEE7),
      bgColor2: const Color(0xFFF8BBD0),
      sounds: const [
        SoundItem(
            id: 'drum',
            emoji: '🥁',
            name: 'Drum',
            audioAsset: 'assets/sounds/drum.mp3'),
        SoundItem(
            id: 'bell',
            emoji: '🔔',
            name: 'Bell',
            audioAsset: 'assets/sounds/bell.mp3'),
        SoundItem(
            id: 'guitar',
            emoji: '🎸',
            name: 'Guitar',
            audioAsset: 'assets/sounds/guitar.mp3'),
        SoundItem(
            id: 'piano',
            emoji: '🎹',
            name: 'Piano',
            audioAsset: 'assets/sounds/piano.mp3'),
        SoundItem(
            id: 'xylophone',
            emoji: '🎼',
            name: 'Xylophone',
            audioAsset: 'assets/sounds/xylophone.mp3'),
      ],
    ),
  ];
}
