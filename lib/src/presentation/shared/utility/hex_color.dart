import 'package:flutter/material.dart';

class HexColor extends Color {
  static int getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  static Color getColorByStringValue(String valueToConvert) {
    String valueString =
        valueToConvert.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    return Color(value);
  }

  HexColor(final String hexColor) : super(getColorFromHex(hexColor));
}
