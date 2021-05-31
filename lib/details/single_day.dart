import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemapgl_example/details/day_details.dart';

// ignore: must_be_immutable
class SingleDay extends StatelessWidget {
  //final int index;
  DayDetails dayDetails;
  SingleDay(this.dayDetails);

  @override
  Widget build(BuildContext context) {
    double resize = MediaQuery.of(context).devicePixelRatio/2.75;

    return Container(
      margin: EdgeInsets.fromLTRB(10 * resize, 5 * resize, 10 * resize, 5 * resize),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${dayDetails.day}',
            style: GoogleFonts.lato(
              fontSize: 15 * resize,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${dayDetails.description}',
            style: GoogleFonts.lato(
              fontSize: 15 * resize,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${dayDetails.temp_min}/${dayDetails.temp_max}',
            style: GoogleFonts.lato(
              fontSize: 15 * resize,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
