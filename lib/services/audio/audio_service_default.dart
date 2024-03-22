import 'audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioServiceDefault extends AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Future<void> playCry(String url) async {
    try {
      await _audioPlayer.setUrl(url);
      await _audioPlayer.play();
    } catch (e) {
    }
  }

  @override
  Future<void> stopCurrentSound() async {
    try {
      await _audioPlayer.stop();
    } catch (e) {
    }
  }

  @override
  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}
