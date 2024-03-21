// import 'audio_service_platform_interface.dart';
// export  'audio_service_io.dart'
// if (dart.library.html) 'audio_service_web.dart';
//
//
// abstract class AudioService {
// Future<void> playCry(String url);
// Future<void> stopCurrentSound();
// Future<void> dispose();
// }
//
//

// AudioService createAudioService() {
// return AudioServicePlatform.create();
// }

import 'dart:io';

import 'package:just_audio/just_audio.dart';


abstract class AudioService {
  Future<void> playCry(String url);
  Future<void> stopCurrentSound();
  Future<void> dispose();
}

class AudioServiceImpl extends AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Future<void> playCry(String url) async {
    try {
      await _audioPlayer.setUrl(url);
      _audioPlayer.play();
      print(url);
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  @override
  Future<void> stopCurrentSound() async {
    _audioPlayer.stop();
  }

  @override
  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}