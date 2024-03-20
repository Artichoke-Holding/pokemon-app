class PokemonDetail {
  String? name;
  String? imageUrl;
  int? baseExperience;
  String? latestCryUrl;
  String? legacyCryUrl;

  // Additional fields can be added as needed

  PokemonDetail({this.name, this.imageUrl, this.baseExperience, this.latestCryUrl, this.legacyCryUrl});

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
      name: json['name'] as String?,
      imageUrl: json['sprites']['front_default'] as String?,
      baseExperience: json['base_experience'] as int?,
      latestCryUrl: json['cries']['latest'] as String?,
      legacyCryUrl: json['cries']['legacy'] as String?,
    );
  }
}
