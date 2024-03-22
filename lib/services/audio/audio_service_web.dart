import 'dart:async';
import 'audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioServiceWeb extends AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Future<void> playCry(String url) async {
    try {
      await _audioPlayer.setUrl(url);
      await _audioPlayer.play();
    } catch (e) {
      print("Could not play sound: $e");
    }
  }

  @override
  Future<void> stopCurrentSound() async {
    try {
      await _audioPlayer.stop();
    } catch (e) {
      print("Could not stop sound: $e");
    }
  }

  @override
  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}
