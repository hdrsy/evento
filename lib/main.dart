import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/getx_navigation/routs.dart';
import 'package:evento/core/responsive/responsive.dart';
import 'package:evento/core/utils/extenstions/color_extenstions.dart';
import 'package:evento/core/utils/extenstions/text_extenstions.dart';
import 'package:evento/core/utils/services/pref_service.dart';
import 'package:evento/core/utils/services/user_info.dart';
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
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  themeValue = await prefService.readString('theme');
  targetRout=await prefService.isContainKey('token')?'/home':"/";
  user=await UserInfo.getUserInfo();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path:
            'assets/localization', // <-- change the path of the translation files
        fallbackLocale: const Locale('en'),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    initSizes(context);
    return GetMaterialApp(
      
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: themeValue == 'dark' ? AppTheme.dark : AppTheme.light,
      themeMode: ThemeMode.light,
      getPages: appRoutes(),
      initialRoute: targetRout,
      
    );
  }
}
