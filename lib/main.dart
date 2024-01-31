import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/utils/services/fire_base_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/getx_navigation/routs.dart';
import 'core/responsive/responsive.dart';
import 'core/utils/extenstions/color_extenstions.dart';
import 'core/utils/extenstions/text_extenstions.dart';

import 'core/utils/services/notification_service.dart';

import 'package:evento/core/utils/services/pref_service.dart';

import 'package:evento/core/utils/services/user_info.dart';
import 'package:evento/core/utils/theme/app_theme.dart';
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
UserInfo? user = null;
bool isGuset = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await EasyLocalization.ensureInitialized();
  // Platform.isAndroid
  //     ? await Firebase.initializeApp(
  //         options: const FirebaseOptions(
  //             apiKey: "AIzaSyDSZ4ulFXW6nvxZw22ET-d4ejxjWV8daGU",
  //             appId: "1:631957135040:android:3916fbaae446ba245f5725",
  //             messagingSenderId: "631957135040",
  //             projectId: "evento-app-d813c"))
  //     : await Firebase.initializeApp();
  // await FirebaseApi().initNotification();

  themeValue = await prefService.readString('theme');
  themeValue == '' ? prefService.createString('theme', "dark") : null;
  targetRout = await prefService.isContainKey('token') &&
          await prefService.readString("isCompleteProfile") == "true"
      ? '/home'
      : "/";

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
    // Messagess messagess=Messagess();
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
