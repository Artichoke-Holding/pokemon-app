class Location {
  Location({
    this.street,
    this.city,
    this.state,
    this.country,
    this.zip,
  });

  Location.fromJson(Map<String, dynamic> json) {
    street = json['street'] as String? ?? '';
    city = json['city'] as String? ?? '';
    state = json['state'] as String? ?? '';
    country = json['country'] as String? ?? '';
    zip = json['zip'] as String? ?? '';
  }

  String? street;
  String? city;
  String? state;
  String? country;
  String? zip;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['street'] = street;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['zip'] = zip;

    return data;
  }

  @override
  String toString() {
    return 'Location{'
        'street: $street, '
        'city: $city, '
        'state: $state, '
        'country: $country, '
        'zip: $zip, '
        '}';
  }
}
