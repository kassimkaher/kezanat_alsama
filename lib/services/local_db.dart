import 'package:hive/hive.dart';
import 'package:ramadan/model/quran_model.dart';
import 'package:ramadan/model/setting_model.dart';
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
  // saveToken(int step) async {
  //   try {
  //     if (db != null) {
  //       await db!.put("step", step);
  //     }
  //   } catch (e) {}
  // }

  // int? getToken() {
  //   if (db != null) {
  //     return db!.get("step");
  //   }
  // }

  // saveChildrenListData(ChildInfoListModel data) async {
  //   final box = await Hive.openBox('tamwin_local_data');
  //   if (box != null) {
  //     var list = {
  //       "childrenListModel": data.childildren.map((e) => e.toJson()).toList()
  //     };
  //     box.put("children_information", list);
  //   }
  // }

  // Future<ChildInfoListModel?> getChildrenData() async {
  //   if (db != null) {
  //     try {
  //       var data = db!.get("children_information");

  //       if (data != null) {
  //         List<Map<dynamic, dynamic>> list =
  //             (data['childrenListModel'] as List<dynamic>)
  //                 .map((e) => e as Map<dynamic, dynamic>)
  //                 .toList();
  //         ChildInfoListModel datalist = ChildInfoListModel(childildren: []);
  //         datalist.childildren =
  //             list.map((e) => ChildInfoModel.fromJson(e)).toList();
  //         return datalist;
  //       }
  //       return null;
  //     } catch (_) {}
  //   }
  //   return null;
  // }

  // void saveFatherData(ChildInfoModel data) {
  //   if (db != null) {
  //     db!.put("father_information", data.toJson());
  //   }
  // }

  // ChildInfoModel? getFatherData() {
  //   if (db != null) {
  //     var js = db!.get("father_information");
  //     if (js == null) {
  //       return null;
  //     }
  //     var data = ChildInfoModel.fromJson(js);
  //     return data;
  //   }
  // }

  // saveLocationrData(LocationModel data) async {
  //   if (db != null) {
  //     db!.put("location_information", data.toJson());
  //   }
  // }

  // LocationModel? getLocationData() {
  //   if (db == null) {
  //     return null;
  //   }
  //   try {
  //     final localdsata = db!.get("location_information");
  //     if (localdsata == null) {
  //       return null;
  //     }
  //     var data = LocationModel.fromJson(localdsata);
  //     return data;
  //   } catch (e) {
  //     return null;
  //   }
  // }
}
