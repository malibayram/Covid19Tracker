import 'package:hive/hive.dart';

import '../models/statistics.dart';
import '../utilities/strings.dart';

class CacheService {
  final _settingsBox = Hive.box(Strings.settings);
  final _statisticsBox = Hive.box(Strings.statistics);

  Future<void> saveCountryList(List countryList) async {
    await _settingsBox.put('countryList', countryList);
  }

  List getCountryList() {
    return _settingsBox.get('countryList', defaultValue: []);
  }

  Future<Statistics?> getStatistics({
    required String country,
    required String dayString,
  }) async {
    final Map statisticsMap =
        await _statisticsBox.get(country + dayString, defaultValue: {});

    if (statisticsMap.isNotEmpty) {
      return Statistics.fromJson(statisticsMap);
    }
  }

  Future<void> saveStatistics({
    required String country,
    required String dayString,
    required Statistics statistics,
  }) async {
    await _statisticsBox.put(country + dayString, statistics.toJson());
    await _settingsBox.put('country', country);
  }
}
