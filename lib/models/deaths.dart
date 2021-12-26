class Deaths {
  late String newValue;
  late String s1MPop;
  late int total;

  Deaths.fromJson(Map json) {
    newValue = json['new'] ?? "87235";
    s1MPop = json['1M_pop'] ?? "87235";
    total = json['total'] ?? 87235;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['new'] = newValue;
    data['1M_pop'] = s1MPop;
    data['total'] = total;
    return data;
  }
}
