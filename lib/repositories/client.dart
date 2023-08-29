import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

enum Action {
  search,
  weather,
}

// client to abstract the network away from the repository following encapsulation principle
// using prints only for demonstration purposes, in production emit logs using a logger mixin
class Client {
  static String searchEndpoint = 'https://geocoding-api.open-meteo.com/v1/search';
  static String weatherEndpoint = 'https://api.open-meteo.com/v1/forecast';

  static Future<Either<Error, String>> get({required Map<String, String> queryParams, required Action action}) async {
    final apiEndpoint = switch (action) {
      Action.search => searchEndpoint,
      Action.weather => weatherEndpoint,
    };
    final uri = Uri.parse(apiEndpoint).replace(queryParameters: queryParams);
    final response = await http.get(uri);

    print("RESPONSE STATUS CODE: ${response.statusCode}");
    if (response.statusCode != 200) {
      print("RESPONSE BODY ERROR: ${response.body}");
      return left(Error());
    } else {
      print("RESPONSE BODY CORRECT: ${response.body}");
      return right(response.body);
    }
  }
}
