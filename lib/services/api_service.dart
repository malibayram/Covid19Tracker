import 'dart:convert';

import 'package:http/http.dart' as http;

import './api.dart';
import '../models/statistics.dart';
import '../solid/a_cache_service.dart';

class APIService {
  const APIService({required this.api, required this.cacheService});
  final API api;
  final ACacheService cacheService;

  Future<void> getCountries() async {
    final uri = api.endpointUri(Endpoint.countries);

    final response = await http.get(
      uri,
      headers: {
        'x-rapidapi-host': api.host,
        'x-rapidapi-key': api.apiKey!,
      },
    );

    if (response.statusCode == 200) {
      List countryList = [];

      // Check if the response content type is json, otherwise create List from it.
      if (response.headers['content-type']?.contains('json') ?? false) {
        final jsonData = jsonDecode(response.body);
        countryList = jsonData['response'];
      }

      cacheService.saveCountryList(countryList);
    } else {
      throw response;
    }
  }

  Future<Statistics?> getStatistics(String country) async {
    final uri = api.endpointUri(Endpoint.statistics);

    final response = await http.get(
      uri.replace(query: 'country=$country'),
      headers: {
        'x-rapidapi-host': api.host,
        'x-rapidapi-key': api.apiKey!,
      },
    );

    if (response.statusCode == 200) {
      Statistics? statistics;

      // Check if the response content type is json, otherwise use another named constructor for object
      // to create object from it, like `Statistics.fromXML(jsonData['response'])`.
      if (response.headers['content-type']?.contains('json') ?? false) {
        final jsonData = jsonDecode(response.body);
        statistics = Statistics.fromJson(jsonData['response'][0]);
      }

      return statistics;
    } else {
      throw response;
    }
  }
}
