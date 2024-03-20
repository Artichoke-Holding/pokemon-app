import 'package:flutter/material.dart';

import '../models/pokemon.dart';
import '../services/pokemon_service.dart';

class PokemonViewModel extends ChangeNotifier {
  final PokemonService _pokemonService = PokemonService();
  final List<Pokemon> pokemons = [];
  int _page = 0;
  final int _limit = 25;
  bool _hasMore = true;
  String? errorMessage;
  String currentSorting = 'None';
  bool get hasMore => _hasMore;

  PokemonViewModel() {
    fetchPokemons();
  }

  Future<void> fetchPokemons() async {
    try {
      List<Pokemon> newPokemons = await _pokemonService.fetchPokemons(_page, _limit);
      pokemons.addAll(newPokemons);


      if (currentSorting == 'Name') {
        sortByName();
      } else if (currentSorting == 'BaseExperience') {
        sortByBaseExperience();
      }

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

  void sortByName() {
    currentSorting = 'Name';
    pokemons.sort((a, b) => a.name!.compareTo(b.name!));
    notifyListeners();
  }

  void sortByBaseExperience() {
    currentSorting = 'BaseExperience';
    pokemons.sort((a, b) => a.baseExperience!.compareTo(b.baseExperience!));
    notifyListeners();
  }
}
