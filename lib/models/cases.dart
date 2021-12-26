class Cases {
  late String newValue;
  late int active;
  late int critical;
  late int recovered;
  late String s1MPop;
  late int total;

  Cases.fromJson(Map json) {
    newValue = json['new'] ?? "87235";
    active = json['active'] ?? 87235;
    critical = json['critical'] ?? 87235;
    recovered = json['recovered'] ?? 87235;
    s1MPop = json['1M_pop'] ?? "87235";
    total = json['total'] ?? 87235;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['new'] = newValue;
    data['active'] = active;
    data['critical'] = critical;
    data['recovered'] = recovered;
    data['1M_pop'] = s1MPop;
    data['total'] = total;
    return data;
  }
}
