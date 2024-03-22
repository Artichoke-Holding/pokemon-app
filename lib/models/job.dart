class Job {
  Job({this.title, this.descriptor, this.area, this.type, this.company});

  Job.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String? ?? '';
    descriptor = json['descriptor'] as String? ?? '';
    area = json['area'] as String? ?? '';
    type = json['type'] as String? ?? '';
    company = json['company'] as String? ?? '';
  }

  String? title;
  String? descriptor;
  String? area;
  String? type;
  String? company;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['descriptor'] = descriptor;
    data['area'] = area;
    data['type'] = type;
    data['company'] = company;
    return data;
  }

  @override
  String toString() {
    return 'Job{'
        'title: $title, '
        'descriptor: $descriptor, '
        'area: $area, '
        'type: $type, '
        'company: $company, '
        '}';
  }
}
