import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';
import '../core/consts.dart';
import '../models/species_information.dart';

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

class DataFormatException implements Exception {
  final String message;
  DataFormatException(this.message);

  @override
  String toString() => 'DataFormatException: $message';
}

class PokemonService {
  Future<List<Pokemon>> fetchPokemons(int page, int limit) async {
    try {
      var url = Uri.parse('${AppAPIs.pokemonList}?limit=$limit&offset=${page * limit}');
      var response = await http.get(url);

      if (response.statusCode != 200) {
        throw NetworkException('Failed to load Pokémon list');
      }

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse is Map<String, dynamic> && jsonResponse['results'] is List) {
        List<dynamic> pokemonsJson = jsonResponse['results'] as List<dynamic>;
        return await Future.wait(pokemonsJson.map((jsonItem) async {
          if (jsonItem is Map<String, dynamic>) {
            var detailUrl = jsonItem['url'] as String;
            var detailResponse = await http.get(Uri.parse(detailUrl));
            if (detailResponse.statusCode != 200) {
              throw NetworkException('Failed to load Pokémon details');
            }

            return Pokemon.fromJson(jsonDecode(detailResponse.body) as Map<String, dynamic>);
          } else {
            throw DataFormatException('Invalid JSON data for Pokémon details');
          }
        }).toList());
      } else {
        throw DataFormatException('Invalid JSON format for Pokémon list');
      }
    } on Exception catch (e) {
      // Handle any other type of unexpected error
      throw NetworkException('An error occurred: $e');
    }
  }

  Future<Pokemon> fetchPokemonById(int id) async {
    try {
      var url = Uri.parse(AppAPIs.pokemonList + id.toString());
      var response = await http.get(url);

      if (response.statusCode != 200) {
        throw NetworkException('Failed to load Pokémon details for ID: $id');
      }

      return Pokemon.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } on FormatException {
      throw DataFormatException('Invalid JSON format for Pokémon details');
    } on Exception {
      throw NetworkException('Network error occurred while fetching Pokémon by ID');
    }
  }

  Future<SpeciesInformation> fetchSpeciesInformation(int pokemonId) async {
    try {
      final response = await http.get(Uri.parse(AppAPIs.pokemonSpecies + '$pokemonId'));

      if (response.statusCode != 200) {
        throw NetworkException('Failed to load species information for Pokémon ID: $pokemonId');
      }

      return SpeciesInformation.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } on FormatException {
      throw DataFormatException('Invalid JSON format for species information');
    } on Exception {
      throw NetworkException('Network error occurred while fetching species information');
    }
  }
}
