import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// Manages audio playback and optional TTS for the Sound Explorer.
class SoundAudioService {
  static final SoundAudioService _instance = SoundAudioService._internal();
  factory SoundAudioService() => _instance;
  SoundAudioService._internal();

  final AudioPlayer _player = AudioPlayer();
  final FlutterTts _tts = FlutterTts();

  bool ttsEnabled = true;
  String? _currentId;
  String? _currentLabel;

  Future<void> init() async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1.1);
    await _tts.setVolume(1.0);
    _player.onPlayerComplete.listen((_) async {
      if (ttsEnabled && _currentLabel != null) {
        await Future.delayed(const Duration(milliseconds: 300));
        await _tts.speak(_currentLabel!);
      }
    });
  }

  /// Play [assetPath] sound. Pass [label] for TTS announcement after playback.
  Future<void> play(String id, String assetPath, String label) async {
    await _player.stop();
    await _tts.stop();
    _currentId = id;
    _currentLabel = label;
    await _player.play(AssetSource(assetPath.replaceFirst('assets/', '')));
  }

  /// Stop current playback.
  Future<void> stop() async {
    _currentId = null;
    _currentLabel = null;
    await _player.stop();
    await _tts.stop();
  }

  String? get currentId => _currentId;

  void dispose() {
    _player.dispose();
    _tts.stop();
  }
}
