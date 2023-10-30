
import 'package:flutter/material.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Home/HomeScreen.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Profile/ProfileScreen.dart';
import 'package:kcgerp/Feature/Screen/OverScreen/Request/RequestScreen.dart';
import 'package:kcgerp/Util/util.dart';
import 'package:showcaseview/showcaseview.dart';

// Overscreen Navigation Screens
List<Widget> page = [
    HomeScreen(),
    RequestScreen(),
    // TimeTableScreen(),
    ShowCaseWidget(
      builder: Builder(builder: (context) => ProfileScreen())
    ),
  ];

  
  final List<Color> screenBackGroundColor = [
    themeColor.backgroundColor,
    themeColor.backgroundColor,
    themeColor.backgroundColor,
    themeColor.backgroundColor,
  ];