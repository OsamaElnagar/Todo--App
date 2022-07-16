import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'colors.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: myColor,
  scaffoldBackgroundColor: HexColor('#082144'),
  appBarTheme: AppBarTheme(
    actionsIconTheme: const IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    backgroundColor: HexColor('#082144'),
    elevation: 0.0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: myColor,
      statusBarBrightness: Brightness.dark,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: myColor,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: myColor,
    unselectedItemColor: Colors.grey,
    elevation: 30.0,
    backgroundColor: HexColor('#082144'),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      height: 1.0,
    ),
    subtitle1: TextStyle(
      color: Colors.white,
    ),
    caption: TextStyle(color: Colors.white),
    headline4: TextStyle(color: Colors.white),
    headline5: TextStyle(color: Colors.white),
  ),
  cardTheme: const CardTheme(
    color: Colors.blue,
  ),
);

ThemeData lightTheme = ThemeData(
  primarySwatch: myColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: myColor,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: myColor,
      statusBarBrightness: Brightness.dark,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: myColor,
    unselectedItemColor: Colors.grey,
    elevation: 30.0,
    backgroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      color: Colors.white,
    ),
    caption: TextStyle(color: Colors.black),
    headline4: TextStyle(color: Colors.white),
    headline5: TextStyle(color: Colors.white),
  ),
  cardTheme: const CardTheme(
    color: Colors.blue,
  ),
);
