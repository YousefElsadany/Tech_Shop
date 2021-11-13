import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

var darkMode = ThemeData(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    primarySwatch: shopColor,
    scaffoldBackgroundColor: Color(0xff1e272e),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xff1e272e),
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: Color(0xff1e272e),
      elevation: 0.0,
      backwardsCompatibility: false,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
    ),
    fontFamily: 'jannah',
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: shopColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: Color(0xff1e272e),
    ));

var lightMode = ThemeData(
    primarySwatch: shopColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: fullBackgroundColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: fullBackgroundColor,
      elevation: 0.0,
      backwardsCompatibility: false,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
    ),
    fontFamily: 'jannah',
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: shopColor,
    ));
