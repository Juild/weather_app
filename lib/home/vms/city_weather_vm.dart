// visual representation of the CityWeather (CurrentWeather type) to separate models from views
class CityWeatherVM {
  final String name;
  final double temperature;
  final double windspeed;
  final String country;

  CityWeatherVM({
    required this.name,
    required this.temperature,
    required this.windspeed,
    required this.country,
  });
}
