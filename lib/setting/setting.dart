import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemapgl_example/theme_details.dart';

import 'single_theme.dart';

// ignore: must_be_immutable
class Setting extends StatelessWidget {
  final int index;
  Setting(this.index);

  @override
  Widget build(BuildContext context) {
    String bgimg = 'assets/bg/hanoi.jpg';
    double resize = MediaQuery.of(context).devicePixelRatio/2.75;

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
                  height: 700 * resize,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Expanded(
                          child: Column(
                            children: [
                              SizedBox(height: 35 * resize,),
                              Center(
                                child: Text(
                                  'Setting',
                                  style: GoogleFonts.lato(
                                    fontSize: 24 * resize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //SizedBox(height: 200,),
                            Text(
                              'Theme',
                              style: GoogleFonts.lato(
                                fontSize: 24 * resize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 80 * resize,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: themeList.length,
                          itemBuilder: (context, i) => SingleTheme(themeList[i]),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Temperature',
                            style: GoogleFonts.lato(
                              fontSize: 24 * resize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              )
            )
          ],
        ),
      ),
    );
  }
}
