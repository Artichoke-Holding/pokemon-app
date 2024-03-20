import 'audio_service_io.dart';
import 'audio_service_stub.dart'
if (dart.library.io) 'audio_service_io.dart'
if (dart.library.html) 'audio_service_web.dart';

abstract class AudioService {
  Future<void> playCry(String url);
  Future<void> stopCurrentSound();
  Future<void> dispose();
}

AudioService createAudioService() {
  return AudioServiceIO(); // This will call the correct platform-specific function.
}
