class Name {
  Name({this.first, this.middle, this.last});

  Name.fromJson(Map<String, dynamic> json) {
    first = json['first'] as String? ?? '';
    middle = json['middle'] as String? ?? '';
    last = json['last'] as String? ?? '';
  }

  String? first;
  String? middle;
  String? last;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['first'] = first;
    data['middle'] = middle;
    data['last'] = last;
    return data;
  }

  @override
  String toString() {
    return 'Name{'
        'first: $first, '
        'middle: $middle, '
        'last: $last, '
        '}';
  }
}