import 'dart:convert';
import 'package:http/http.dart' as http;

import '../const.dart';

class LocationWeatherData {
  LocationWeatherData({this.latitude, this.longitude, this.cityName});

  double? latitude;
  double? longitude;
  String? cityName;

  Future getCityWeather() async {
    // https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

    final parameters = {'q': cityName, 'appid': pas, 'units': 'metric'};
    Uri url = Uri.http(
      'api.openweathermap.org',
      '/data/2.5/weather',
      parameters,
    );
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = await jsonDecode(response.body);
      return body;
    }
  }

  Future<Map<String, dynamic>?> getData() async {
    //https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}

    final parameters = {
      'lat': latitude?.toStringAsFixed(4),
      'lon': longitude?.toStringAsFixed(4),
      'appid': pas,
      'units': 'metric'
    };
    Uri url = Uri.http(
      'api.openweathermap.org',
      '/data/2.5/weather',
      parameters,
    );
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> body = await jsonDecode(response.body);
      return body;
    }
    return null;
  }
}
