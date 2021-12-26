class Tests {
  late String s1MPop;
  late int total;

  Tests.fromJson(Map json) {
    s1MPop = json['1M_pop'] ?? "87235";
    total = json['total'] ?? 87235;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['1M_pop'] = s1MPop;
    data['total'] = total;
    return data;
  }
}
