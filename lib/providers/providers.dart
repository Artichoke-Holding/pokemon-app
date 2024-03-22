// providers.dart
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pokemon.dart';
import '../services/audio/audio_service.dart';
import '../services/audio/audio_service_default.dart';
import '../services/audio/audio_service_io.dart';
import '../services/pokemon_service.dart';
import '../services/user_service.dart';
import '../utils/platform_utils.dart';
import '../viewmodels/pokemon_view_models.dart';
import '../viewmodels/user_view_model.dart';

final pokemonViewModelProvider =
    ChangeNotifierProvider<PokemonViewModel>((ref) {
  return PokemonViewModel();
});

final pokemonServiceProvider = Provider<PokemonService>((ref) {
  return PokemonService();
});

final audioServiceProvider = Provider<AudioService>((ref) {
  if (PlatformUtils.isIOS()) {
    return AudioServiceIO();
  } else if (PlatformUtils.isWeb()) {
    return AudioServiceWeb();
  } else {
    return AudioServiceDefault();
  }
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
