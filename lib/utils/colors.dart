import 'package:flutter/material.dart';

const backgroundColor = Color.fromRGBO(255, 255, 255,1);
const appBarColor = Color.fromRGBO(83, 83, 83, 1);
const whiteColor = Colors.white;
const headingColor = Color.fromRGBO(245, 245, 245, 1);
const missionColor = Color.fromRGBO(241, 241, 241, 1);
const splashScreenColor = Color.fromRGBO(222, 221, 221, 1);
const greyColor = Color(0xffE4E4E4);
const cardRectangleColor = Color.fromRGBO(0, 53, 102, 1);
const darkBlueColor = Color.fromRGBO(0, 53, 102, 1);
const cardOpacity = Color.fromRGBO(0, 53, 102, 0.7);
const textColor = Color.fromRGBO(83, 83,83, 1);
const lightTextColor = Color(0xFFA1A1A1);
const dateColor = Color.fromRGBO(255, 200,23, 1);
const yellowColor = Color.fromRGBO(255, 200,23, 1);
const backgroundgrey = Color(0xffD4D4D4);
const blackColor = Color(0xff000000);
const redColor = Color(0xffCA1C1C);

MaterialColor generateMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};

  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (int i = 0; i < strengths.length; i++) {
    final double ds = strengths[i];
    swatch[(ds * 1000).round()] = Color.fromRGBO(
      r,
      g,
      b,
      ds,
    );
  }

  return MaterialColor(color.value, swatch);
}