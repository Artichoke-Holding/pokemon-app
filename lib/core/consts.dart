class AppConsts{
  const AppConsts._();

  static const String dataPath = 'assets/data.json';
}

class AppAPIs{
  const AppAPIs._();

  static const String pokemonList = 'https://pokeapi.co/api/v2/pokemon/';
  static const String pokemonSpecies = 'https://pokeapi.co/api/v2/pokemon-species/';
  static String pokemonCries(int id) => 'https://pokeapi.co/api/v2/pokemon/$id/';
  static String pokemonSprites(int id) => 'https://pokeapi.co/api/v2/pokemon/$id/';
  static const String pokemonGeneral = 'https://pokeapi.co/api/v2/';
}
