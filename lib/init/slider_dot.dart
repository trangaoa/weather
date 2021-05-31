import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SliderDot extends StatelessWidget {
  bool isActive;
  SliderDot(this.isActive);

  @override
  Widget build(BuildContext context) {
    double resize = MediaQuery.of(context).devicePixelRatio/2.75;

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: isActive ? 12 * resize : 5 * resize,
      height: 5 * resize,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white54,
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
    );
  }
}
