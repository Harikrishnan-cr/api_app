import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samastha/core/app_constants.dart';

import 'color_resources.dart';
import 'dimensions.dart';

TextStyle displayLarge = GoogleFonts.playfairDisplay(
  fontSize: 56,
  fontWeight: FontWeight.w700,
);

TextStyle displayMedium = GoogleFonts.playfairDisplay(
  fontSize: 27,
  fontWeight: FontWeight.w700,
);
TextStyle displaySmall = GoogleFonts.playfairDisplay(
  fontSize: 24,
  fontWeight: FontWeight.w700,
);

TextStyle headlineLarge = GoogleFonts.inter(
  fontSize: 18,
  fontWeight: FontWeight.w700,
);

TextStyle button = GoogleFonts.openSans(
  fontSize: 18,
  fontWeight: FontWeight.w700,
);

TextStyle headlineMedium = GoogleFonts.inter(
  fontSize: 30,
  fontWeight: FontWeight.w700,
);

TextStyle headlineSmall = GoogleFonts.playfairDisplay(
  fontSize: 12,
  fontWeight: FontWeight.w700,
);
TextStyle titleLarge = GoogleFonts.inter(
  fontSize: 18,
  fontWeight: FontWeight.w700,
);

TextStyle titleMedium = GoogleFonts.inter(
  fontSize: 16,
  fontWeight: FontWeight.w700,
);

TextStyle titleSmall = GoogleFonts.inter(
  fontSize: 14,
  fontWeight: FontWeight.w700,
);
TextStyle labelLarge = GoogleFonts.inter(
  fontSize: 14,
  fontWeight: FontWeight.w400,
);

TextStyle labelMedium = GoogleFonts.inter(
  fontSize: 12,
  fontWeight: FontWeight.w400,
);

//
TextStyle labelSmall = GoogleFonts.inter(
  fontSize: 14,
  fontWeight: FontWeight.w400,
);

TextStyle bodyLarge = GoogleFonts.playfairDisplay(
  fontSize: 24,
  fontWeight: FontWeight.w500,
);

TextStyle bodyMedium = GoogleFonts.inter(
  fontSize: 14,
  fontWeight: FontWeight.w400,
);
TextStyle bodySmall = GoogleFonts.playfairDisplay(
  fontSize: 18,
  fontWeight: FontWeight.w500,
);

TextStyle f16w400 = GoogleFonts.inter(
  fontSize: 18,
  fontWeight: FontWeight.w500,
);

EdgeInsets pagePadding = EdgeInsets.only(
    left: 24,
    right: 24,
    top: 24,
    bottom: 96 +
        MediaQuery.paddingOf(AppConstants.globalNavigatorKey.currentContext!)
            .bottom);

const EdgeInsets pagePaddingXL = EdgeInsets.symmetric(horizontal: paddingXL);

extension TextStyleExtensions on TextStyle {
  TextStyle get primary => copyWith(color: ColorResources.primary);
  TextStyle get border => copyWith(color: ColorResources.BORDER);
  TextStyle get borderShade => copyWith(color: ColorResources.BORDER_SHADE);
  TextStyle get green => copyWith(color: ColorResources.GREEN);
  TextStyle get grey => copyWith(color: ColorResources.grey);
  TextStyle get grey1 => copyWith(color: ColorResources.GREY1);
  TextStyle get grey2 => copyWith(color: ColorResources.GREY2);
  TextStyle get placeholder => copyWith(color: ColorResources.PLACEHOLDER);
  TextStyle get red => copyWith(color: ColorResources.RED);
  TextStyle get secondary => copyWith(color: ColorResources.secondary);
  TextStyle get text1 => copyWith(color: ColorResources.TEXT1);
  TextStyle get text2 => copyWith(color: ColorResources.TEXT2);

  TextStyle get black => copyWith(color: ColorResources.black);

  TextStyle get white => copyWith(color: ColorResources.WHITE);

  //samastha
  TextStyle get darkBG => copyWith(color: ColorResources.darkBG);

  TextStyle get s10 => copyWith(fontSize: 10.0);
  TextStyle get s12 => copyWith(fontSize: 12.0);
  TextStyle get s14 => copyWith(fontSize: 14.0);
  TextStyle get s16 => copyWith(fontSize: 16.0);
  TextStyle get s18 => copyWith(fontSize: 18.0);
  TextStyle get s25 => copyWith(fontSize: 25.0);
  TextStyle get s30 => copyWith(fontSize: 30.0);
  TextStyle get w400 => copyWith(fontWeight: FontWeight.w400);
  TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);
  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);
  TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);
}
