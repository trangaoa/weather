import 'package:flutter/cupertino.dart';

class ThemeDetails {
  String title;
  String bgimg;

  ThemeDetails({
    @required this.title,
    @required this.bgimg,
  });
}

final themeList = [
  ThemeDetails(title: 'default', bgimg: 'assets/theme/default.jpeg'),
  ThemeDetails(title: 'canvas', bgimg: 'assets/theme/canvas.jpeg'),
  ThemeDetails(title: 'pixel', bgimg: 'assets/theme/pixel.jpeg'),
  ThemeDetails(title: 'chinese', bgimg: 'assets/theme/chinese.jpeg'),
  ThemeDetails(title: 'photo', bgimg: 'assets/theme/photo.jpeg'),
];