import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:ramadan/bussines_logic/Setting/cubit/setting_cubit.dart';
import 'package:ramadan/src/admin/logic/calendar_cubit/calendar_cubit.dart';
import 'package:ramadan/src/main_app/home/daily_work/logic/daily_work_logic/daily_work_cubit.dart';
import 'package:ramadan/utils/injector.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:timezone/timezone.dart' as tz;

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

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  //onsignal 71537c0e-6951-448b-a85f-47823c5c2382
  if (Platform.isMacOS) {
  } else {
    await setupFlutterNotifications();
    // await NotificationController.initializeLocalNotifications();
    initializeTimeZones();
    tz.setLocalLocation(
        tz.getLocation(await FlutterTimezone.getLocalTimezone()));
    appMode = AppMode.admin;
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
  }

  await initHive();
  // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  // OneSignal.shared.setAppId('71537c0e-6951-448b-a85f-47823c5c2382');
  // OneSignal.shared.promptUserForPushNotificationPermission();
  if (!kIsWeb && !Platform.isMacOS) {
    //initializeDateFormatting("ar_SA", null);
  }
  registerDependencies();
  runApp(const App());
}

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SettingModelAdapter());
  Hive.registerAdapter(CityDetailsAdapter());
  Hive.registerAdapter(SalatContinusAdapter());
  Hive.registerAdapter(ArabicDateEntryAdapter());
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
        BlocProvider<PrayerCubit>(
          create: (BuildContext context) => PrayerCubit(),
        ),
        BlocProvider<DuaCubit>(
          create: (BuildContext context) => DuaCubit(),
        ),
        BlocProvider<AlqadrCubit>(
          create: (BuildContext context) => AlqadrCubit(),
        ),
        BlocProvider<SliderCubit>(
          create: (BuildContext context) => SliderCubit(),
        ),
        BlocProvider<DailyWorkCubit>(
          create: (BuildContext context) => DailyWorkCubit(),
        ),
        BlocProvider<CalendarCubit>(
          create: (BuildContext context) => CalendarCubit(),
        ),
      ],
      child: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'خزانة السماء',
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
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

            theme: getTheme("Somar", context.read<SettingCubit>().isDarkMode()),
            themeMode: ThemeMode.system,
            showPerformanceOverlay: false,
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}
