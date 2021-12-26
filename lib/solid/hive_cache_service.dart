import 'package:covid_19_tracker/models/statistics.dart';
import 'package:covid_19_tracker/solid/a_cache_service.dart';

class HiveCacheService implements ACacheService {
  @override
  Future<List<String>> getCountryList() {
    // TODO: implement getCountryList
    throw UnimplementedError();
  }

  @override
  Future<Statistics?> getStatistics(
      {required String country, required String dayString}) {
    // TODO: implement getStatistics
    throw UnimplementedError();
  }

  @override
  Future<void> saveCountryList(List countryList) {
    // TODO: implement saveCountryList
    throw UnimplementedError();
  }

  @override
  Future<void> saveStatistics(
      {required String country,
      required String dayString,
      required Statistics statistics}) {
    // TODO: implement saveStatistics
    throw UnimplementedError();
  }
}
