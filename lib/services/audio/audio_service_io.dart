import 'dart:io';
import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'audio_service.dart';

class AudioServiceIO extends AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int? currentSoundHandle; // For flutter_soloud

  AudioServiceIO() {
    if (Platform.isIOS) {
      _initSoLoud();
    }
  }

  Future<void> _initSoLoud() async {
    if (!SoLoud().isIsolateRunning()) {
      final result = await SoLoud().startIsolate();
      if (result != PlayerErrors.noError) {
        print('Failed to start SoLoud isolate: $result');
      }
    }
  }

  Future<String> downloadFile(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/audio.ogg');
    file.writeAsBytesSync(response.bodyBytes);
    return file.path;
  }

  Future<void> playCry(String url) async {
    if (Platform.isIOS) {
      // For iOS, use flutter_soloud
      final String filePath = await downloadFile(url);
      _playWithFlutterSoLoud(filePath);
    } else {
      // For other platforms, use audioplayers
      _playWithAudioPlayers(url);
    }
  }

  Future<void> _playWithFlutterSoLoud(String filePath) async {
    if (currentSoundHandle != null) {
      await SoLoud().stop(currentSoundHandle!);
      currentSoundHandle = null;
    }
    final sound = await SoloudTools.loadFromFile(filePath);
    if (sound == null) {
      print('Failed to load sound from file: $filePath');
      return;
    }
    final playResult = await SoLoud().play(sound);
    if (playResult.error == PlayerErrors.noError) {
      currentSoundHandle = playResult.newHandle;
    } else {
      print('Failed to play sound: ${playResult.error}');
    }
  }

  Future<void> _playWithAudioPlayers(String url) async {
    try {
      await _audioPlayer.play(UrlSource(url));
    } catch (e) {
      print('Failed to play sound: $e');
    }
  }

  Future<void> stopCurrentSound() async {
    if (Platform.isIOS && currentSoundHandle != null) {
      await SoLoud().stop(currentSoundHandle!);
      currentSoundHandle = null;
    } else {
      await _audioPlayer.stop();
    }
  }

  Future<void> dispose() async {
    if (Platform.isIOS) {
      await stopCurrentSound();
      SoLoud().stopIsolate();
    } else {
      _audioPlayer.dispose();
    }
  }
}
// AudioService createAudioService() => AudioServiceIO();
