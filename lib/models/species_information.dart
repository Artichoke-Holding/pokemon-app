class SpeciesInformation {
  final String name;
  final String shape;
  final String color;

  SpeciesInformation({
    required this.name,
    required this.shape,
    required this.color,
  });

  factory SpeciesInformation.fromJson(Map<String, dynamic> json) {
    String extractName(Map<String, dynamic> json, String key) {
      if (json[key] != null && json[key] is Map<String, dynamic>) {
        final value = json[key] as Map<String, dynamic>;
        return value['name'] as String? ?? 'N/A';
      }
      return 'N/A';
    }

    return SpeciesInformation(
      name: json['name'] as String? ?? 'N/A',
      shape: extractName(json, 'shape'),
      color: extractName(json, 'color'),
    );
  }
}
