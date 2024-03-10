import 'package:hive/hive.dart';
import 'package:ramadan/bussines_logic/Setting/model/setting_model.dart';
import 'package:ramadan/bussines_logic/prayer/model/arabic_date_model.dart';
import 'package:ramadan/model/quran_model.dart';
import 'package:ramadan/services/tasbeeh/entity/model/tasbeeh_model.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/calendar_model.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/daily_work_model.dart';
import 'package:ramadan/src/main_app/slider/data/model/slider_model.dart';

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
    final data = Hive.box('kezana_alsama_local_data').get("saveArabicDate");

    return data;
  }

  static saveArabicDate(ArabicDateEntry value) {
    Hive.box('kezana_alsama_local_data').put("saveArabicDate", value);
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
}
