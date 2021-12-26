enum Endpoint {
  countries,
  statistics,
}

class API {
  final host = "covid-193.p.rapidapi.com";
  final apiKey = "7514c59p16793ejsn6aa0e35fe867";

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
