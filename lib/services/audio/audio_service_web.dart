import 'dart:async';
import 'dart:html' as html;
import 'audio_service.dart';

class AudioServiceWeb extends AudioService {
  html.AudioElement? _audioElement;
  AudioServiceWeb();
  // @override
  // static AudioServicePlatform create() => AudioServiceWeb();
  @override
  Future<void> playCry(String url) async {
    _audioElement?.pause();
    _audioElement = html.AudioElement(url)..play();
  }

  @override
  Future<void> stopCurrentSound() async {
    _audioElement?.pause();
    _audioElement = null;
  }

  @override
  Future<void> dispose() async {
    _audioElement?.pause();
    _audioElement = null;
  }

}
// AudioService createAudioService() => AudioServiceiceWeb();
