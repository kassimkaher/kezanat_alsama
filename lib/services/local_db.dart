import 'package:hive/hive.dart';
import 'package:ramadan/model/quran_model.dart';
import 'package:ramadan/model/setting_model.dart';

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

  static SettingModel? getSetting() {
    if (db == null) {
      return null;
    }
    final data = db?.get("app_setting");

    return data;
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
}
