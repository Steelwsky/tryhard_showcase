import 'package:flutter/material.dart';

import 'colors.dart';

final ThemeData myTheme = ThemeData(
    fontFamily: 'SairaSemiCondensed',
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: AppColors.backgroundPrimary,
    primarySwatch: AppColors.swatch,
    brightness: Brightness.dark,
    textTheme: const TextTheme(bodyText1: TextStyle(color: Colors.white)),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: AppColors.buttonPrimary,
        splashFactory: NoSplash.splashFactory,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: AppColors.navbar),
    scaffoldBackgroundColor: AppColors.backgroundPrimary,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: AppColors.backgroundPrimary, backgroundColor: AppColors.primary),
    indicatorColor: AppColors.primary,
    buttonTheme: const ButtonThemeData(),
    highlightColor: Colors.transparent,
    focusColor: Colors.transparent,
    hoverColor: Colors.transparent,
    errorColor: AppColors.caution,
    cardColor: AppColors.backgroundSecondary,
    splashColor: Colors.transparent,
    colorScheme: const ColorScheme.dark(primary: AppColors.primary, secondary: AppColors.secondary),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: AppColors.grey),
      prefixIconColor: AppColors.grey,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.white,
      selectionColor: AppColors.primary,
      selectionHandleColor: Colors.transparent,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }
    )
);