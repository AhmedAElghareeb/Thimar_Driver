import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar_driver/core/logic/cache_helper.dart';
import 'package:thimar_driver/core/logic/kiwi.dart';
import 'core/logic/helper_methods.dart';
import 'firebase_options.dart';
import 'views/auth/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.instance.getToken().then((value) {
    if (kDebugMode) {
      print(
      "Token is : $value",
    );
    }
  });
  initKiwi();
  CacheHelper.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(
        0xff4C8613,
      ),
      statusBarIconBrightness: Brightness.light,
    ),
  );
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        375,
        815,
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        builder: (context, child) => Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        ),
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: const Color(
              0xffFFFFFF,
            ),
            centerTitle: true,
            elevation: 0,
            titleTextStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: getMaterialColor(),
            ),
          ),
          useMaterial3: false,
          primarySwatch: getMaterialColor(),
          platform: TargetPlatform.iOS,
          fontFamily: "Tajawal",
          scaffoldBackgroundColor: Colors.white,
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(
                  15.r,
                ),
              ),
              side: const BorderSide(
                color: Color(0xFF4C8613),
              ),
            ),
          ),
          filledButtonTheme: FilledButtonThemeData(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(
                  15.r,
                ),
              ),
              maximumSize: Size(
                343.w,
                60.h,
              ),
              textStyle:
                  TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              side: const BorderSide(
                color: Color(0xFFFFE1E1),
              ),
              backgroundColor: getMaterialColor(),
            ),
          ),
        ),
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: const SplashView(),
      ),
    );
  }
}
