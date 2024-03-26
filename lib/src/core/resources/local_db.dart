import 'dart:convert';
import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ramadan/services/notification/model/model.dart';
import 'package:ramadan/src/main_app/quran/data/model/quran_juzu_model.dart';
import 'package:ramadan/src/main_app/quran/data/model/quran_model.dart';
import 'package:ramadan/services/tasbeeh/entity/model/tasbeeh_model.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/calendar_model.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/daily_work_model.dart';
import 'package:ramadan/src/main_app/slider/data/model/slider_model.dart';
import 'package:ramadan/utils/utils.dart';

class LocalDB {
  static Box? db;

  LocalDB() {
    //kdp(name: "chek lcal db", msg: "ini", c: 'y');
    inite();
  }
  static Future<bool> inite() async {
    db = await Hive.openBox('kezana_alsama_local_data');
    // kdp(name: "chek lcal db", msg: "done", c: 'gr');

    return true;
  }

  static clearData() {
    if (db != null) {
      db!.clear();
    }
  }

  static ContinuQuranModel? getContinu() {
    if (db == null) {
      return null;
    }
    final data = db?.get("continu_quran");

    return ContinuQuranModel.fromJson(data);
  }

  static setContinu(ContinuQuranModel value) {
    if (db == null) {
      return;
    }

    db!.put("continu_quran", value.toJson());
  }

  static DailyPostsModel? getPosts() {
    if (db == null) {
      return null;
    }
    final data = db?.get("post_data_storage");

    return DailyPostsModel.fromJson(data);
  }

  static setPosts(DailyPostsModel value) {
    if (db == null) {
      return;
    }

    db!.put("post_data_storage", value.toJson());
  }

  static DailyWorkModel? getDailyWorkFromLocal() {
    if (db == null) {
      return null;
    }
    final data = db?.get("daily_work_data_storage");

    return DailyWorkModel.fromJson(data);
  }

  static setDailyWorkFromLocal(DailyWorkModel value) {
    if (db == null) {
      return;
    }

    db!.put("daily_work_data_storage", value.toJson());
  }

  static SettingModel? getSetting() {
    if (db == null) {
      return null;
    }
    final data = db?.get("app_setting");

    return data;
  }

  static CalendarModel? getCalendar() {
    if (db == null) {
      return null;
    }
    final data = db?.get("calendar_data_storage");

    return CalendarModel.fromJson(data);
  }

  static setCalendar(CalendarModel value) {
    if (db == null) {
      return;
    }

    db!.put("calendar_data_storage", value.toJson());
  }

  static saveSettingDb(SettingModel settingModel) {
    if (db == null) {
      return;
    }

    db!.put("app_setting", settingModel);
  }

  static int? getIsSetNotification() {
    if (db == null) {
      //kdp(name: "notification chek is set", msg: "null", c: 'r');
      return null;
    }
    final data = db?.get("getIsSetNotificationNew");

    return data;
  }

  static setIsSetNotification(int value) {
    if (db == null) {
      return;
    }

    db!.put("getIsSetNotificationNew", value);
  }

  //for sala
  static setSalatDay(SalatContinus value) {
    if (db == null) {
      return;
    }

    db!.put("setSalatDay", value);
  }

  static SalatContinus? getSalatDay() {
    if (db == null) {
      return null;
    }
    final data = db?.get("setSalatDay");

    return data;
  }

  static setSalatCounter(SalatContinus value) {
    if (db == null) {
      return;
    }

    db!.put("setSalatCounter", value);
  }

  static SalatContinus? getSalatCounter() {
    if (db == null) {
      return null;
    }
    final data = db?.get("setSalatCounter");

    return data;
  }

  static ArabicDateEntry? getArabicDay() {
    final data = db?.get("saveArabicDate");

    return data;
  }

  static saveArabicDate(ArabicDateEntry value) {
    db?.put("saveArabicDate", value);
  }

  static TasbeehLocalModel? getTasbeehCache() {
    if (db == null) {
      return null;
    }
    final data = db?.get("tasbeeh_data_storage") as Map<dynamic, dynamic>?;

    return data == null ? null : TasbeehLocalModel.fromJson(data);
  }

  static setTasbeehCache(TasbeehLocalModel value) {
    if (db == null) {
      return;
    }

    db!.put("tasbeeh_data_storage", value.toJson());
  }

  static List<QuranJuzuModel>? getQuranJuzu() {
    final data = db?.get("local_key_quran_juzu");
    List<QuranJuzuModel> quranjuzu = [];

    if (data == null) {
      return null;
    }
    for (var i = 0; i < 30; i++) {
      quranjuzu.add(QuranJuzuModel.fromJson(
          (data["juzu_$i"] as Map<dynamic, dynamic>).cast()));
    }
    return quranjuzu;
  }

  static saveQuranJuzu(List<QuranJuzuModel> value) {
    Map<String, dynamic> data = {};
    for (var i = 0; i < value.length; i++) {
      data["juzu_$i"] = value[i].toJson();
    }
    db?.put("local_key_quran_juzu", data);
  }

  static saveComeNotefication(String value) {
    db?.put("local_notification", value);
  }

  static NotificationModel? getComeNotefication() {
    final data = db?.get("local_notification");
    if (data != null) {
      db?.delete("local_notification");
      return NotificationModel.fromJson(json.decode(data));
    }

    return data;
  }

  // static saveBackuB() async {
  //   return;
  //   Directory appDocDir = await getApplicationDocumentsDirectory();

  //   // Define the path to the Hive data directory within the documents directory
  //   String hiveDataDirectoryPath =
  //       '${appDocDir.path}/kezana_alsama_local_data.hive';
  //   final hiveFile = File(hiveDataDirectoryPath);
  //   if (await hiveFile.exists()) {
  //     // Define the path to the Android/data directory within the external storage directory

  //     File backubFile = File(await getExternalPathBacubHive());
  //     if (backubFile.existsSync()) {
  //       kdp(
  //           name: "getDataBaseFile",
  //           msg: " backubFile exsist=${backubFile.path}",
  //           c: "cy");
  //       await hiveFile.copy(backubFile.path);
  //       return;
  //     }
  //     await backubFile.create();
  //     await hiveFile.copy(backubFile.path);
  //     kdp(
  //         name: "getDataBaseFile",
  //         msg: " backubFile exsist=${backubFile.path}",
  //         c: "m");
  //   }
  //   kdp(name: "getDataBaseFile", msg: "not exsist=", c: "r");
  // }

  static Future<bool> getBackup() async {
    File backubFile = File(await getExternalPathBacubHive());

    Directory appDocDir = await getApplicationDocumentsDirectory();

    // Define the path to the Hive data directory within the documents directory
    String hiveDataDirectoryPath =
        '${appDocDir.path}/kezana_alsama_local_data.hive';
    final hiveFile = File(hiveDataDirectoryPath);

    if (hiveFile.existsSync()) {
      kdp(name: "getDataBaseFile", msg: "hiveFile exsist", c: "gr");
      return true;
    }
    if (await backubFile.exists()) {
      await hiveFile.writeAsBytes(await backubFile.readAsBytes());

      kdp(name: "getDataBaseFile", msg: "backubFile exsist", c: "gr");
      return true;
    }
    kdp(name: "getDataBaseFile", msg: "any file not exsist", c: "r");
    return false;
  }

  static Future<String> getExternalPathBacubHive() async {
    final direc = Directory(
        "${await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOCUMENTS)}/kezanat_alsama");
    // final direc = await Directory.systemTemp.createTemp('kezanat_alsama');
    // if (direc.existsSync()) {
    //   return '${direc.path}/_kezanat_alsamabackup.hive';
    // }
    // await direc.create(recursive: true);

    return '${direc.path}';
  }
}
