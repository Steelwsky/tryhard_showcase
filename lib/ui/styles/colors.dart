import 'dart:math';

import 'package:flutter/material.dart';

abstract class AppColors {
  const AppColors._();

  static const swatch = MaterialColor(0xFF880E4F, _primary);
  static const primary = Color.fromARGB(255, 100, 22, 100);
  static const secondary = Colors.purple;
  static const caution = Color.fromARGB(255, 207, 102, 121);
  static const backgroundPrimary = Color.fromARGB(255, 20, 20, 20);
  static const backgroundSecondary = Color.fromARGB(255, 41, 41, 41);
  static const navbar = Color.fromARGB(255, 28, 28, 28);
  static const buttonPrimary = primary;
  static const buttonSecondary = Color.fromARGB(255, 144, 144, 144);
  static const buttonDeletion = Color.fromARGB(255, 207, 102, 121);
  static const grey = Color.fromARGB(255, 120, 120, 120);
  static const white = Colors.white;

  static const userCalendar1 = Color.fromARGB(255, 118, 65, 118);
  static const userCalendar2 = Color.fromARGB(255, 132, 46, 82);
  static const userCalendar3 = Color.fromARGB(255, 255, 119, 119);
  static const userCalendar4 = Color.fromARGB(255, 149, 81, 81);
  static const userCalendar5 = Color.fromARGB(255, 92, 59, 59);
  static const userCalendar6 = Color.fromARGB(255, 234, 126, 92);
  static const userCalendar7 = Color.fromARGB(255, 223, 150, 83);
  static const userCalendar8 = Color.fromARGB(255, 240, 204, 77);
  static const userCalendar9 = Color.fromARGB(255, 96, 77, 149);
  static const userCalendar10 = Color.fromARGB(255, 139, 167, 80);
  static const userCalendar11 = Color.fromARGB(255, 73, 168, 134);
  static const userCalendar12 = Color.fromARGB(255, 90, 127, 200);
  static const userCalendar13 = Color.fromARGB(255, 141, 139, 87);
  static const userCalendar14 = Color.fromARGB(255, 184, 155, 80);
  static const userCalendar15 = Color.fromARGB(255, 73, 172, 193);

  static List<Color> getUserColors() {
    return [
      primary,
      userCalendar1,
      userCalendar2,
      userCalendar3,
      userCalendar4,
      userCalendar5,
      userCalendar6,
      userCalendar7,
      userCalendar8,
      userCalendar9,
      userCalendar10,
      userCalendar11,
      userCalendar12,
      userCalendar13,
      userCalendar14,
      userCalendar15,
    ];
  }

  static Color getRandomColor() {
    final list = [
      userCalendar1,
      userCalendar2,
      userCalendar3,
      userCalendar4,
      userCalendar5,
      userCalendar6,
      userCalendar7,
      userCalendar8,
      userCalendar9,
      userCalendar10,
      userCalendar11,
      userCalendar12,
      userCalendar13,
      userCalendar14,
      userCalendar15,
    ];
    final random = Random();
    var randomColor = list[random.nextInt(list.length)];
    return randomColor;
  }

  static const Map<int, Color> _primary = {
    50: Color.fromRGBO(100, 22, 100, .1),
    100: Color.fromRGBO(100, 22, 100, .2),
    200: Color.fromRGBO(100, 22, 100, .3),
    300: Color.fromRGBO(100, 22, 100, .4),
    400: Color.fromRGBO(100, 22, 100, .5),
    500: Color.fromRGBO(100, 22, 100, .6),
    600: Color.fromRGBO(100, 22, 100, .7),
    700: Color.fromRGBO(100, 22, 100, .8),
    800: Color.fromRGBO(100, 22, 100, .9),
    900: Color.fromRGBO(100, 22, 100, 1),
  };
}
