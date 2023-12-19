import 'package:cbp_mobile_app_flutter/common/theme/common_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TextConstants {
  static const fontRoboto = 'Roboto';
  static const fontDINPro = 'DINpro';
}

class CommonTextStyle {
  CommonTextStyle._();

  // Support font/Title 1
  static TextStyle supportFontTitle1 = TextStyle(
    color: CommonColors.neutralColor1,
    fontSize: 24.fs,
    fontWeight: FontWeight.w500,
    fontFamily: TextConstants.fontRoboto,
  );

  // Support font/Title 2
  static TextStyle supportFontTitle2 = TextStyle(
    color: CommonColors.neutralColor1,
    fontSize: 24.fs,
    fontWeight: FontWeight.w700,
    fontFamily: TextConstants.fontRoboto,
  );

  // Support font/Title 3
  static TextStyle supportFontTitle3 = TextStyle(
    color: CommonColors.neutralColor1,
    fontSize: 18.fs,
    fontWeight: FontWeight.w500,
    fontFamily: TextConstants.fontRoboto,
  );

  // Support font/Title 4
  static TextStyle supportFontTitle4 = TextStyle(
    color: CommonColors.neutralColor1,
    fontSize: 16.fs,
    fontWeight: FontWeight.w500,
    fontFamily: TextConstants.fontRoboto,
  );

  // Support font/Subtitle 1
  static TextStyle supportFontSubtitle1 = TextStyle(
    color: CommonColors.neutralColor1,
    fontSize: 14.fs,
    fontWeight: FontWeight.w400,
    fontFamily: TextConstants.fontRoboto,
  );

  // Support font/Subtitle 2
  static TextStyle supportFontSubtitle2 = TextStyle(
    color: CommonColors.neutralColor1,
    fontSize: 12.fs,
    fontWeight: FontWeight.w300,
    fontFamily: TextConstants.fontRoboto,
  );

  // Support font/Subtitle 3
  static TextStyle supportFontSubtitle3 = TextStyle(
    color: CommonColors.neutralColor1,
    fontSize: 10.fs,
    fontWeight: FontWeight.w400,
    fontFamily: TextConstants.fontRoboto,
    letterSpacing: 0.4.s,
  );

  // heading/H 1
  static TextStyle headingH1 = TextStyle(
    color: CommonColors.neutralColor1,
    fontSize: 40.fs,
    fontWeight: FontWeight.w500,
    fontFamily: TextConstants.fontDINPro,
  );

  // heading/H 2
  static TextStyle headingH2 = TextStyle(
    color: CommonColors.neutralColor1,
    fontSize: 32.fs,
    fontWeight: FontWeight.w500,
    fontFamily: TextConstants.fontDINPro,
  );

  // heading/H 3
  static TextStyle headingH3 = TextStyle(
    color: CommonColors.neutralColor1,
    fontSize: 32.fs,
    fontWeight: FontWeight.w700,
    fontFamily: TextConstants.fontDINPro,
  );

  // heading/H 4
  static TextStyle headingH4 = TextStyle(
    color: CommonColors.neutralColor1,
    fontSize: 28.fs,
    fontWeight: FontWeight.w500,
    fontFamily: TextConstants.fontDINPro,
  );

  // heading/H 5
  static TextStyle headingH5 = TextStyle(
    color: CommonColors.neutralColor1,
    fontSize: 28.fs,
    fontWeight: FontWeight.w700,
    fontFamily: TextConstants.fontDINPro,
  );

  // heading/H 6
  static TextStyle headingH6 = TextStyle(
    color: CommonColors.neutralColor1,
    fontSize: 24.fs,
    fontWeight: FontWeight.w700,
    fontFamily: TextConstants.fontDINPro,
  );

  // body/B 1
  static TextStyle bodyB1 = TextStyle(
    color: CommonColors.neutralColor1,
    fontSize: 24.fs,
    fontWeight: FontWeight.w500,
    fontFamily: TextConstants.fontDINPro,
  );

  // body/B 2
  static TextStyle bodyB2 = TextStyle(
    color: CommonColors.neutralColor1,
    fontSize: 18.fs,
    fontWeight: FontWeight.w500,
    fontFamily: TextConstants.fontDINPro,
  );

  // body/B 3
  static TextStyle bodyB3 = TextStyle(
    color: CommonColors.neutralColor1,
    fontSize: 16.fs,
    fontWeight: FontWeight.w500,
    fontFamily: TextConstants.fontDINPro,
  );

  // body/B 4
  static TextStyle bodyB4 = TextStyle(
    color: CommonColors.neutralColor1,
    fontSize: 14.fs,
    fontWeight: FontWeight.w500,
    fontFamily: TextConstants.fontDINPro,
  );

  // script/Subtitle 1
  static TextStyle scriptSubtitle1 = TextStyle(
    color: CommonColors.neutralColor1,
    fontSize: 12.fs,
    fontWeight: FontWeight.w500,
    fontFamily: TextConstants.fontDINPro,
  );

  // script/Subtitle 2
  static TextStyle scriptSubtitle2 = TextStyle(
    color: CommonColors.neutralColor1,
    fontSize: 10.fs,
    fontWeight: FontWeight.w500,
    fontFamily: TextConstants.fontDINPro,
    letterSpacing: 0.4.s,
  );
}
