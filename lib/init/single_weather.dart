import 'package:flutter/material.dart';
import 'package:wemapgl_example/model.dart';
import '../weather_location.dart';

// ignore: must_be_immutable
class SingleWeather extends StatelessWidget {
  WeatherLocation weatherLocation;
  SingleWeather(this.weatherLocation);

  @override
  Widget build(BuildContext context) {
    return
        WeatherModel(weatherLocation);
  }
}
