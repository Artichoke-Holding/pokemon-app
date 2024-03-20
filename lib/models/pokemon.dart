class Pokemon {

  Pokemon({this.name, this.imageUrl, this.baseExperience, this.cryUrl});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'] as String?,
      imageUrl: json['sprites']['front_default'] as String?,
      baseExperience: json['base_experience'] as int?,
      cryUrl: json['cries']['latest'] as String?,
    );
  }
  final String? name;
  final String? imageUrl;
  final int? baseExperience;
  final String? cryUrl;
}
