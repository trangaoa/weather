import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'weather_location.dart';

// ignore: must_be_immutable
class SingleWeather extends StatelessWidget {
  WeatherLocation weatherLocation;
  SingleWeather(this.weatherLocation);

  @override
  Widget build(BuildContext context) {
    double resize = MediaQuery.of(context).devicePixelRatio/2.75;

    return
      Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 150,),
                      Text(
                        '${weatherLocation.city}',
                        style: GoogleFonts.lato(
                          fontSize: 35  * resize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5  * resize,),
                      Text(
                        '${weatherLocation.dateTime}',
                          style: GoogleFonts.lato(
                        fontSize: 14  * resize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 120  * resize,),
                      Text(
                        '${weatherLocation.temperature}',
                        style: GoogleFonts.lato(
                          fontSize: 85  * resize,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            '${weatherLocation.iconUrl}',
                            width: 34  * resize,
                            height: 34  * resize,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10  * resize,),
                          Text('${weatherLocation.description}', style: GoogleFonts.lato(
                            fontSize: 25  * resize,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 40),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Wind',
                            style: GoogleFonts.lato(
                              fontSize: 14 * resize,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                              '${weatherLocation.wind.toStringAsFixed(2)}',
                              style: GoogleFonts.lato(
                                fontSize: 24  * resize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                          Text(
                            'km/h',
                            style: GoogleFonts.lato(
                              fontSize: 14  * resize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 5  * resize,
                                width: 50  * resize,
                                color: Colors.white38,
                              ),
                              Container(
                                height: 5  * resize,
                                width: 5  * resize,
                                color: Colors.greenAccent,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '${weatherLocation.weatherType}',
                            style: GoogleFonts.lato(
                              fontSize: 14  * resize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                              '${weatherLocation.rain}',
                              style: GoogleFonts.lato(
                                fontSize: 24  * resize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                          Text(
                            '%',
                            style: GoogleFonts.lato(
                              fontSize: 14  * resize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 5  * resize,
                                width: 50  * resize,
                                color: Colors.white38,
                              ),
                              Container(
                                height: 5  * resize,
                                width: weatherLocation.rain.toDouble()/2 * resize,
                                color: Colors.redAccent,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Humidity',
                            style: GoogleFonts.lato(
                              fontSize: 14  * resize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                              weatherLocation.humidity.toString(),
                              style: GoogleFonts.lato(
                                fontSize: 24  * resize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                          Text(
                            '%',
                            style: GoogleFonts.lato(
                              fontSize: 14  * resize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 5  * resize,
                                width: 50  * resize,
                                color: Colors.white38,
                              ),
                              Container(
                                height: 5  * resize,
                                width: weatherLocation.humidity.toDouble() * resize/2,
                                color: Colors.redAccent,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
  }
}
