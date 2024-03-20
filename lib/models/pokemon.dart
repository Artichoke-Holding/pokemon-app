class Pokemon {
  Pokemon({
    this.id,
    this.name,
    this.imageUrl,
    this.baseExperience,
    this.cryUrl,
    this.abilities = const [],
    this.moves = const [],
    this.types = const [],
    this.height,
    this.weight,
    this.locationAreaEncounters,
    this.spriteUrls = const [],
  });


  factory Pokemon.fromJson(Map<String, dynamic> json) {
    List<String> sprites = [];
    void addSprite(String? url) {
      if (url != null) sprites.add(url);
    }


    var spriteData = json['sprites'] as Map<String, dynamic>? ?? {};
    addSprite(spriteData['front_default'] as String?);
    addSprite(spriteData['back_default'] as String?);
    addSprite(spriteData['front_shiny'] as String?);
    addSprite(spriteData['back_shiny'] as String?);


    return Pokemon(
      id: json['id'] as int?,
      name: json['name'] as String?,
      imageUrl: json['sprites']['front_default'] as String?,
      baseExperience: json['base_experience'] as int?,
      cryUrl: json['cries']['latest'] as String?,
      abilities: (json['abilities'] as List<dynamic>?)
              ?.map((e) => e['ability']['name'] as String)
              .toList() ??
          [],
      moves: (json['moves'] as List<dynamic>?)
              ?.map((e) => e['move']['name'] as String)
              .toList() ??
          [],
      types: (json['types'] as List<dynamic>?)
              ?.map((e) => e['type']['name'] as String)
              .toList() ??
          [],
      height: json['height'] as int?,
      weight: json['weight'] as int?,
      locationAreaEncounters: json['location_area_encounters'] as String?,
      spriteUrls: sprites,
    );
  }

  final int? id;
  final String? name;
  final String? imageUrl;
  final int? baseExperience;
  final String? cryUrl;
  final List<String> abilities;
  final List<String> moves;
  final List<String> types;
  final int? height;
  final int? weight;
  final String? locationAreaEncounters;
  final List<String> spriteUrls;
}
