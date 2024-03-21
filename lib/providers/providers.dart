// providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pokemon.dart';
import '../services/audio/audio_service.dart';
import '../services/audio/audio_service_factory.dart';
import '../services/pokemon_service.dart';
import '../services/user_service.dart';
import '../viewmodels/pokemon_view_models.dart';
import '../viewmodels/user_view_model.dart';

final pokemonViewModelProvider =
    ChangeNotifierProvider<PokemonViewModel>((ref) {
  return PokemonViewModel();
});

final pokemonServiceProvider = Provider<PokemonService>((ref) {
  return PokemonService();
});

// Updated provider to use AudioServiceImpl directly
final audioServiceProvider = Provider<AudioService>((ref) {
  return AudioServiceImpl();
});

final pokemonByIdProvider =
    FutureProvider.family<Pokemon, int>((ref, id) async {
  final pokemonService = ref.watch(pokemonServiceProvider);
  return await pokemonService.fetchPokemonById(id);
});

final usersViewModelProvider =
    ChangeNotifierProvider((ref) => UsersViewModel(UserService()));
final languageProvider = StateProvider<String>((ref) {
  return 'en';
});
