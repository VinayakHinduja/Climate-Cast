import 'package:flutter/material.dart';

import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/weather.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    await weatherModel.getLocationWeather().then(
          (v) => SchedulerBinding.instance.addPostFrameCallback(
            (_) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LocationScreen(locationWeather: v),
              ),
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
