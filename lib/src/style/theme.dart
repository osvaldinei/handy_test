import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {

  const Colors();

 // static const Color loginGradientStart = const Color(0xFFfbab66);
  static const Color loginGradientStart = const Color(0xFFf6d100);
  static const Color loginGradientEnd = const Color(0xFFf7418c);
  static const azulLogo = Color(0xff59B5E6);
  static const azulLogoClaro = Color(0xff5B74D8);
  static const azulLogo3 = Color(0xff898EA3);
  static const laranjaLogo = Color(0xffF16136);
  static const laranjaLogoClaro = Color(0xffEF8467);
  static const white = Color(0xfffafafa);
  static const black = Color(0xff212121);
  static const gray1 = Color(0xffE6E9F7);
  static const gasolina = Color(0xfff4451f);
  static const etanol = Color(0xff00BA21);
  static const diesel = Color(0xffA0A0A0);




  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}