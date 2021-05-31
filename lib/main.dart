import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:wemapgl_example/weather_app.dart';
import 'package:wemapgl_example/weather_location.dart';
void main(){
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

WeatherLocation _weatherLocation = WeatherLocation();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    _weatherLocation.fetchLocation();

    return new SplashScreen(
        seconds: 12,
        navigateAfterSeconds: WeatherApp(),
        // title: new Text('Weather App',
        //   style: new TextStyle(
        //       color: Colors.white,
        //       fontWeight: FontWeight.bold,
        //       fontSize: 30.0
        //   ),),
        //loadingText: Text('Hello'),
        imageBackground: new Image.asset(
          "assets/splashScreen.gif",
          colorBlendMode: BlendMode.softLight,
          color: Colors.black.withOpacity(1.0),
        ).image,
        //backgroundColor: Colors.pinkAccent,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 200.0,
        onClick: ()=>print("Flutter Egypt"),
        loaderColor: Colors.cyan
    );
  }
}