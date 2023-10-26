import 'package:flutter/material.dart';

MaterialColor getMaterialColor() {
  Color color = const Color(0xFF4C8613);
  final Map<int, Color> shades = {
    50: color.withOpacity(.1),
    100: color.withOpacity(.2),
    200: color.withOpacity(.3),
    300: color.withOpacity(.4),
    400: color.withOpacity(.5),
    500: color.withOpacity(.6),
    600: color.withOpacity(.7),
    700: color.withOpacity(.8),
    800: color.withOpacity(.9),
    900: color,
  };
  return MaterialColor(color.value, shades);
}
