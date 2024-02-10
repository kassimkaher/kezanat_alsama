import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:timezone/timezone.dart' as tz;

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
      'ramadan_10_id', 'ramadan_kezana_alsama',
      importance: Importance.max,
      sound: RawResourceAndroidNotificationSound('res_athan'));
  const iosNotificatonDetail =
      DarwinNotificationDetails(sound: 'athan_ios.MP3', presentAlert: false);

  const notificationDetails = NotificationDetails(
    iOS: iosNotificatonDetail,
    android: androidNotificationDetail,
  );
  _flutterLocalNotificationsPlugin.show(
      87876, title, subtitle, notificationDetails);
}

void showFlutterNotificationEmsak(
    {required String title, required String subtitle}) {
  const androidNotificationDetail = AndroidNotificationDetails(
      'ramadan_10_id', 'ramadan_kezana_alsama_emsak',
      importance: Importance.max,
      sound: RawResourceAndroidNotificationSound('res_emsak'));
  const iosNotificatonDetail =
      DarwinNotificationDetails(sound: "emsak_ios.caf");

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
  kdp(
      name: "notification emsak",
      msg: "date ${dateTime.toString()} --id=$id",
      c: 'cy');

  const androidNotificationDetail = AndroidNotificationDetails(
      'ramadan_10_id_emsak', 'ramadan_kezana_alsama_emsak',
      importance: Importance.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('res_emsak'));
  const iosNotificatonDetail = DarwinNotificationDetails(
      sound: "emsak_ios.caf", interruptionLevel: InterruptionLevel.active);

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
  kdp(
      name: "notification athan",
      msg: "date ${dateTime.toString()} --id=$id",
      c: 'm');

  const androidNotificationDetail = AndroidNotificationDetails(
      'ramadan_10_id_athan', 'ramadan_kezana_alsama_athan',
      importance: Importance.max,
      autoCancel: false,
      sound: RawResourceAndroidNotificationSound('res_athan'),
      playSound: true);
  const iosNotificatonDetail =
      DarwinNotificationDetails(sound: "athan_ios.caf");

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

cancelAllNotification() {
  try {
    _flutterLocalNotificationsPlugin.cancelAll();
  } catch (e) {}

  try {
    cancellAllIosNotification();
  } catch (e) {}
}

// Future<void> showSchedualIOSNotificationAthan(
//     {required String title,
//     required String subtitle,
//     required DateTime dateTime,
//     required int id}) async {
//   const androidNotificationDetail = AndroidNotificationDetails(
//       'ramadan_kezana_alsama_athan', 'ramadan_kezana_alsama_athan',
//       importance: Importance.max,
//       priority: Priority.max,
//       sound: RawResourceAndroidNotificationSound('emsak'));
//   for (var i = 1; i < 17; i++) {
//     final date = tz.TZDateTime.from(
//         dateTime.add(Duration(seconds: arrayDuration[i - 1])), tz.local);
//     final iosNotificatonDetail = DarwinNotificationDetails(
//         sound: "athan_ios_$i.MP3",
//         presentAlert: false,
//         presentSound: true,
//         interruptionLevel: InterruptionLevel.active);

//     final notificationDetails = NotificationDetails(
//       iOS: iosNotificatonDetail,
//       android: androidNotificationDetail,
//     );
//     await _flutterLocalNotificationsPlugin.zonedSchedule(
//       id + (1000 * i), title, subtitle,
//       date,

//       notificationDetails,

//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       androidAllowWhileIdle:
//           true, //To show notification even when the app is closed
//     );
//   }
// }

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

// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:ramadan/utils/const.dart';
// import 'package:ramadan/utils/extention.dart';

// class NotificationController {
//   static ReceivedAction? initialAction;

//   static Future<void> initializeLocalNotifications() async {
//     await AwesomeNotifications().initialize(
//         null, //'resource://drawable/res_app_icon',//
//         [
//           NotificationChannel(
//             channelKey: 'AthanNOtitfication_Id_2222',
//             channelName: 'Alerts',
//             channelDescription: 'Notification tests as alerts',
//             playSound: true,
//             soundSource: "resource://raw/athan",
//             importance: NotificationImportance.High,
//             defaultPrivacy: NotificationPrivacy.Private,
//           ),
//           NotificationChannel(
//             channelKey: 'EmsakNOtitfication_Id_2222',
//             channelName: 'Alerts',
//             channelDescription: 'Notification tests as alerts',
//             playSound: true,
//             soundSource: "resource://raw/emsak",
//             groupAlertBehavior: GroupAlertBehavior.Children,
//             importance: NotificationImportance.High,
//             defaultPrivacy: NotificationPrivacy.Private,
//           )
//         ],
//         debug: false);

//     // Get initial notification action is optional
//     initialAction = await AwesomeNotifications()
//         .getInitialNotificationAction(removeFromActionEvents: false);
//   }

//   static Future<void> createNewNotification() async {
//     bool isAllowed = await AwesomeNotifications().isNotificationAllowed();

//     await AwesomeNotifications().createNotification(
//         content: NotificationContent(
//             id: -1, // -1 is replaced by a random number
//             channelKey: 'alerts',
//             title: 'Huston! The eagle has landed!',
//             body:
//                 "A small step for a man, but a giant leap to Flutter's community!",
//             bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
//             largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
//             //'asset://assets/images/balloons-in-sky.jpg',
//             notificationLayout: NotificationLayout.BigPicture,
//             payload: {'notificationId': '1234567890'}),
//         actionButtons: [
//           NotificationActionButton(key: 'REDIRECT', label: 'Redirect'),
//           NotificationActionButton(
//               key: 'REPLY',
//               label: 'Reply Message',
//               requireInputText: true,
//               actionType: ActionType.SilentAction),
//           NotificationActionButton(
//               key: 'DISMISS',
//               label: 'Dismiss',
//               actionType: ActionType.DismissAction,
//               isDangerousOption: true)
//         ]);
//   }

//   static Future<void> showSchedualNotificationEmsak(
//       {required String title,
//       required String subtitle,
//       required DateTime dateTime,
//       required int id}) async {
//     await AwesomeNotifications().createNotification(
//         content: NotificationContent(
//             id: id, // -1 is replaced by a random number
//             channelKey: 'EmsakNOtitfication_Id_2222',
//             title: title,
//             body: subtitle,
//             notificationLayout: NotificationLayout.Default,
//             customSound: 'resource://raw/emsak'),
//         schedule: NotificationCalendar.fromDate(date: dateTime));
//   }

//   static Future<void> showSchedualNotificationAthan(
//       {required String title,
//       required String subtitle,
//       required DateTime dateTime,
//       required int id}) async {
//     await AwesomeNotifications().createNotification(
//         content: NotificationContent(
//             id: -1, // -1 is replaced by a random number
//             channelKey: 'AthanNOtitfication_Id_2222',
//             title: title,
//             body: subtitle,
//             bigPicture:
//                 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
//             largeIcon:
//                 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
//             //'asset://assets/images/balloons-in-sky.jpg',
//             notificationLayout: NotificationLayout.BigPicture,
//             customSound: 'athan'),
//         actionButtons: [
//           NotificationActionButton(key: 'REDIRECT', label: 'Redirect'),
//           NotificationActionButton(
//               key: 'DISMISS',
//               label: 'Dismiss',
//               actionType: ActionType.DismissAction,
//               isDangerousOption: true)
//         ],
//         schedule: NotificationCalendar.fromDate(
//             date: DateTime.now().add(const Duration(seconds: 10))));
//   }

//   static Future<void> resetBadgeCounter() async {
//     await AwesomeNotifications().resetGlobalBadge();
//   }

//   static Future<void> cancelNotifications() async {
//     await AwesomeNotifications().cancelAll();
//   }
// }

Future<void> pushIosNotification({
  required String title,
  required String body,
  required String sound,
  required int year,
  required int month,
  required int day,
  required int hour,
  required int minuts,
  required int second,
}) async {
  final result =
      await methodChannel.invokeMethod('pushIosNotification', <String, dynamic>{
    'title': title,
    'body': body,
    'sound': sound,
    'year': year,
    'month': month,
    'day': day,
    'hour': hour,
    'minuts': minuts,
    'second': second
  });

  kdp(
      name: "ios notification",
      msg: {
        'result': result,
        'month': month,
        'day': day,
        'hour': hour,
        'minuts': minuts,
      },
      c: 'm');
}

Future<void> pushAndroidNotification({
  required String title,
  required String body,
  required String sound,
  required int year,
  required int month,
  required int day,
  required int hour,
  required int minuts,
  required int second,
}) async {
  final result =
      await methodChannel.invokeMethod('pushIosNotification', <String, dynamic>{
    'title': title,
    'body': body,
    'sound': sound,
    'year': year,
    'month': month,
    'day': day,
    'hour': hour,
    'minuts': minuts,
    'second': second,
    'id': 22
  });

  kdp(
      name: "ios notification",
      msg: {
        'result': result,
        'month': month,
        'day': day,
        'hour': hour,
        'minuts': minuts,
      },
      c: 'm');
}

Future<void> cancellAllIosNotification() async {
  final a = await methodChannel.invokeMethod('cancelAllNotification');

  kdp(name: "ios notification", msg: "ios noti cancel ===$a", c: 'm');
}
