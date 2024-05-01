import 'package:flutter/material.dart';

const double padding = 8;
const double paddingSmall = padding / 2;
const double paddingLarge = padding * 2;
const double paddingXL = padding * 4;
const double paddingTiny = paddingSmall / 2;

const gap = SizedBox(height: padding);
const gapXL = SizedBox(height: paddingXL);
const gapLarge = SizedBox(height: paddingLarge);
const gapSmall = SizedBox(height: paddingSmall);
const gapTiny = SizedBox(height: paddingTiny);

const gapHorizontal = SizedBox(width: padding);
const gapHorizontalLarge = SizedBox(width: paddingLarge);
const gapHorizontalXl = SizedBox(width: paddingXL);
const gapHorizontalSmall = SizedBox(width: paddingSmall);
const gapHorizontalTiny = SizedBox(width: paddingTiny);

const double screenpadding = 24;
const double screenpaddingmini = 16;

const Duration animationDuration = Duration(seconds: 1);

BoxDecoration defaultDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        blurRadius: 30,
        spreadRadius: 0,
        offset: Offset(0, 10),
        color: Color(0xfff0f0f0),
      )
    ]);
