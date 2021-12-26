import '../models/statistics.dart';

abstract class ACacheService {
  Future<void> saveCountryList(List countryList);
  Future<List<String>> getCountryList();

  Future<Statistics?> getStatistics({
    required String country,
    required String dayString,
  });

  Future<void> saveStatistics({
    required String country,
    required String dayString,
    required Statistics statistics,
  });
}
