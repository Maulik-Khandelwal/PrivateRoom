import 'package:flutter/material.dart';

// Colors used in app
const Color kImperialRed = Color(0xff009d9d);
const Color kWhite = Color(0xffFFFFFF);
const Color kSteelBlue = Color(0xff38d0d0);
const Color kLightBlue = Color(0xffFFD7D7);
const Color kLBlue = Color(0xffD7DEF8);
const Color kDBlue = Color(0xff1976D2);
const Color kBlack = Color(0xff000000);

const kLightestTextStyle = TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.w900,
  color: kBlack,
);

const kLightLabelTextStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w100,
  color: kBlack,
);

const kLabelTextStyle = TextStyle(
  fontSize: 15.0,
  color: kBlack,
);

const kGeneralTextStyle = TextStyle(
  fontSize: 18.0,
  color: kWhite,
);

const kTitleTextStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.w600,
  color: kBlack,
);

const kHeadingTextStyle = TextStyle(
  fontSize: 45.0,
  fontWeight: FontWeight.w900,
  color: kWhite,
);

Color darkenColor(Color color, [double amount = 0.30]) {
  assert(amount >= 0 && amount <= 1);
  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
  return hslDark.toColor();
}