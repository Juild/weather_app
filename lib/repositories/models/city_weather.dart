class CityWeather {
  final CurrentWeather currentWeather;

  CityWeather({
    required this.currentWeather,
  });

  factory CityWeather.fromJson(Map<String, dynamic> json) => CityWeather(
        currentWeather: CurrentWeather.fromJson(json["current_weather"]),
      );
}

class CurrentWeather {
  final double temperature;
  final double windspeed;
  final int winddirection;
  final int weathercode;
  final int isDay;
  final String time;

  CurrentWeather({
    required this.temperature,
    required this.windspeed,
    required this.winddirection,
    required this.weathercode,
    required this.isDay,
    required this.time,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) => CurrentWeather(
        temperature: json["temperature"],
        windspeed: json["windspeed"],
        winddirection: json["winddirection"],
        weathercode: json["weathercode"],
        isDay: json["is_day"],
        time: json["time"],
      );
}
