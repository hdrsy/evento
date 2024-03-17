import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/utils/services/connectivity_service.dart';
import 'package:evento/core/utils/services/pushy.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pushy_flutter/pushy_flutter.dart';
import 'core/getx_navigation/routs.dart';
import 'core/responsive/responsive.dart';
import 'core/utils/extenstions/color_extenstions.dart';
import 'core/utils/extenstions/text_extenstions.dart';
import 'package:evento/core/utils/services/pref_service.dart';
import 'package:evento/core/utils/services/user_info.dart';
import 'package:evento/core/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

RxBool isThereNotification = false.obs;
SharedPreferences? sharedPreferences;
PrefService prefService = PrefService();
late AppColorsExtension customColors;
late TextExtension customTextStyle;
late String? targetRout;
late String? themeValue;
UserInfo? user;
bool isGuset = false;
late Timer timer;
void startTimerToRemoveSplashScreen() {
  timer = Timer.periodic(const Duration(seconds: 10), (Timer t) {
    if (t.tick == 2) {
      // Timer reached 3 seconds
      t.cancel(); // Stop the timer
      FlutterNativeSplash.remove(); // Remove splash screen
    }
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  startTimerToRemoveSplashScreen();

  sharedPreferences = await SharedPreferences.getInstance();
  await EasyLocalization.ensureInitialized();
  // Start the Pushy service
  Pushy.listen();

  // Enable in-app notification banners (iOS 10+)
  Pushy.toggleInAppBanner(true);

  // Set custom notification icon (Android)
  Pushy.setNotificationIcon('@mipmap/launcher_icon');

  // Listen for push notifications received
  Pushy.setNotificationListener(backgroundNotificationListener);
  Pushy.setNotificationClickListener(notificationClickListener);

  themeValue = await prefService.readString('theme');
  themeValue == '' ? prefService.createString('theme', "dark") : null;
  targetRout = await prefService.isContainKey('token') &&
          await prefService.readString("isCompleteProfile") == "true"
      ? '/home'
      : "/";

  await Get.putAsync(() => ConnectivityService().init());
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path:
          'assets/localization', // <-- change the path of the translation files
      fallbackLocale: const Locale('en'),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    initSizes(context);
    return ScreenUtilInit(
        designSize: const Size(412, 915),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: themeValue == ''
                ? AppTheme.dark
                : themeValue == 'dark'
                    ? AppTheme.dark
                    : AppTheme.light,
            themeMode: ThemeMode.light,
            getPages: appRoutes(),
            initialRoute: targetRout,
          );
        });
  }
}

Future<String> getTergetRout() async {
  bool tokenState = await prefService.isContainKey('token');
  if (tokenState) {
    user = await UserInfo.getUserInfo();
    if (user != null) {
//  PusherService.initPusher();
//  await NotificationService().init();
      return '/home';
    } else {
      return '/';
    }
  } else {
    return '/';
  }
}
