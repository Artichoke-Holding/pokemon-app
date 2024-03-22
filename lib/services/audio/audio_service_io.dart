
import 'package:audioplayers/audioplayers.dart';


import 'audio_service.dart';
import 'factory/audio_service_factory.dart'
if (dart.library.html) 'factory/audio_service_factory_web.dart';

class AudioServiceIO extends AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late final AudioService _audioService;

  AudioServiceIO() {
    _audioService = createAudioService();
  }

  @override
  Future<void> playCry(String url) async {
    await _audioService.playCry(url);
    _playWithAudioPlayers(url);
  }

  @override
  Future<void> stopCurrentSound() async {
    await _audioService.stopCurrentSound();
    await _audioPlayer.stop();
  }

  @override
  Future<void> dispose() async {
    await _audioService.dispose();
    _audioPlayer.dispose();
  }



  Future<void> _playWithAudioPlayers(String url) async {
    try {
      await _audioPlayer.play(UrlSource(url));
    } catch (e) {
      print('Failed to play sound: $e');
    }
  }
}
