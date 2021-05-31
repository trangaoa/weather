import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wemapgl_example/details/time_details.dart';

// ignore: must_be_immutable
class SingleTime extends StatelessWidget {
  //final int index;
  TimeDetails timeDetails;
  SingleTime(this.timeDetails);

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: Colors.white12,
      border: Border.all(
        width: 1.0,
        color: Colors.white30,
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(10.0) //                 <--- border radius here
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double resize = MediaQuery.of(context).devicePixelRatio/2.75;

    return
      Container(
        width: 48 * resize,
        decoration: myBoxDecoration(),
        margin: EdgeInsets.all(4 * resize),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4 * resize,),
                      Text(
                        '${timeDetails.temperature}',
                        style: GoogleFonts.lato(
                          fontSize: 13 * resize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4 * resize,),
                      SvgPicture.asset(
                        '${timeDetails.icon}',
                        width: 22 * resize,
                        height: 22 * resize,
                        color: timeDetails.color,
                      ),
                      SizedBox(height: 4 * resize,),
                      Text(
                          '${timeDetails.time}',
                          style: GoogleFonts.lato(
                            fontSize: 13 * resize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                    ],
                  ),
              ])
            )
          ],
        ),
      );
  }
}
