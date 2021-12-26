import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Endpoint {
  countries,
  statistics,
}

class API {
  final host = "covid-193.p.rapidapi.com";
  final apiKey = dotenv.env['RAPID_API_KEY'];

  Uri endpointUri(Endpoint endpoint) => Uri(
        scheme: 'https',
        host: host,
        path: _paths[endpoint],
      );

  final Map<Endpoint, String> _paths = {
    Endpoint.countries: 'countries',
    Endpoint.statistics: 'statistics',
  };
}
