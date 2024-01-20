import 'package:easy_localization/easy_localization.dart';
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

SharedPreferences? sharedPreferences;
PrefService prefService = PrefService();
late AppColorsExtension customColors;
late TextExtension customTextStyle;
late String? targetRout;
late String? themeValue;
late UserInfo? user;
bool isGuset = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await EasyLocalization.ensureInitialized();

  themeValue = await prefService.readString('theme');
print(themeValue is String);
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
      theme: themeValue == ''?AppTheme.dark: themeValue ==  'dark' ? AppTheme.dark : AppTheme.light,
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
