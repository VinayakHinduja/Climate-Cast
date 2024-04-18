// ignore_for_file: unnecessary_null_comparison

import 'package:geolocator/geolocator.dart';

import 'location.dart';
import 'networking.dart';

class WeatherModel {
  Future<Map<String, dynamic>?> getLocationWeather() async {
    Location location = Location();
    Position positon = await location.getCurrentLocation();
    if (location.longitude != null || location.latitute != null) {
      LocationWeatherData weatherData = LocationWeatherData(
        latitude: positon.latitude,
        longitude: positon.longitude,
      );
      var body = await weatherData.getData();
      return body;
    }
    return null;
  }
}

String getWeatherIcon(int condition) {
  if (condition == 210 ||
      condition == 211 ||
      condition == 212 ||
      condition == 221) {
    return '🌩️';
  } else if (condition == 200 ||
      condition == 201 ||
      condition == 202 ||
      condition == 230 ||
      condition == 231 ||
      condition == 232 ||
      condition == 500 ||
      condition == 300 ||
      condition == 301 ||
      condition == 302 ||
      condition == 310 ||
      condition == 311 ||
      condition == 312 ||
      condition == 313 ||
      condition == 314 ||
      condition == 321) {
    return '🌧️';
  } else {
    if (condition == 501 ||
        condition == 502 ||
        condition == 503 ||
        condition == 504 ||
        condition == 521 ||
        condition == 522 ||
        condition == 531) {
      return '☔️';
    } else if (condition == 511 ||
        condition == 600 ||
        condition == 601 ||
        condition == 602 ||
        condition == 611 ||
        condition == 612 ||
        condition == 613 ||
        condition == 615 ||
        condition == 616 ||
        condition == 620 ||
        condition == 621 ||
        condition == 622) {
      return '❄️';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition == 801 ||
        condition == 802 ||
        condition == 803 ||
        condition == 804) {
      return '☁️';
    } else if (condition == 701 ||
        condition == 711 ||
        condition == 721 ||
        condition == 731 ||
        condition == 751 ||
        condition == 761 ||
        condition == 762) {
      return '🍃';
    } else if (condition == 741) {
      return '🌫️';
    } else if (condition == 771 || condition == 781) {
      return '🌪️';
    } else {
      return '🤷‍';
    }
  }
}

String capitalizeAllWord(String value) {
  var result = value[0].toUpperCase();
  for (int i = 1; i < value.length; i++) {
    if (value[i - 1] == " ") {
      result = result + value[i].toUpperCase();
    } else {
      result = result + value[i];
    }
  }
  return result;
}
