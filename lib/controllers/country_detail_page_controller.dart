import 'package:covid_19_tracker/solid/hive_cache_service.dart';

import '../models/statistics.dart';
import '../services/api.dart';
import '../services/api_service.dart';
import '../services/cache_service.dart';

class CountryDetailPageController {
  final String country;
  Statistics? statistics;

  final _cacheServise = CacheService();
  final _apiServise = APIService(api: API(), cacheService: HiveCacheService());

  CountryDetailPageController({required this.country});

  Future<Statistics?> getStatistics() async {
    final now = DateTime.now();
    final dayString = "${now.day}-${now.month}-${now.year}";

    statistics = await _cacheServise.getStatistics(
        country: country, dayString: dayString);

    if (statistics == null) {
      statistics = await _apiServise.getStatistics(country);

      await _cacheServise.saveStatistics(
        country: country,
        dayString: dayString,
        statistics: statistics!,
      );
    }
    return statistics;
  }
}
