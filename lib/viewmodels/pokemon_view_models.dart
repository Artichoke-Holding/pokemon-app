import 'package:flutter/material.dart';
import '../core/consts.dart';

import '../models/pokemon.dart';
import '../services/pokemon_service.dart';

class PokemonViewModel extends ChangeNotifier {
  final PokemonService _pokemonService = PokemonService();
  final List<Pokemon> pokemons = [];
  int _page = 0;
  final int _limit = 25;
  bool _hasMore = true;
  String? errorMessage;

  bool get hasMore => _hasMore;

  PokemonViewModel() {
    fetchPokemons();
  }

  Future<void> fetchPokemons() async {
    try {
      List<Pokemon> newPokemons = await _pokemonService.fetchPokemons(_page, _limit);
      pokemons.addAll(newPokemons);

      if (newPokemons.length < _limit) {
        _hasMore = false;
      }
    } catch (e) {
      errorMessage = e.toString();
      _hasMore = false;
    }

    _page++;
    notifyListeners();
  }
}


