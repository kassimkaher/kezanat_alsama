import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

bool isFlutterLocalNotificationsInitialized = false;
Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }

  const androidInitializationSetting =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const iosInitializationSetting = DarwinInitializationSettings();
  const initSettings = InitializationSettings(
      android: androidInitializationSetting, iOS: iosInitializationSetting);
  await _flutterLocalNotificationsPlugin.initialize(initSettings);
}

void showFlutterNotificationAthan(
    {required String title, required String subtitle}) {
  const androidNotificationDetail = AndroidNotificationDetails(
      'ramadan_kezana_alsama_athan', 'ramadan_kezana_alsama',
      importance: Importance.max,
      priority: Priority.max,
      sound: RawResourceAndroidNotificationSound('athan'));
  const iosNotificatonDetail =
      DarwinNotificationDetails(sound: 'athan_ios_1.MP3', presentAlert: false);

  const notificationDetails = NotificationDetails(
    iOS: iosNotificatonDetail,
    android: androidNotificationDetail,
  );
  _flutterLocalNotificationsPlugin.show(
      0, title, subtitle, notificationDetails);
}

void showFlutterNotificationEmsak(
    {required String title, required String subtitle}) {
  const androidNotificationDetail = AndroidNotificationDetails(
      'ramadan_kezana_alsama_emsak', 'ramadan_kezana_alsama_emsak',
      importance: Importance.max,
      priority: Priority.max,
      sound: RawResourceAndroidNotificationSound('emsak'));
  const iosNotificatonDetail = DarwinNotificationDetails(sound: "emsak.mp3");

  const notificationDetails = NotificationDetails(
    iOS: iosNotificatonDetail,
    android: androidNotificationDetail,
  );
  _flutterLocalNotificationsPlugin.show(
      0, title, subtitle, notificationDetails);
}

Future<void> showSchedualNotificationEmsak(
    {required String title,
    required String subtitle,
    required DateTime dateTime,
    required int id}) async {
  final date = tz.TZDateTime.from(dateTime, tz.local);

  const androidNotificationDetail = AndroidNotificationDetails(
      'ramadan_kezana_alsama_emsak', 'ramadan_kezana_alsama_emsak',
      importance: Importance.max,
      priority: Priority.max,
      sound: RawResourceAndroidNotificationSound('emsak'));
  const iosNotificatonDetail = DarwinNotificationDetails(
      sound: "emsak_ios.MP3",
      presentAlert: false,
      presentSound: true,
      interruptionLevel: InterruptionLevel.active);

  const notificationDetails = NotificationDetails(
    iOS: iosNotificatonDetail,
    android: androidNotificationDetail,
  );
  await _flutterLocalNotificationsPlugin.zonedSchedule(
    id, title, subtitle,
    date,

    notificationDetails,

    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    androidAllowWhileIdle:
        true, //To show notification even when the app is closed
  );
}

Future<void> showSchedualNotificationAthan(
    {required String title,
    required String subtitle,
    required DateTime dateTime,
    required int id}) async {
  final date = tz.TZDateTime.from(dateTime, tz.local);
  kdp(name: "notification chek", msg: dateTime.toString(), c: 'm');
  kdp(name: "notification chek", msg: id, c: 'gr');
  const androidNotificationDetail = AndroidNotificationDetails(
      'ramadan_kezana_alsama_athan', 'ramadan_kezana_alsama_athan',
      importance: Importance.max,
      priority: Priority.max,
      sound: RawResourceAndroidNotificationSound('athan'));
  const iosNotificatonDetail =
      DarwinNotificationDetails(sound: "athan_ios_1.MP3");

  const notificationDetails = NotificationDetails(
    iOS: iosNotificatonDetail,
    android: androidNotificationDetail,
  );
  await _flutterLocalNotificationsPlugin.zonedSchedule(
    id, title, subtitle,
    date,

    notificationDetails,

    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    androidAllowWhileIdle:
        true, //To show notification even when the app is closed
  );
}

Future<void> showSchedualIOSNotificationAthan(
    {required String title,
    required String subtitle,
    required DateTime dateTime,
    required int id}) async {
  const androidNotificationDetail = AndroidNotificationDetails(
      'ramadan_kezana_alsama_athan', 'ramadan_kezana_alsama_athan',
      importance: Importance.max,
      priority: Priority.max,
      sound: RawResourceAndroidNotificationSound('emsak'));
  for (var i = 1; i < 17; i++) {
    final date = tz.TZDateTime.from(
        dateTime.add(Duration(seconds: arrayDuration[i - 1])), tz.local);
    final iosNotificatonDetail = DarwinNotificationDetails(
        sound: "athan_ios_$i.MP3",
        presentAlert: false,
        presentSound: true,
        interruptionLevel: InterruptionLevel.active);

    final notificationDetails = NotificationDetails(
      iOS: iosNotificatonDetail,
      android: androidNotificationDetail,
    );
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id + (1000 * i), title, subtitle,
      date,

      notificationDetails,

      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle:
          true, //To show notification even when the app is closed
    );
  }
}

const arrayDuration = [
  0,
  21,
  44,
  66,
  90,
  109,
  132,
  151,
  176,
  190,
  212,
  225,
  248,
  261,
  281,
  308,
  330
];
