import 'dart:io';

import 'package:covid_19_tracker/services/api.dart';
import 'package:covid_19_tracker/services/api_service.dart';
import 'package:covid_19_tracker/services/cache_service.dart';
import 'package:covid_19_tracker/solid/hive_cache_service.dart';
import 'package:covid_19_tracker/utilities/strings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void initHive() {
  var path = Directory.current.path;
  Hive.init(path + '/test/hive_testing_path');
}

void main() async {
  HiveCacheService cacheService;
  APIService apiService;

  String? country;
  List<String>? countryList;

  final now = DateTime.now();
  final dayString = "${now.day}-${now.month}-${now.year}";

  initHive();

  final settingsBox = await Hive.openBox(Strings.settings);
  final statisticsBox = await Hive.openBox(Strings.statistics);

  group("test of the services", () {
    test("test open hive boxes", () async {
      country = settingsBox.get('country', defaultValue: "USA");
      countryList = settingsBox.get('countryList', defaultValue: []);

      expect(settingsBox.isOpen, true);
      expect(statisticsBox.isOpen, true);
      expect(country, "USA");
      expect(countryList, []);
    });

    cacheService = HiveCacheService();
    test("test null statistics from cacheService", () async {
      final statistics = await cacheService.getStatistics(
          country: country!, dayString: dayString);

      expect(statistics, null);
    });

    apiService = APIService(api: API(), cacheService: cacheService);

    test("test getCountryList method from api service and change country",
        () async {
      await apiService.getCountries();

      final countryList = await cacheService.getCountryList();

      countryList.shuffle();

      country = countryList.first;

      expect(countryList.isNotEmpty, true);
      expect(country != "USA", true);
    });

    test("test getCountryList method from api service", () async {
      await apiService.getCountries();

      final countryList = await cacheService.getCountryList();

      expect(countryList.isNotEmpty, true);
    });
    test("test getStatistics method from api service", () async {
      final statistics = await apiService.getStatistics(country!);

      await cacheService.saveStatistics(
          country: country!, dayString: dayString, statistics: statistics!);

      expect(statistics.country, country);
    });

    test("test non null statistics from cacheService", () async {
      final statistics = await cacheService.getStatistics(
          country: country!, dayString: dayString);

      expect(statistics, isNotNull);
    });

    test("test remove test hive files from computer", () async {
      await settingsBox.deleteFromDisk();
      await statisticsBox.deleteFromDisk();

      expect(settingsBox.isOpen, false);
      expect(statisticsBox.isOpen, false);
    });
  });
}
