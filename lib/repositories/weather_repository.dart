import 'package:dartz/dartz.dart';
import 'package:weather_app/repositories/client.dart';
import 'package:weather_app/repositories/models/city_weather.dart';
import 'package:weather_app/repositories/models/geo_results.dart';
import 'dart:convert';

abstract class IWeatherAppRepository {
  Future<Either<Error, SearchResults>> searchCities({required String searchText});
  Future<Either<Error, CityWeather>> getWeatherLatLon({required String latitude, required String longitude});
}

// WeatherAppRepository with the two main requests necessary for obtaining the weather info in a city

class WeatherAppRepository implements IWeatherAppRepository {
  @override
  Future<Either<Error, CityWeather>> getWeatherLatLon({required String latitude, required String longitude}) async {
    CityWeather? cityWeather;
    Error? error;
    final queryParams = {'latitude': latitude, 'longitude': longitude, 'current_weather': 'true'};
    final response = await Client.get(queryParams: queryParams, action: Action.weather);
    response.fold((l) => error = l, (body) {
      final jsonResponse = jsonDecode(body);
      try {
        cityWeather = CityWeather.fromJson(jsonResponse);
      } catch (e) {
        print('invalid format in genWeatherLatLon $e');
        error = Error();
      }
    });
    if (cityWeather != null) {
      return right(cityWeather!);
    } else {
      return left(error!);
    }
  }

  @override
  Future<Either<Error, SearchResults>> searchCities({required String searchText}) async {
    SearchResults? searchResults;
    Error? error;
    final queryParams = {
      'name': searchText,
      'count': '5',
      'language': 'en',
      'format': 'json',
    };
    final response = await Client.get(queryParams: queryParams, action: Action.search);
    response.fold(
      (l) => error = l,
      (body) {
        final jsonResponse = jsonDecode(body);
        try {
          searchResults = SearchResults.fromJson(jsonResponse);
        } catch (e) {
          // in production use logger
          print('invalid format $e');
          error = Error();
        }
      },
    );
    if (searchResults != null) {
      return right(searchResults!);
    } else {
      return left(error!);
    }
  }
}
