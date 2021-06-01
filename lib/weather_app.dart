import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:wemapgl_example/setting/setting.dart';
import 'package:wemapgl_example/details/single_details.dart';
import 'init/constants.dart';
import 'search/full_map.dart';
import 'init/single_weather.dart';
import 'weather_location.dart';
import 'init/slider_dot.dart';
import 'init/building_transformer.dart';

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  int _currentPage = 0;
  String bgimg;
  WeatherLocation _weatherLocation = WeatherLocation();

  @override
  void initState() {
    super.initState();
    //_weatherLocation.fetchLocation();
  }

_onPageChanged(int index){
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double resize = MediaQuery.of(context).devicePixelRatio/2.75;

    WeatherLocation wl = locationList[_currentPage];
    var description = wl.description.toString().replaceAll(' ', '');
    if (wl.status == 'night'){
      bgimg = 'assets/bgimg/${wl.theme}/${wl.weatherType}night.jpeg';
    } else if  (wl.status == 'sunrise'){
      bgimg = 'assets/bgimg/${wl.theme}/${wl.weatherType}sunrise.jpeg';
    } else{
      bgimg = 'assets/bgimg/${wl.theme}/$description.jpeg';
    }

    void choiceAction(String choice){
      if (choice == Constants.details){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SingleDetails(_currentPage)),
        );
        print('Get details of ${wl.city}');
      } else if (choice == Constants.settings){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Setting(_currentPage)),
        );
        print('Setting');
      } else if (choice == Constants.delete){
        print('Delete ${wl.city} from location list');
        locationList.removeAt(_currentPage);
      }
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
            print("Search clicked!");
          },
          icon: Icon(
              Icons.search,
              size: 30 * resize,
              color: Colors.white,
          ),
        ),

        actions: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 15 * resize, 0),
              child: PopupMenuButton(
                icon: Icon(
                  Icons.menu_rounded,
                  size: 30 * resize,
                  color: Colors.white,
                ),
                elevation: 0.8,
                initialValue: Constants.choices[0],
                onSelected: choiceAction,
                // ignore: missing_return
                itemBuilder: (BuildContext context) {
                  return Constants.choices.map((String choice) {
                    return PopupMenuItem <String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              )
            ),
          //)
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              bgimg,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
           Container(
             decoration: BoxDecoration(color: Colors.black38),
           ),
            Container(
              margin: EdgeInsets.only(top: 110 * resize, left: 15 * resize),
              child: Row(
                children: [
                  for (int i = 0; i < locationList.length; i++)
                    if (i == _currentPage)
                      SliderDot(true)
                    else
                      SliderDot(false)
                ],
              ),
            ),
            TransformerPageView(
              scrollDirection: Axis.horizontal,
              transformer: ScaleAndFadeTransformer(),
              viewportFraction: 0.8,
              onPageChanged: _onPageChanged,
              itemCount: locationList.length,
              itemBuilder: (ctx, i) => SingleWeather(locationList[i]),
            ),
          ],
        ),
      ),
    );
  }
}
