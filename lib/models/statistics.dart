import './cases.dart';
import './deaths.dart';
import './tests.dart';

class Statistics {
  late String continent;
  late String country;
  late int population;
  late Cases? cases;
  late Deaths? deaths;
  late Tests? tests;
  late DateTime day;
  late String time;

  Statistics.fromJson(Map json) {
    final dayStringParts =
        "${json['day']}".split('-').map((e) => int.parse(e)).toList();

    continent = json['continent'];
    country = json['country'];
    population = json['population'];
    cases = json['cases'] != null ? Cases.fromJson(json['cases']) : null;
    deaths = json['deaths'] != null ? Deaths.fromJson(json['deaths']) : null;
    tests = json['tests'] != null ? Tests.fromJson(json['tests']) : null;
    day = DateTime(dayStringParts[0], dayStringParts[1], dayStringParts[2]);
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['continent'] = continent;
    data['country'] = country;
    data['population'] = population;

    data['cases'] = cases?.toJson();
    data['deaths'] = deaths?.toJson();
    data['tests'] = tests?.toJson();

    data['day'] = "${day.year}-${day.month}-${day.day}";
    data['time'] = time;
    return data;
  }
}
