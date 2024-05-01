import 'package:flutter/material.dart';

import 'dimensions.dart';

ThemeData get themeData => ThemeData(
    appBarTheme: const AppBarTheme(),
    inputDecorationTheme: const InputDecorationTheme(border: InputBorder.none),
    fontFamily: "Inter",
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        fontSize: 20.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(paddingSmall)),
      minimumSize: const Size(padding, 58),
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    )),
    //sliderTheme:SliderTheme(data: data, child: child),
    useMaterial3: false,
    platform: TargetPlatform.iOS,
    colorScheme: const ColorScheme.light(primary: Colors.black));

ButtonStyle get shrinkedButton => TextButton.styleFrom(
    minimumSize: const Size(0, 0),
    padding: EdgeInsets.zero,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap);
