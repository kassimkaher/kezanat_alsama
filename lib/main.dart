import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'package:ramadan/bussines_logic/Setting/settings_cubit.dart';
import 'package:ramadan/bussines_logic/dua/dua_cubit.dart';
import 'package:ramadan/bussines_logic/notification_service.dart';
import 'package:ramadan/bussines_logic/quran/quran_cubit.dart';
import 'package:ramadan/bussines_logic/ramadan/ramadan_cubit.dart';
import 'package:ramadan/pages/splash_page.dart';
import 'package:ramadan/utils/theme.dart';

import 'package:timezone/data/latest.dart' as tz;

class CustomImageCache extends WidgetsFlutterBinding {
  @override
  ImageCache createImageCache() {
    ImageCache imageCache = super.createImageCache();
    // Set your image cache size
    imageCache.maximumSizeBytes = 1024 * 1024 * 100; // 100 MB
    return imageCache;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //onsignal 71537c0e-6951-448b-a85f-47823c5c2382
  await setupFlutterNotifications();
  await Hive.initFlutter();
  tz.initializeTimeZones();
  // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  // OneSignal.shared.setAppId('71537c0e-6951-448b-a85f-47823c5c2382');
  // OneSignal.shared.promptUserForPushNotificationPermission();
  if (!kIsWeb && !Platform.isMacOS) {
    //initializeDateFormatting("ar_SA", null);
  }
  runApp(App());
}

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<SettingCubit>(
          create: (BuildContext context) => SettingCubit(),
        ),
        BlocProvider<QuranCubit>(
          create: (BuildContext context) => QuranCubit(),
        ),
        BlocProvider<RamadanCubit>(
          create: (BuildContext context) => RamadanCubit(),
        ),
        BlocProvider<DuaCubit>(
          create: (BuildContext context) => DuaCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Ramadan',
        debugShowCheckedModeBanner: false,

        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'IQ'),
        ],
        // ignore: prefer_const_literals_to_create_immutables
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        locale: const Locale('ar', 'IQ'),

        theme: getTheme("Somar", false),
        themeMode: ThemeMode.system,
        showPerformanceOverlay: false,
        home: SplashPage(),
      ),
    );
  }
}
