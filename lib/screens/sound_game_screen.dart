import 'package:flutter/material.dart';
import 'package:sarthi_flutter_project/screens/audio_service.dart';
import 'package:sarthi_flutter_project/screens/sound_data.dart';
import 'package:sarthi_flutter_project/screens/sound_game_header.dart';
import 'package:sarthi_flutter_project/screens/tts_toggle.dart';
import 'package:sarthi_flutter_project/screens/sound_tab_bar.dart';
import 'package:sarthi_flutter_project/screens/sound_grid.dart';

class SoundGameScreen extends StatefulWidget {
  const SoundGameScreen({super.key});

  @override
  State<SoundGameScreen> createState() => _SoundGameScreenState();
}

class _SoundGameScreenState extends State<SoundGameScreen>
    with TickerProviderStateMixin {
  int _selectedTab = 0;
  String? _playingId;
  late TabController _tabController;
  final _audio = SoundAudioService();
  final List<SoundCategory> categories = SoundData.categories;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _audio.stop();
        setState(() {
          _selectedTab = _tabController.index;
          _playingId = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _audio.dispose();
    super.dispose();
  }

  Future<void> _onCardTap(SoundItem sound) async {
    if (_playingId == sound.id) {
      await _audio.stop();
      setState(() => _playingId = null);
      return;
    }
    setState(() => _playingId = sound.id);
    await _audio.play(sound.id, sound.audioAsset, sound.name);
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted && _playingId == sound.id) {
        setState(() => _playingId = null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final category = categories[_selectedTab];
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [category.bgColor1, category.bgColor2],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SoundGameHeader(onBack: () => Navigator.pop(context)),
              TtsToggle(
                enabled: _audio.ttsEnabled,
                onChanged: (val) => setState(() => _audio.ttsEnabled = val),
              ),
              SoundTabBar(
                controller: _tabController,
                categories: categories,
                selectedTab: _selectedTab,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: categories
                      .map((cat) => SoundGrid(
                            category: cat,
                            playingId: _playingId,
                            onTap: _onCardTap,
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
