class LastLogin {
  LastLogin({this.date, this.ip, this.device});

  LastLogin.fromJson(Map<String, dynamic> json) {
    date = json['date'] as String? ?? '';
    ip = json['ip'] as String? ?? '';
    device = json['device'] as String? ?? '';
  }

  String? date;
  String? ip;
  String? device;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date'] = date;
    data['ip'] = ip;
    data['device'] = device;
    return data;
  }

  @override
  String toString() {
    return 'LastLogin{'
        'date: $date, '
        'ip: $ip, '
        'device: $device, '
        '}';
  }
}
