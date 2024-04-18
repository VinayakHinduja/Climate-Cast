import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/networking.dart';
import '../services/weather.dart';
import '../utilities/constants.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, required this.locationWeather});

  final dynamic locationWeather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late String cityName;
  late int temp;
  late String weatherIcon;
  late String weatherMsg;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(Map<String, dynamic>? weatherData) {
    setState(() {
      if (weatherData == null) {
        temp = 0;
        cityName = '';
        weatherIcon = 'Error';
        weatherMsg = ' Unable to get weather data ';
        return;
      }
      cityName = capitalizeAllWord(weatherData["name"]);
      double temperature =
          double.tryParse(weatherData["main"]["temp"].toString()) ?? 0;
      temp = temperature.round();
      int id = weatherData["weather"]![0]['id'];
      weatherIcon = getWeatherIcon(id);
      weatherMsg = capitalizeAllWord(weatherData["weather"][0]["description"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(locationBg),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8),
              BlendMode.dstATop,
            ),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      setState(() => loading = true);
                      await weather
                          .getLocationWeather()
                          .then((v) => setState(() => updateUI(v)))
                          .whenComplete(() => loading = false);
                    },
                    child: const Icon(
                      Icons.location_on,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute<String>(
                            builder: (context) => const CityScreen()),
                      );
                      if (typedName != null) {
                        LocationWeatherData weatherman =
                            LocationWeatherData(cityName: typedName);
                        var weatherData = await weatherman.getCityWeather();
                        if (weatherData != null) updateUI(weatherData);
                        if (weatherData == null) {
                          Fluttertoast.showToast(
                            backgroundColor: Colors.black87,
                            msg:
                                'Cannot retrive weather info for city name entered',
                          );
                          return;
                        }
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    if (loading)
                      const CircularProgressIndicator(color: Colors.white),
                    if (!loading)
                      Text(
                        '$temp°',
                        style: kTempTextStyle,
                      ),
                    if (!loading)
                      Text(
                        weatherIcon,
                        style: kConditionTextStyle,
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35, right: 30),
                child: Text(
                  '$weatherMsg in $cityName!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
