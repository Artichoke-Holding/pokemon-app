import 'dart:io';
import 'package:flutter_soloud/flutter_soloud.dart';
import 'audio_service.dart';
import 'file_downloader.dart';

class SoloudAudioService extends AudioService {
  SoundProps? currentSound;

  @override
  Future<void> playCry(String url) async {
    final filePath = await FileDownloader.downloadFile(url);
    await play(filePath);
  }

  Future<void> initSoLoud() async {
    if (!SoLoud().isIsolateRunning()) {
      final result = await SoLoud().startIsolate();
      if (result != PlayerErrors.noError) {
      }
    }
  }

  Future<void> play(String filePath) async {
    await initSoLoud();

    final file = File(filePath);
    if (!await file.exists() || await file.length() == 0) {
      return;
    }

    if (currentSound != null) {
      await stopCurrentSound();
    }

    final newSound = await SoloudTools.loadFromFile(filePath);
    if (newSound == null) {
      return;
    }
    currentSound = newSound;

    final playResult = await SoLoud().play(currentSound!);
    if (playResult.error != PlayerErrors.noError) {
      currentSound = null;
    } else {
      currentSound = playResult.sound;
    }
  }

  Future<void> stopCurrentSound() async {
    if (currentSound != null && currentSound!.handle.isNotEmpty) {
      final int soundHandle = currentSound!.handle.first;

      final result = await SoLoud().stop(soundHandle);
      if (result != PlayerErrors.noError) {}

      await disposeSound();
    }
  }

  Future<void> disposeSound() async {
    if (currentSound != null) {
      final result = await SoLoud().disposeSound(currentSound!);
      if (result != PlayerErrors.noError) {}
      currentSound = null;
    }
  }

  @override
  Future<void> dispose() async {
    await stopCurrentSound();
    SoLoud().stopIsolate();
  }
}
