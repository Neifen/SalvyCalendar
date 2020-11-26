import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';

class Style {
  static const backgroundColor = Color(0x80f5f5f5);
  static const primaryColor = Color(0xffb71c1c);
  static const todayColor = Color(0xffb71c1c);
  static const unavailableColor = Color(0xffA55050);
  static const decoColor = Color(0xddffffff);

  static const buttonTextStyle =
      TextStyle(color: Colors.white, fontFamily: 'ProzaLibre', fontSize: 22.0);
  static const descriptionTextStyle =
      TextStyle(color: Colors.white, fontFamily: 'ProzaLibre', fontSize: 17.0);

  static const infoTextStyle = TextStyle(color: Color(0xffb71c1c));

  static const List randomPoints = [
    [Point(14.0, 5.0), Point(25.0, 4.0), Point(19.0, 5.0)], //1,13
    [Point(14.0, 4.0), Point(5.0, 5.0), Point(19.0, 5.0)], //2,14
    [Point(16.0, 3.0), Point(24.0, 5.0), Point(10.0, 5.0)], //3,15
    [Point(42.0, 6.0), Point(8.0, 10.0), Point(40.0, 5.0)], //4, 16
    [Point(6.0, 8.0), Point(20.0, 2.0), Point(10.0, 5.0)], //5, 17
    [Point(3.0, 5.0), Point(45.0, 4.0), Point(10.0, 5.0)], //6, 18
    [Point(12.0, 2.0), Point(2.0, 10.0), Point(20.0, 2.0)], //7, 19
    [Point(10.0, 3.0), Point(10.0, 5.0), Point(20.0, 5.0)], //8, 20
    [Point(31.0, 3.0), Point(6.0, 5.0), Point(50.0, 15.0)], //9, 21
    [Point(15.0, 4.0), Point(8.0, 8.0), Point(31.0, 6.0)], //10, 22
    [Point(20.0, 2.0), Point(15.0, 3.0), Point(31.0, 7.0)], //11, 23
    [Point(35.0, 6.0), Point(8.0, 10.0), Point(42.0, 5.0)], //12, 24
  ];
}
