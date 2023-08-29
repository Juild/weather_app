import 'package:get/get.dart';
import 'package:weather_app/repositories/weather_repository.dart';

import '../vms/city_weather_vm.dart';

// home page controller (prints for demonstration in production user logger)
class HomeController extends GetxController {
  final repo = WeatherAppRepository();
  var cityWeathers = [].obs;
  Future<void> addCityWeathers(String text) async {
    final response = await repo.searchCities(searchText: text);
    response.fold(
      (error) {
        // handle error
      },
      (searchResults) async {
        cityWeathers.clear();
        for (final geoResult in searchResults.results) {
          print("NAME: ${geoResult.name}");

          final response = await repo.getWeatherLatLon(
              latitude: geoResult.latitude.toString(), longitude: geoResult.longitude.toString());
          response.fold(
            (error) {
              print("error with getWeatherLatLon response $error");
            },
            (cityWeather) {
              cityWeathers.add(
                CityWeatherVM(
                  name: geoResult.name,
                  country: geoResult.country,
                  temperature: cityWeather.currentWeather.temperature,
                  windspeed: cityWeather.currentWeather.windspeed,
                ),
              );
              print("LIST weather: \n $cityWeathers");
            },
          );
        }
      },
    );
  }
}
