import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';
import '../core/consts.dart';


class PokemonService {
  Future<List<Pokemon>> fetchPokemons(int page, int limit) async {
    var url = Uri.parse('${AppAPIs.pokemonList}?limit=$limit&offset=${page * limit}');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse is Map<String, dynamic> && jsonResponse['results'] is List) {
        List<dynamic> pokemonsJson = jsonResponse['results'] as List<dynamic>;
        List<Pokemon> pokemons = await Future.wait(pokemonsJson.map((jsonItem) async {
          if (jsonItem is Map<String, dynamic>) {
            var detailUrl = jsonItem['url'] as String; // Cast to String
            var detailResponse = await http.get(Uri.parse(detailUrl));
            if (detailResponse.statusCode == 200) {
              var detailJson = jsonDecode(detailResponse.body) as Map<String, dynamic>;
              return Pokemon.fromJson(detailJson);
            } else {
              throw Exception('Failed to load Pokémon details');
            }
          } else {
            throw Exception('Invalid JSON data');
          }
        }).toList());

        return pokemons;
      } else {
        throw Exception('Invalid JSON format');
      }
    } else {
      throw Exception('Failed to load Pokémon list');
    }
  }


  Future<Pokemon> fetchPokemonById(int id) async {
    var url = Uri.parse(AppAPIs.pokemonList + id.toString());
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var detailJson = jsonDecode(response.body) as Map<String, dynamic>;
      return Pokemon.fromJson(detailJson);
    } else {
      throw Exception('Failed to load Pokémon details for ID: $id');
    }
  }
}

