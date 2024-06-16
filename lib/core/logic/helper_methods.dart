import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_launcher/map_launcher.dart';

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

void pop() => Navigator.of(navigatorKey.currentContext!).pop();

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

String getOrderStatus(String status) {
  switch (status) {
    case 'pending':
      return "بإنتظار الموافقة";
    case 'preparation':
      return "جاري التحضير";
    case 'in_way':
      return "فى الطريق";
    case 'finished':
      return "منتهي";
    case 'canceled':
      return "طلب ملغي";
    case 'accepted':
      return "تم قبول الطلب";
    default:
      return "";
  }
}

Color getOrderStatusColor(String status) {
  switch (status) {
    case 'pending':
      return const Color(0xffE8F2DF);
    case 'preparation':
      return const Color(0xffC7F697);
    case 'in_way':
      return const Color(0xff96A9F6);
    case 'finished':
      return const Color(0xffEFEFEF);
    case 'canceled':
      return const Color(0xffFFCFCF);
    case 'accepted':
      return Colors.green;

    default:
      return Theme.of(navigatorKey.currentState!.context)
          .primaryColor
          .withOpacity(
            0.5,
          );
  }
}

Color getOrderStatusTextColor(String status) {
  switch (status) {
    case 'pending':
      return const Color(0xff4C8613);
    case 'preparation':
      return const Color(0xff72C720);
    case 'in_way':
      return const Color(0xff2D9E78);
    case 'finished':
      return const Color(0xff707070);
    case 'canceled':
      return const Color(0xffFF0000);
    case 'accepted':
      return const Color(0xffFFFFFF);

    default:
      return Theme.of(navigatorKey.currentState!.context)
          .primaryColor
          .withOpacity(
            0.5,
          );
  }
}

Future<void> getMaps(double lat, double lng) async {
  final availableMaps = await MapLauncher.installedMaps;
  if (kDebugMode) {
    print(availableMaps);
  }
  if (await MapLauncher.isMapAvailable(MapType.google) ?? false) {
    await availableMaps.first.showMarker(
      coords: Coords(lat, lng),
      title: "test",
    );
  }
}

Future<File> uploadPhoto({required BuildContext context, File? selectedImage}) async {
  await showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(38.r), topRight: Radius.circular(38.r))),
    builder: (context) => Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close)),
                const Text(
                  "إختار صورة من",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 32.r,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () async {
                    final image = await ImagePicker.platform.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 30,
                    );
                    if (image != null) {
                      selectedImage = File(image.path);
                      debugPrint(image.path);
                      Navigator.pop(context);
                    }
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.image_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      const Text("المعرض"),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final image2 = await ImagePicker.platform.pickImage(
                      source: ImageSource.camera,
                      imageQuality: 30,
                    );
                    if (image2 != null) {
                      selectedImage = File(image2.path);
                      debugPrint(image2.path);
                      Navigator.pop(context);
                    }
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      const Text("الكاميرا"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  return selectedImage!;
}
