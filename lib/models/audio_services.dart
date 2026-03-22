import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _player = AudioPlayer();
  final FlutterTts _tts = FlutterTts();
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.45);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.2);
    _initialized = true;
  }

  Future<void> playCorrect() async {
    try {
      await _player.play(AssetSource('sounds/correct.mp3'));
    } catch (_) {
      // Sound file may not exist in dev — silently ignore
    }
  }

  Future<void> playFanfare() async {
    try {
      await _player.play(AssetSource('sounds/fanfare.mp3'));
    } catch (_) {}
  }

  Future<void> speakShape(String shapeName, String colorName) async {
    await _tts.stop();
    final text =
        colorName.isNotEmpty ? '$colorName $shapeName!' : '$shapeName!';
    await _tts.speak(text);
  }

  Future<void> speakText(String text) async {
    await _tts.stop();
    await _tts.speak(text);
  }

  void dispose() {
    // Don't dispose the singleton's player
    _player.stop();
    _tts.stop();
  }
}
