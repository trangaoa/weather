import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wemapgl/wemapgl.dart';
import 'package:wemapgl_example/weather_api.dart';
import 'package:wemapgl_example/weather_location.dart';
import 'ePage.dart';
import 'package:http/http.dart' as http;

class FullMapPage extends ePage {
  FullMapPage() : super(const Icon(Icons.map), 'Full screen map');

  @override
  Widget build(BuildContext context) {
    return const FullMap();
  }
}

class FullMap extends StatefulWidget {
  const FullMap();

  @override
  State createState() => FullMapState();
}

class FullMapState extends State<FullMap> {
  WeMapController mapController;
  int searchType = 1; //Type of search bar
  String searchInfoPlace = "Tìm kiếm ở đây"; //Hint text for InfoBar
  String searchPlaceName;
  LatLng myLatLng = LatLng(21.038282, 105.782885);
  bool reverse = true;
  WeMapPlace place;
  void _onMapCreated(WeMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          WeMap(
            onMapClick: (point, latLng, _place) async {
              WeatherLocation weatherLocation = WeatherLocation();
              place = _place;
              var placeJSON = place.fullJSON;

              print(placeJSON);

              setPlaceState(weatherLocation, placeJSON);

              //Future<void> onMapClick()=>
              Future.delayed(const Duration(seconds: 2), (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      WeatherApi(weatherLocation)),
                );
                print('success');
              });
            },
            onPlaceCardClose: () {
              // print("Place Card closed");
            },
            reverse: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(21.036029, 105.782950),
              zoom: 16.0,
            ),
            destinationIcon: "assets/symbols/destination.png",
          ),
          WeMapSearchBar(
            location: myLatLng,
            onSelected: (_place) {
              setState(() {
                place = _place;
              });
              mapController.moveCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: place.location,
                    zoom: 14.0,
                  ),
                ),
              );
              mapController.showPlaceCard(place);
            },
            onClearInput: () {
              setState(() {
                place = null;
                mapController.showPlaceCard(place);
              });
            },
          ),
        ],
      ),
    );
  }
}
