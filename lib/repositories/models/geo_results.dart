class SearchResults {
  final List<GeoResult> results;
  final double generationtimeMs;

  SearchResults({
    required this.results,
    required this.generationtimeMs,
  });

  factory SearchResults.fromJson(Map<String, dynamic> json) => SearchResults(
        results: List<GeoResult>.from(json["results"].map((x) => GeoResult.fromJson(x))),
        generationtimeMs: json["generationtime_ms"],
      );
}

class GeoResult {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final double elevation;
  final String country;

  GeoResult({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.elevation,
    required this.country,
  });

  factory GeoResult.fromJson(Map<String, dynamic> json) => GeoResult(
        id: json["id"],
        name: json["name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        elevation: json["elevation"],
        country: json["country"],
      );
}
