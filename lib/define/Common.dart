import 'package:flutter/material.dart';

class Common {
  static const int _primaryValue = 0xFF26A69A;
  static const MaterialColor primaryColor = MaterialColor(
      _primaryValue,
      <int, Color> {
        50: Color(0xFFE5F4F3),
        100: Color(0xFFBEE4E1),
        200: Color(0xFF93D3CD),
        300: Color(0xFF67C1B8),
        400: Color(0xFF47B3A9),
        500: Color(_primaryValue),
        600: Color(0xFF229E92),
        700: Color(0xFF1C9588),
        800: Color(0xFF178B7E),
        900: Color(0xFF0D7B6C)
      }
  );
}