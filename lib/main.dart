import 'dart:async';
import 'package:app_links/app_links.dart';
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
startTimerToRemoveSplashScreen() {
  timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
    if (t.tick == 2) {
      // Timer reached 3 seconds
      t.cancel(); // Stop the timer
      FlutterNativeSplash.remove(); // Remove splash screen
    }
  });
}

void main() async {
  WidgetsBinding widgetsBinding =
      await WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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

void _handleLink(String? link) {
  if (link != null && link.contains('/#/ShowReelScreen')) {
    // Attempting to manually extract the 'id' from the URL.
    final uri = Uri.parse(link);
    final fragments =
        uri.fragment?.split('?'); // Splitting the fragment by '?'.

    // Assuming the format is always '/ShowReelScreen?id=XX'
    if (fragments != null && fragments.length > 1) {
      final fragmentQuery = fragments[1];
      final fakeUri = Uri.parse('dummy://dummy?$fragmentQuery');
      final id = fakeUri.queryParameters['id'];

      if (id != null) {
        // Check if GetX is ready for navigation
        if (Get.context != null) {
          Get.toNamed('/ShowReelScreen', parameters: {'id': id});
        } else {
          // Wait for GetX navigation to be ready
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.toNamed('/ShowReelScreen', parameters: {'id': id});
          });
        }
      }
    }
  } else if (link != null && link.contains('/#/eventDetailes')) {
    final uri = Uri.parse(link);
    final fragments = uri.fragment?.split('?'); // Splitting the fragment by '?'

    // Assuming the format is '/eventDetailes?id=XX&isOffer=XX&offerPercent=XX'
    if (fragments != null && fragments.length > 1) {
      final fragmentQuery = fragments[1];
      final fakeUri = Uri.parse('dummy://dummy?$fragmentQuery');

      // Now, extract the specific parameters
      final id = fakeUri.queryParameters['id'];

      if (id != null) {
        // Check if GetX is ready for navigation
        if (Get.context != null) {
          // Navigating to the Event Details screen with the extracted parameters

          Get.toNamed('/eventDetailes', parameters: {
            'id': id,
          });
        } else {
          // Wait for GetX navigation to be ready
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.toNamed('/eventDetailes', parameters: {
              'id': id,
            });
          });
        }
      }
    }
  } else if (link != null && link.contains('/#/ShowSingleTicketScreen')) {
    final uri = Uri.parse(link);
    final fragments = uri.fragment?.split('?'); // Splitting the fragment by '?'

    // Assuming the format is '/eventDetailes?id=XX&isOffer=XX&offerPercent=XX'
    if (fragments != null && fragments.length > 1) {
      final fragmentQuery = fragments[1];
      final fakeUri = Uri.parse('dummy://dummy?$fragmentQuery');

      // Now, extract the specific parameters
      final id = fakeUri.queryParameters['id'];

      if (id != null) {
        // Check if GetX is ready for navigation
        if (Get.context != null) {
          // Navigating to the Event Details screen with the extracted parameters

          Get.toNamed('/ShowSingleTicketScreen', parameters: {
            'id': id,
          });
        } else {
          // Wait for GetX navigation to be ready
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.toNamed('/ShowSingleTicketScreen', parameters: {
              'id': id,
            });
          });
        }
      }
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppLinks _appLinks; // Create an instance of AppLinks

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks(); // Initialize the AppLinks instance
    initDeepLinkHandling();
  }

  void initDeepLinkHandling() async {
    // final initialLink = await getInitialLink();
    final Uri? initialUri = await _appLinks.getInitialAppLink();
    if (initialUri != null) {
      _handleLink(initialUri.toString());
    }
    // Listen to incoming app link
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleLink(uri.toString());
      }
    }, onError: (err) {
      // Handle errors (e.g., if the app link was not formatted correctly)
     });
  }

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
