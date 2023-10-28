import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

final navigatorKey = GlobalKey<NavigatorState>();

Future navigateTo(Widget page, {bool removeHistory = false}) {
  return Navigator.pushAndRemoveUntil(
    navigatorKey.currentContext!,
    MaterialPageRoute(
      builder: (context) => page,
    ),
        (route) => true,
  );
}

enum MessageType { success, fail, warning }
void showSnackBar(String message, {MessageType typ = MessageType.fail}) {
  if (message.isNotEmpty) {
    ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        elevation: 0,
        backgroundColor: typ == MessageType.fail
            ? Colors.red
            : typ == MessageType.warning
            ? Colors.yellow
            : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            15.r,
          ),
        ),
      ),
    );
  }
}
