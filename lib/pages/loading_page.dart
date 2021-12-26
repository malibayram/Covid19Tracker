import 'package:covid_19_tracker/solid/hive_cache_service.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_listener/hive_listener.dart';

import './country_detail_page.dart';
import '../controllers/country_detail_page_controller.dart';
import '../services/api.dart';
import '../services/api_service.dart';
import '../services/cache_service.dart';
import '../utilities/strings.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HiveListener<dynamic>(
      box: Hive.box(Strings.settings),
      keys: const ['countryList', 'country'],
      builder: (box) {
        final String country = box.get('country', defaultValue: "USA");
        final List countryList = box.get('countryList', defaultValue: []);

        if (countryList.isEmpty) {
          APIService(api: API(), cacheService: HiveCacheService())
              .getCountries();

          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return CountryDetailPage(
          controller: CountryDetailPageController(country: country),
        );
      },
    );
  }
}
