import 'package:flutter/cupertino.dart';

import 'colors.dart';

class CustomTextTheme {
  static const TextStyle normalTextTheme = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    color: textColor,
  );
  static const TextStyle boldTextTheme = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12,
      color: textColor,
      fontWeight: FontWeight.bold);
  static const TextStyle extraBoldTextTheme = TextStyle(
    fontFamily: 'PoppinsBold',
    fontSize: 12,
    color: textColor,
  );

// 12 font Size
  static double extraSmallFontSize(BuildContext context) {
    //double fontSize = ScreenUtils.height(context) * 0.014;
    double fontSize = 12.0;
    return fontSize;
  }

// 15 fontSize
  static double smallFontSize(BuildContext context) {
    //double fontSize = ScreenUtils.height(context) * 0.0176;
    double fontSize = 15.0;
    return fontSize;
  }

// 20 fontSize
  static double mediumFontSize(BuildContext context) {
    //double fontSize = ScreenUtils.height(context) * 0.02347418;
    double fontSize = 20.0;
    return fontSize;
  }

// 25 fontSize
  static double largeFontSize(BuildContext context) {
    //double fontSize = ScreenUtils.height(context) * 0.02934272;
    double fontSize = 25.0;
    return fontSize;
  }

  // 30 fontSize
  static double extraLargeFontSize(BuildContext context) {
    //double fontSize = ScreenUtils.height(context) * 0.0352;
    double fontSize = 30.0;
    return fontSize;
  }
}
