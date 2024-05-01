// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';


class ColorResources {
  static const Color primary = Color(0xff55B059);
  static const Color GREY1 = Color(0xff696E72);

  static const Color GREY2 = Color(0xffbcbedb);
  static const Color GREY3 = Color(0xffd9dae4);
  static const Color GREY4 = Color(0xfff2f2f2);
  static const Color GREY5 = Color(0xfff6f6f6);

  static const Color GREEN = Color(0xff1cc02d);
  static const Color RED = Color(0xffEB1313);
  static const Color YELLOW = Color(0xffefba00);
  static const Color WHITE = Colors.white;
  static const Color BLACKGREY = Color(0xff686868);

//to remove

  static const Color BORDER = GREY2;
  //Color(0xFFE7E7E7);
  static const Color PLACEHOLDER = Color(0xFFD9D9D9);
  static const Color TEXT1 = Color(0xFF2F4858);
  static const Color TEXT2 = Color(0xFF334B77);

  static const Color grey = Color(0xFF939393);
  // static const Color WHITE = Colors.white;

  static const Color BORDER_SHADE = Color(0xFFF6F6F6);

  static const Color BLUE = Color(0xFF0348CF);
  static const Color CHART_BOOKING = Color(0xFF52ABFD);
  static const Color CHART_REVENUE = Color(0xFF1BC9CD);
  static const Color LAVENDER = Color(0xFF703EC2);

  static const Color CHART_HOLD = Color(0xFFFFBD5A);
  static const Color CHART_CANCEL = Color(0xFFDB0000);

  //samastha
  static const Color darkBG = Color(0xFF001319);
  static const Color secondary = Color(0xff1696BB);
  static const Color textFiledBorder = Color(0xff10A089);

  static const Color gradientButtonStart = Color(0xff1696BB);
  static const Color gradientButtonEnd = Color(0xff00B707);
  static Color dropshadowGreen = const Color(0xff03B21F).withOpacity(.20);

  static const Color gradientNavStart = Color(0xff08AA4D);
  static const Color gradientNavEnd = Color(0xff129c98);

  static const Color warningYellow = Color(0xffEBB700);

  static const Color black = Colors.black;

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.isEmpty) {
      return const Color(0xFF252525);
    } else {
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    }
  }

  static BoxShadow optionsShadow = const BoxShadow(
    // blurRadius: 10,
    color: Color.fromRGBO(0, 0, 0, 0.1),
    offset: Offset(0, 4),
    spreadRadius: 10,
  );

  static LinearGradient npGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF652D92),
      Color(0xFF2E3192),
      Color(0xFF2353A8),
      Color(0xFF0D95D5),
    ],
    stops: [0, 0.31, 0.67, 0.93],
  );

  static LinearGradient brandGradient = const LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color(0xfff49b1a),
      Color(0xffff7b39),
      Color(0xffff4e52),
      Color(0xfff80080),
      Color(0xffac018b),
      Color(0xff810090),
    ],
    // stops: [0, 0.31, 0.67, 0.93],
  );
  static LinearGradient splashgradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xffff1b6f), Color(0xffff5c4a), Color(0xff141e3c)],
    // stops: [0, 0.31, 0.67, 0.93],
  );

  // colors: [Color(0xffff1b6f), Color(0xffff5c4a), Color(0xff141e3c)],
  static LinearGradient darkblueGradient = const LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Color(0xff141e3c), Color(0x00141e3c),
      // Color(0x00141e3c),
    ],
    // stops: [10, 12, 5, 8],
  );

// LinearGradient(
//               colors: [Colors.blue, Colors.purple],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
  static final ThemeData datePickerTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: primary,
      brightness: Brightness.light,
      onPrimary: WHITE,
      surface: WHITE,
      onSurface: black,
      onBackground: WHITE,
      secondary: primary,
    ),
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: const TextTheme(
        // subtitle1: subHeading1.primary,
        ),
  );
}
