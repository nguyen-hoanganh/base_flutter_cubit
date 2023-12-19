import 'package:flutter/material.dart';

class CommonColors {
  CommonColors._();

  static const primaryColor1 = Color(0xFF005795);
  static const primaryColor2 = Color(0xFF50AEF1);

  static const secondaryColor1 = Color(0xFF3A6797);
  static const secondaryColor2 = Color(0xFF6183BA);
  static const secondaryColor3 = Color(0xFFA0B9DF);
  static const secondaryColor4 = Color(0xFFC3DBFF);
  static const secondaryColor5 = Color(0xFFE0EDFF);
  static const secondaryColor6 = Color(0xFFC3DBFF);

  static const neutralColor1 = Color(0xFF000000);
  static const neutralColor2 = Color(0xFF333333);
  static const neutralColor3 = Color(0xFF777777);
  static const neutralColor4 = Color(0xFFA7A7A7);
  static const neutralColor5 = Color(0xFFD4D4D4);
  static const neutralColor6 = Color(0xFFEAEAEA);
  static const neutralColor7 = Color(0xFFFFFFFF);

  static const accentColor1 = Color(0xFFA12226);
  static const accentColor2 = Color(0xFFD64B4F);
  static const accentColor3 = Color(0xFFEAA601);
  static const accentColor4 = Color(0xFF8D0000);

  static final gradient1 = LinearGradient(
    colors: [
      const Color(0xffEAF6FF).withOpacity(1),
      const Color(0xffA9DBFF).withOpacity(1),
    ],
  );

  static final gradient3 = LinearGradient(
    colors: [
      const Color(0xffCEECF8).withOpacity(1),
      const Color(0xffE2E8F8).withOpacity(1),
      const Color(0xffF2F5FC).withOpacity(1),
      const Color(0xffFFFFFF).withOpacity(1),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
