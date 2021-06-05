import 'package:flutter/material.dart';
import 'package:wemapgl_example/model.dart';
import 'package:wemapgl_example/search/full_map.dart';
import 'package:wemapgl_example/weather_app.dart';
import '../weather_location.dart';

// ignore: must_be_immutable
class WeatherApi extends StatelessWidget {
  WeatherLocation weatherLocation;
  WeatherApi(this.weatherLocation);

  @override
  Widget build(BuildContext context) {
    double resize = MediaQuery.of(context).devicePixelRatio/2.75;

    weatherLocation.bgimg = 'assets/bgimg/default/brokenclouds.jpeg';
    var description = weatherLocation.description.toString().replaceAll(' ', '');
    if (weatherLocation.status == 'night'){
      weatherLocation.bgimg = 'assets/bgimg/${weatherLocation.theme}/${weatherLocation.weatherType}night.jpeg';
    } else {
      weatherLocation.bgimg = 'assets/bgimg/${weatherLocation.theme}/$description.jpeg';
    }

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FullMapPage()),
              );
              print("Go back Full Map");
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30 * resize,
              color: Colors.white,
            ),
          ),
          actions: [
          Container(
            margin: EdgeInsets.only(right: 15 * resize),
            child: IconButton(
              onPressed: () {
                var j = 0;
                String notify;
                for (var i = 0; i < locationList.length; i++){
                  if (locationList[i].city == weatherLocation.city){
                    j++;
                  }
                }
                if (j == 0) {
                  locationList.insert(0, weatherLocation);
                  notify = 'Add ${weatherLocation.city} successfully!';
                }
                else {
                  notify = '${weatherLocation.city} is existed!';
                }
                close(context, notify);
              },
              icon: Icon(
                Icons.add,
                size: 30 * resize,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
          child: Stack(
              children: [Image.asset(
                weatherLocation.bgimg,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
                Container(
                  decoration: BoxDecoration(color: Colors.black38),
                ),
                WeatherModel(weatherLocation),
              ]
          ),
        ),
    );
  }

  void close(BuildContext context, var notify) async {

  var bottomSheet = showModalBottomSheet(
      isDismissible: true,
      context: context,
      builder: (context) {
        return Container(
            height: 60,
            child: ListTile(
              leading: Icon(
                  Icons.notifications_on,
                color: Colors.red,
              ),
              title: Text('$notify'),
              onTap: (){}
        ),
        );
      }
  );

  await bottomSheet.then((onValue) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WeatherApp()),
    );
  },);
  }
}
