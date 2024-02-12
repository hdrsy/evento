import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/utils/services/check_internet.dart';
import 'package:evento/core/utils/services/connectivity_service.dart';
import 'package:evento/core/utils/services/socket_servie.dart';
import 'package:evento/core/utils/services/work_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workmanager/workmanager.dart';
import 'core/getx_navigation/routs.dart';
import 'core/responsive/responsive.dart';
import 'core/utils/extenstions/color_extenstions.dart';
import 'core/utils/extenstions/text_extenstions.dart';
// import 'package:sizer/sizer.dart';
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
@pragma('vm:entry-point')
void callbackDispatcher() {
  print("Top of call back");
  Workmanager().executeTask((task, inputData) async {
    // Your background task code goes here
    // user = await UserInfo.getUserInfo();
    print("start work manager");
    if (task == 'notificationSystem') {
      print("This is a simple periodic task");
      listenToEvents(2);
      // Your background task code here
    }
    // listenToEvents(user!.id);
    print("Native called background task: $task"); // example task
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await EasyLocalization.ensureInitialized();

  themeValue = await prefService.readString('theme');
  themeValue == '' ? prefService.createString('theme', "dark") : null;
  targetRout = await prefService.isContainKey('token') &&
          await prefService.readString("isCompleteProfile") == "true"
      ? '/home'
      : "/";

  // await Workmanager().initialize(
  //   callbackDispatcher, // The top-level function, defined above
  //   isInDebugMode: true, // Set to true to see logs in debug mode
  // );
  // registertask();
  print("after init");
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
    // Messagess messagess=Messagess();
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
