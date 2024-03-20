// providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/audio/audio_service.dart';
import '../services/pokemon_service.dart';
import '../viewmodels/pokemon_view_models.dart';

final pokemonViewModelProvider = ChangeNotifierProvider<PokemonViewModel>((ref) {
  return PokemonViewModel();
});

final pokemonServiceProvider = Provider<PokemonService>((ref) {
  return PokemonService();
});

final audioServiceProvider = Provider<AudioService>((ref) {
  return createAudioService(); // Use the factory method here
});

