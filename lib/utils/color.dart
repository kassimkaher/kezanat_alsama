import 'package:flutter/material.dart';

const jbPrimaryColor = Color(0xFF269DA1);
const jbAccesntPrimaryColor = Color(0xFFE5f2f7);
const scaffoldColor = Color(0xffF3F0E8);
const jbSecondary = Color(0xFFF19801);
const jbAccentSecondary = Color.fromARGB(255, 229, 111, 117);
const jbFontColor = Color(0xFF036D71);
const jbFontColor2 = Color(0xff269DA1);
const jbBorderColor = Color(0xFFE2E6EB);

const jbLoadingColorLight = Color(0xFFecf1f5);
const jbLoadingColorDark = Color(0xFF464A53);
const jbGrayCardColor = Color(0xFFE3E1DD);
const jbIconColor = Color(0xFFBBC4C9);
const jbDisableTextColor = Color(0xFF768492);
const jbIconActiveDark = Color(0xFFE6DBF3);
const jbOutlineColor = Color(0xFF41444A);
const jbGary2 = Color(0xffE6E7E8);
const jbUnselectColor = Color(0xFF768492);

const jbPrimaryColorD = Color(0xFF269DA1);
const jbAccesntPrimaryColorD = Color(0xFFE5f2f7);
const scaffoldColorD = Color(0xff212121);
const jbSecondaryD = Color(0xFFF19801);
const jbFontColorD = Colors.white;
const jbFontColor2D = Color(0xff868389);
const jbBorderColorD = Color(0xFFE2E6EB);

const jbLoadingColorLightD = Color(0xFFecf1f5);
const jbLoadingColorDarkD = Color(0xFF464A53);
const jbGrayCardColorD = Color(0xFFE3E1DD);
const jbIconColorD = Color(0xFFBBC4C9);
const jbDisableTextColorD = Color(0xFF768492);
const jbIconActiveDarkD = Color(0xFFE6DBF3);
const jbOutlineColorD = Color(0xFF41444A);
const jbGary2D = Color(0xffE6E7E8);
const jbUnselectColorD = Color(0xFF768492);

MaterialColor createMaterialColor(Color color) {
  final strengths = <double>[.05];
  final swatch = <int, Color>{};
  final r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (final strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }

  return MaterialColor(color.value, swatch);
}
