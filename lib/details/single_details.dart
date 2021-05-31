import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemapgl_example/details/single_day.dart';
import 'package:wemapgl_example/details/single_time.dart';
import '../weather_location.dart';

class SingleDetails extends StatelessWidget {
  final int index;
  SingleDetails(this.index);

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: Colors.white12,
      border: Border.all(
        width: 1.0,
        color: Colors.white30,
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(10.0), //                 <--- border radius here
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double resize = MediaQuery.of(context).devicePixelRatio/2.75;
    WeatherLocation weatherLocation = locationList[index];

    String bgimg = 'assets/bg/hanoi.jpg';
    var city = weatherLocation.city.toLowerCase().replaceAll(' ', '');
    bgimg = 'assets/bg/$city.jpg';

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Colors.transparent,
          elevation: 0,
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
                decoration: BoxDecoration(color: Colors.black54),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                child: SingleChildScrollView(
                  child: Container(
                    height: (860 + 33 * weatherLocation.dayDetails.length) * resize,
                    padding: EdgeInsets.all(20),
                    child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 25 * resize,),
                                Center(
                                  child: Text(
                                    '${weatherLocation.city}',
                                    style: GoogleFonts.lato(
                                      fontSize: 24 * resize,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(height: 140 * resize,),
                                Text(
                                  '${weatherLocation.temperature}',
                                  style: GoogleFonts.lato(
                                    fontSize: 70 * resize,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      '${weatherLocation.iconUrl}',
                                      width: 27 * resize,
                                      height: 27 * resize,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 8 * resize,),
                                    Text('${weatherLocation.description}', style: GoogleFonts.lato(
                                      fontSize: 25 * resize,
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
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white54,
                          ),
                        ),
                      ),
                      Container(
                        height: 80 * resize,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: weatherLocation.timeDetails.length,
                          itemBuilder: (context, i) => SingleTime(weatherLocation.timeDetails[i]),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white54,
                          ),
                        ),
                      ),
                      Container(
                        decoration: myBoxDecoration(),
                        height: 33 * weatherLocation.dayDetails.length * resize,
                        child: ListView.builder(
                          padding: EdgeInsets.all(0),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: weatherLocation.dayDetails.length,
                          itemBuilder: (context, i) => SingleDay(weatherLocation.dayDetails[i]),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white54,
                              ),
                            ),
                          ),
                          Container(
                            decoration: myBoxDecoration(),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Sunrise',
                                          style: GoogleFonts.lato(
                                            fontSize: 11 * resize,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                            '${weatherLocation.sunrise}',
                                            style: GoogleFonts.lato(
                                              fontSize: 16 * resize,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 12 * resize,),
                                    Column(
                                      children: [
                                        Text(
                                          'Wind',
                                          style: GoogleFonts.lato(
                                            fontSize: 11 * resize,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                            '${weatherLocation.wind}',
                                            style: GoogleFonts.lato(
                                              fontSize: 16 * resize,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 8 * resize,),
                                    Column(
                                      children: [
                                        Text(
                                          'Feel like',
                                          style: GoogleFonts.lato(
                                            fontSize: 11 * resize,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                            '${(weatherLocation.feel_like)}',
                                            style: GoogleFonts.lato(
                                              fontSize: 16 * resize,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 8 * resize,),
                                    Column(
                                      children: [
                                        Text(
                                          'Dew Point',
                                          style: GoogleFonts.lato(
                                            fontSize: 11 * resize,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                            '${weatherLocation.dew_point}',
                                            style: GoogleFonts.lato(
                                              fontSize: 16 * resize,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Sunset',
                                          style: GoogleFonts.lato(
                                            fontSize: 11 * resize,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                            '${weatherLocation.sunset}',
                                            style: GoogleFonts.lato(
                                              fontSize: 16 * resize,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 12 * resize,),
                                    Column(
                                      children: [
                                        Text(
                                          'Humidity',
                                          style: GoogleFonts.lato(
                                            fontSize: 11 * resize,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        Text(
                                            '${weatherLocation.humidity.toString()} %',
                                            style: GoogleFonts.lato(
                                              fontSize: 16 * resize,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 8 * resize,),
                                    Column(
                                      children: [
                                        Text(
                                          'Pressure',
                                          style: GoogleFonts.lato(
                                            fontSize: 11 * resize,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        Text(
                                            '${weatherLocation.pressure}',
                                            style: GoogleFonts.lato(
                                              fontSize: 16 * resize,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 8 * resize,),
                                    Column(
                                      children: [
                                        Text(
                                          'UV',
                                          style: GoogleFonts.lato(
                                            fontSize: 11 * resize,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        Text(
                                            '${weatherLocation.uvi.toString()}',
                                            style: GoogleFonts.lato(
                                              fontSize: 16 * resize,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ]
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),),
            )
          ]
        ),
      )
    );
  }
}