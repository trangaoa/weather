import 'package:flutter/cupertino.dart';

class TimeDetails {
  String time;
  String icon;
  var timeTemp;
  String temperature;
  Color color;

  TimeDetails({
    @required this.time,
    @required this.icon,
    @required this.timeTemp,
    @required this.temperature,
    @required this.color,
  });
}