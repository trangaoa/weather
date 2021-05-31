import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wemapgl_example/details/time_details.dart';

import 'details/day_details.dart';

class WeatherLocation {
  String city;
  String dateTime, dt;
  String temperature, wind, pressure, weatherType;
  String description = 'clear sky';
  String status, iconUrl;
  String tempUnit = '\u2103', pressureUnit = 'mbar', windUnit = 'km/h';
  var windSpeed, rain;
  int humidity;
  var lat, lon;
  String feel_like, temp_min, temp_max;
  var temp, feel, min, max, press;
  int visibility, wind_deg;
  String sunrise, sunset;
  var dew_point, uvi;
  String bgimg;
  String theme = 'default';
  List<TimeDetails> timeDetails = [];
  List<DayDetails> dayDetails = [];
  int timeDetailLength = 24;
  int dayDetailLength = 3;

  WeatherLocation({
    @required this.city,
    @required this.dateTime,
    @required this.temperature,
    @required this.weatherType,
    @required this.iconUrl,
    @required this.windSpeed,
    @required this.rain,
    @required this.humidity,
  });

  void setPlaceState(var placeJSON) async{
    var geometry = placeJSON['geometry'];
    var properties = placeJSON['properties'];

    List<dynamic> coordinates = geometry['coordinates'];
    var lat = coordinates[1];
    var lon = coordinates[0];

    this.lat = lat;
    this.lon = lon;
    this.city = properties['region'];

    String searchApiUrl = "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=cf6752c51d18cdd4ebabe52da8d74aea";
    print(searchApiUrl);

    var searchResult = await http.get(searchApiUrl);

    setWeatherState(searchResult);
  }

  void setWeatherState(var searchResult){
    Map<String, dynamic> result = jsonDecode(searchResult.body);
    print('set Weather State: ${result.toString()}');

    var main = result['main'];
    List<dynamic> weather = result['weather'];

    var wind = result['wind'];

    var unixTimestampVN = result['dt'] - 25200 + result['timezone'];
    String formattedDay = formatDay(unixTimestampVN);

    this.temp = main['temp']/10;

    var coord = result['coord'];
    this.feel = main['feels_like']/10;
    this.min = main['temp_min']/10;
    this.max = main['temp_max']/10;
    var sys = result['sys'];
    var sunrise = sys['sunrise'] - 25200 + result['timezone'];
    var sunset = sys['sunset'] - 25200 + result['timezone'];

    this.lat = coord['lat'];
    this.lon = coord['lon'];
    this.press = main['pressure'];
    this.visibility = result['visibility'];
    this.wind_deg = wind['deg'];
    this.sunrise = formatTime(sunrise);
    this.sunset = formatTime(sunset);

    this.city = result['name'];
    this.dateTime = formattedDay.toString();
    this.weatherType = weather[0]['main'].toString();
    this.description = weather[0]['description'];
    this.iconUrl = 'assets/icon/${this.description.toString().replaceAll(' ', '')}.svg';
    this.windSpeed = wind['speed'] * 3.6;
    formatWindSpeed(this.windUnit);

    formatPressure(this.pressureUnit);
    formatTemp(this.tempUnit);

    if (this.weatherType == 'Rain') {
      var rain = result['rain'];
      this.rain = rain['1h'];
    } else if (this.weatherType == 'Clouds'){
      var clouds = result['clouds'];
      this.rain = clouds['all'];
    } else if (this.weatherType == 'Clear') {
      this.rain = 20;
    }

    this.humidity = main['humidity'];
  }

  void fetchLocation() async{
    for (var i = 0; i < locationList.length; i++){
      WeatherLocation weatherLocation = locationList[i];

      var city = locationList[i].city;
      String searchApiUrl = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=cf6752c51d18cdd4ebabe52da8d74aea";

      var searchResult = await http.get(searchApiUrl);
      weatherLocation.setWeatherState(searchResult);
      weatherLocation.fetchSearch();
    }
  }

  void fetchSearch() async {
    String lat = this.lat.toStringAsFixed(4);
    String lon = this.lon.toStringAsFixed(4);
    String searchApiUrl = "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=minutely&appid=cf6752c51d18cdd4ebabe52da8d74aea";

    print(searchApiUrl);

    var searchResult = await http.get(searchApiUrl);

    this.setSearchState(searchResult);
  }

  void setSearchState(var searchResult){
    Map<String, dynamic> result = jsonDecode(searchResult.body);

    List<dynamic> resultHourly = result['hourly'];

    var time = - 25200 + result['timezone_offset'];
    var resultCurrent = result['current'];

    List<dynamic> resultDaily = result['daily'];
    var current = resultDaily[0];

    var temp = current['temp'];

    this.temp_min = (temp['min']/10).toStringAsFixed(1) + '\u2103';
    this.temp_max = (temp['max']/10).toStringAsFixed(1) + '\u2103';
    this.dt = formatDate(resultCurrent['dt'] + time);

    var sunrise = resultCurrent['sunrise'] + time;
    var sunset = resultCurrent['sunset'] + time;
    var dateHour = resultCurrent['dt'] + time;

    var dateSunset = new DateTime.fromMillisecondsSinceEpoch(sunset*1000);
    var dateSunrise = new DateTime.fromMillisecondsSinceEpoch(sunrise*1000);
    var date = new DateTime.fromMillisecondsSinceEpoch(dateHour*1000);

    this.sunrise = formatTime(sunrise);
    this.sunset = formatTime(sunset);

    if (date.hour > dateSunset.hour || date.hour < dateSunrise.hour) {
      this.status = 'night';
      this.iconUrl = 'assets/icon/${this.weatherType.toString().replaceAll(' ', '')}night.svg';
    } else if (date.hour == dateSunset.hour || date.hour == dateSunrise.hour) {
      this.status = 'sunrise';
      this.iconUrl = 'assets/icon/sunrise.svg';
    }

    this.timeDetails.clear();

    for (int i = 0; i < this.timeDetailLength; i++) {
      List<dynamic> timeWeather = resultHourly[i + 1]['weather'];
      var timeDt = resultHourly[i + 1]['dt'] + time;
      var dateTimeDt = new DateTime.fromMillisecondsSinceEpoch(timeDt*1000);
      var timeDescription = timeWeather[0]['description'].toString().replaceAll(' ', '');
      var timeMain = timeWeather[0]['main'].toString();
      var timeTemp = resultHourly[i + 1]['temp']/10;
      var iconTime;
      Color color;

      if (dateTimeDt.hour > dateSunset.hour || dateTimeDt.hour < dateSunrise.hour){
        iconTime = 'assets/icon/${timeMain}night.svg';
        color = Colors.yellowAccent;
      } else if (dateTimeDt.hour == dateSunset.hour || dateTimeDt.hour == dateSunrise.hour) {
        iconTime = 'assets/icon/sunrise.svg';
        color = Colors.deepOrange;
      } else {
        iconTime = 'assets/icon/$timeDescription.svg';
        color = Colors.cyanAccent;
      }

      TimeDetails timer = TimeDetails(
        time: formatTime(timeDt),
        icon: iconTime,
        timeTemp: timeTemp,
        temperature: timeTemp.toStringAsFixed(1) + '${this.tempUnit}',
        color: color,
      );
      this.timeDetails.add(timer);
    }

    this.dayDetails.clear();

    for(int i = 0; i < this.dayDetailLength; i++){
      List<dynamic> dateWeather = resultDaily[i]['weather'];
      var dateDay = resultDaily[i]['dt'];
      var dateTemp = resultDaily[i]['temp'];
      var dateDescription = dateWeather[0]['description'];
      var dayMin = dateTemp['min']/10;
      var dayMax = dateTemp['max']/10;

      DayDetails day = DayDetails(
          day: formatDate(dateDay + time),
          description: dateDescription,
          dayMin: dayMin,
          dayMax: dayMax,
          temp_min: dayMin.toStringAsFixed(1) + '${this.tempUnit}',
          temp_max: dayMax.toStringAsFixed(1) + '${this.tempUnit}'
      );

      this.dayDetails.add(day);
    }

    this.dew_point = resultCurrent['dew_point'];
    this.uvi = resultCurrent['uvi'];
  }

  void formatPressure(String unit){
    this.pressure = this.press.toStringAsFixed(0) + ' ' + unit;
  }

  void formatWindSpeed(String unit){
    this.wind = this.windSpeed.toStringAsFixed(2) + ' ' + unit;
  }

  void formatTemp(String unit){
    this.temperature = this.temp.toStringAsFixed(1) + unit;
    this.feel_like = this.feel.toStringAsFixed(1) + unit;
    this.temp_min = this.min.toStringAsFixed(1) + unit;
    this.temp_max = this.max.toStringAsFixed(1) + unit;

    for (int i = 0; i < this.timeDetails.length; i++){
      this.timeDetails[i].temperature = (this.timeDetails[i].timeTemp).toStringAsFixed(1) + unit;
    }

    for (int i = 0; i < this.dayDetails.length; i++){
      this.dayDetails[i].temp_min = this.dayDetails[i].dayMin.toStringAsFixed(1) + unit;
      this.dayDetails[i].temp_max = this.dayDetails[i].dayMax.toStringAsFixed(1) + unit;
    }
  }
}

  String formatDay(unixTimestamp){
    var date = new DateTime.fromMillisecondsSinceEpoch(unixTimestamp*1000);
    var hours = "0" + date.hour.toString();
    var minutes = "0" + date.minute.toString();
    var seconds = "0" + date.second.toString();
    var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    var weekDays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    var year = date.year;
    var month = months[date.month - 1];
    var day = date.day;
    var weekday = weekDays[date.weekday - 1];

    // Will display time in 10:30:23 format
    var formattedDay = hours.substring(hours.length - 2) + ':' + minutes.substring(minutes.length - 2) + ':' + seconds.substring(seconds.length - 2)
        + ' — ' + weekday.toString() + ', ' + day.toString() + ' ' + month.toString() + ' ' + year.toString();

    return formattedDay;
  }

  String formatTime(unixTimestamp){
    var date = new DateTime.fromMillisecondsSinceEpoch(unixTimestamp*1000);
    var hours = "0" + date.hour.toString();
    var minutes = "0" + date.minute.toString();
    //var seconds = "0" + date.second.toString();

    var formattedTime = hours.substring(hours.length - 2) + ':' + minutes.substring(minutes.length - 2);
    //+ ':' + seconds.substring(seconds.length - 2);

    return formattedTime;
  }

  String formatDate(unixTimestamp){
    var date = new DateTime.fromMillisecondsSinceEpoch(unixTimestamp*1000);
    var day = '0' + date.day.toString();
    var month = '0' + date.month.toString();

    var formattedDate = day.substring(day.length - 2) + '/' + month.substring(month.length - 2);
    return formattedDate;
  }

final locationList = [
  WeatherLocation(
    city: 'Thai Binh',
    dateTime: '10:42:38 - Sunday, 16 May 2021',
    temperature: '30.3\u2103',
    weatherType: 'Clouds',
    iconUrl: 'assets/icon/overcastclouds.svg',
    windSpeed: 3.6,
    rain: 50,
    humidity: 84,
  ),
  WeatherLocation(
      city: 'Hanoi',
      dateTime: '10:31:21 - Sunday, 16 May 2021',
      temperature: '31\u2103',
      weatherType: 'Night',
      iconUrl: 'assets/icon/overcastclouds.svg',
      windSpeed: 20,
      rain: 43,
      humidity: 89,
  ),
  WeatherLocation(
    city: 'London',
    dateTime: '02:20 PM — Monday, 9 Nov 2020',
    temperature: '15\u2103',
    weatherType: 'Cloudy',
    iconUrl: 'assets/icon/overcastclouds.svg',
    windSpeed: 4,
    rain: 7,
    humidity: 82,
  ),
  WeatherLocation(
    city: 'Saigon',
    dateTime: '09:20 AM — Monday, 9 Nov 2020',
    temperature: '17\u2103',
    weatherType: 'Sunny',
    iconUrl: 'assets/icon/overcastclouds.svg',
    windSpeed: 5,
    rain: 15,
    humidity: 61,
  ),
  WeatherLocation(
    city: 'Sydney',
    dateTime: '01:20 AM — Tuesday, 10 Nov 2020',
    temperature: '10\u2103',
    weatherType: 'Rainy',
    iconUrl: 'assets/rain.svg',
    windSpeed: 4.5,
    rain: 70,
    humidity: 91,
  ),
];