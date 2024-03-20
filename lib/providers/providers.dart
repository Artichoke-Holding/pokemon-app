// providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pokemon.dart';
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
  return createAudioService();
});
final pokemonByIdProvider = FutureProvider.family<Pokemon, int>((ref, id) async {
  final pokemonService = ref.watch(pokemonServiceProvider);
  return await pokemonService.fetchPokemonById(id);
});

