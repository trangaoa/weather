import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemapgl_example/setting/theme_details.dart';
import 'package:wemapgl_example/weather_location.dart';

// ignore: must_be_immutable
class SingleTheme extends StatelessWidget {
  ThemeDetails themeDetails;
  SingleTheme(this.themeDetails);

  @override
  Widget build(BuildContext context) {
    double resize = MediaQuery.of(context).devicePixelRatio/2.75;

    return Stack(
          children: [
            Image.asset(
              '${themeDetails.bgimg}',
              fit: BoxFit.cover,
              height: 150 * resize,
              width: 200 * resize,
            ),
            GestureDetector(
              onTap: (){
                print('${themeDetails.title}');
                for (var i = 0; i < locationList.length; i++){
                  locationList[i].theme = themeDetails.title;
                }
              },
              child: Container(
                margin: EdgeInsets.only(right: 10 * resize),
                height: 150 * resize,
                width: 200 * resize,
                decoration: BoxDecoration(color: Colors.black45),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(20 * resize),
                        child: Text(
                          '${themeDetails.title}',
                          style: GoogleFonts.lato(
                            fontSize: 24 * resize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ]
      );
  }
}
