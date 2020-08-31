import 'package:flutter/material.dart';

///
/// color util
class ColorUtil {

  // primary
  static const int p = 0xff4C84FF;
  static final MaterialColor primarySwatch = new MaterialColor(p, {
    50: primary50,
    100: primary100,
    200: primary200,
    300: primary,
    400: primary400,
    500: primary500,
    600: primary600,
    700: primary700,
    800: primary800,
    900: primary900
  });
  static const Color primary50 = Color(0xffA8C2FF);
  static const Color primary100 = Color(0xff87ACFF);
  static const Color primary200 = Color(0xff6796FF);
  static const Color primary = Color(p);
  static const Color primary400 = Color(0xff3B68FF);
  static const Color primary500 = Color(0xff2658FF);
  static const Color primary600 = Color(0xff164BFF);
  static const Color primary700 = Color(0xff0036EC);
  static const Color primary800 = Color(0xff0132D5);
  static const Color primary900 = Color(0xff012AB3);

  // secondary
  static const Color warning = Color(0xfffc5528);
  static const Color info = Color(0xff4d5afc);

  // neutral
  static const Color title = Color(0xff333333);
  static const Color subtitle = Color(0xff606060);
  static const Color regularText = Color(0xff606060);
  static const Color border = Color(0xffe4e4e4);
  static const Color divider = Color(0xffe9e9e9);
  static const Color disabledText = Color(0xff999999);
  static const Color disabledBackground = Color(0xffcccccc);
  static const Color background = Color(0xfff5f5f5);
  static const Color insideBackground = Color(0xfff2f2f2);

  ///
  /// Create a Color from red, green, blue
  static Color rgb(int red, int green, int blue) {
    return ColorUtil.rgba(red, green, blue, 1);
  }

  ///
  /// Create a Color from red, green, blue and alpha(opacity)
  static Color rgba(int red, int green, int blue, double opacity) {
    // 50
    // 100
    // 12
    //
    return Color.fromRGBO(red, green, blue, opacity);
  }

  ///
  /// Create a Color from radix-16 number and alpha(opacity)
  static Color hex(int hex, [double opacity = 1]) {
    return ColorUtil.rgba((hex & 0xFF0000) >> 16, // red
        (hex & 0x00FF00) >> 8, // green
        (hex & 0x0000FF), // blue
        opacity);
  }

  ///
  /// Create a Color from string, like #409bff in css
  static Color web(String hex, [double opacity = 1]) {
    if (hex.startsWith("#") && hex.length > 1) hex = hex.substring(1);
    else return ColorUtil.hex(0x000000);
    if (hex.length != 3 && hex.length != 6) return ColorUtil.hex(0x000000);
    if (hex.length == 3) {
      String nHex = "";
      for (int i = 0; i < 3; ++i) nHex += (hex[i] + hex[i]);
      hex = nHex;
    }
    hex = '0x' + hex;
    return ColorUtil.hex(int.parse(hex), opacity);
  }

}