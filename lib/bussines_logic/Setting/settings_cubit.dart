import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramadan/bussines_logic/Setting/model/setting_model.dart';
import 'package:ramadan/services/notification_service.dart';
import 'package:ramadan/bussines_logic/prayer/prayer_cubit.dart';
import 'package:ramadan/model/city.dart';
import 'package:ramadan/bussines_logic/prayer/model/prayer_model.dart';
import 'package:ramadan/src/core/resources/local_db.dart';
import 'package:ramadan/src/main_app/dua/bussines_logic/dua_cubit.dart';
import 'package:ramadan/utils/utils.dart';
part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit()
      : super(SettingStateInitial(SettingInfo(
          currentpageIndex: 0,
          currentPage: NavPages.home,
          currentLang: Lang.arbic,
        )));

  void changePage(NavPages page, int index) {
    state.setting.currentPage = page;
    state.setting.currentpageIndex = index;
    refresh();
  }

  locadCity() async {
    final String response =
        await rootBundle.loadString('assets/docs/cites_n.json');
    state.setting.cities = CitesModel.fromJson(json.decode(response));
  }

  refresh() {
    emit(SettingStateSecond(state.setting));
    emit(SettingStateMain(state.setting));
  }

  Future<void> getSetting(PrayerCubit ramadanCubit, DuaCubit duaCubit) async {
    emit(SettingStateLoading(state.setting));
    await LocalDB.inite();
    final data = await LocalDB.getSetting();
    state.setting.setting = data;
    locadCity();
    if (state.setting.setting != null &&
        state.setting.setting!.selectCity != null) {
      ramadanCubit.getPrayer(state.setting.setting!.selectCity);
      ramadanCubit.listenTime(duaCubit);
    }
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      state.setting.isBegin = true;
      refresh();
    });
  }

  Future<void> setDark(int v) async {
    state.setting.setting ??= SettingModel();

    state.setting.setting?.isDarkMode = v;
    LocalDB.saveSettingDb(state.setting.setting!);

    refresh();
  }

  Future<void> saveNotificationDay() async {
    state.setting.setting ??= SettingModel();

    state.setting.setting!.isSetNotification = DateTime.now().day;
    LocalDB.saveSettingDb(state.setting.setting!);
    refresh();
  }

  setNotification(PrayersTimeModel data) {
    cancelAllNotification();
    saveNotificationDay();

    if (Platform.isAndroid) {
      setAndroidNotification(data, 0);
      print("is android ");
    }
    if (Platform.isIOS) {
      seIostNotification(data, 0, 0);
      print("is ios ");
    }
  }

  setAndroidNotification(PrayersTimeModel data, index) async {
    final day = data.days![index];
    final date = DateTime.now();
    if (date.month > day.month! ||
        (date.month == day.month && date.day > day.day!) ||
        (date.month == day.month && date.day == day.day && date.hour > 20)) {
      if ((data.days!.length - 1) > index) {
        setAndroidNotification(data, index + 1);
      }
      return;
    }

    try {
      await showSchedualNotificationAthan(
          title: "اذان",
          subtitle: "حان الان موعد اذان الفجر",
          dateTime: DateTime(
              2023, day.month!, day.day!, day.fajer!.hour!, day.fajer!.minut!),
          id: 100 + day.day!);
    } catch (e) {
      kdp(name: "schedual notification fajer", msg: e, c: 'r');
    }

    try {
      await showSchedualNotificationAthan(
          title: "اذان",
          subtitle: "حان الان موعد اذان الظهر",
          dateTime: DateTime(
              2023, day.month!, day.day!, day.duhur!.hour!, day.duhur!.minut!),
          id: 200 + day.day!);
    } catch (e) {
      kdp(name: "schedual notification duhur", msg: e, c: 'r');
    }
    try {
      await showSchedualNotificationAthan(
          title: "اذان",
          subtitle: "حان الان موعد اذان المغرب",
          dateTime: DateTime(2023, day.month!, day.day!, day.magrib!.hour!,
              day.magrib!.minut!),
          id: 300 + day.day!);
    } catch (e) {
      kdp(name: "schedual notification mugrib", msg: e, c: 'r');
    }

    // try {
    //   await showSchedualNotificationEmsak(
    //       title: "امساك",
    //       subtitle: "حان الان موعد  الامساك اي الامتناع عن الاكل و والشرب",
    //       dateTime: DateTime(
    //           2023, day.month!, day.day!, day.emsak!.hour!, day.emsak!.minut!),
    //       id: 400 + day.day!);
    // } catch (e) {
    //   kdp(name: "schedual notification emsak", msg: e, c: 'r');
    // }

    if ((data.days!.length - 1) > index) {
      setAndroidNotification(data, index + 1);
    }
  }

  seIostNotification(PrayersTimeModel data, int index, int number) async {
    final day = data.days![index];
    final date = DateTime.now();
    if (number > 6) {
      return;
    }

    if (date.month > day.month! ||
        (date.month == day.month && date.day > day.day!) ||
        (date.month == day.month && date.day == day.day && date.hour > 20)) {
      if ((data.days!.length - 1) > index) {
        seIostNotification(data, index + 1, number);
      }
      return;
    }

    try {
      if ((date.month == day.month &&
          date.day == day.day &&
          date.hour >= day.fajer!.hour!)) {
      } else {
        pushIosNotification(
            title: "اذان الفجر",
            body: "حان الان موعد اذان الفجر",
            sound: "athan_ios.caf",
            year: date.year,
            month: day.month!,
            day: day.day!,
            hour: day.fajer!.hour!,
            minuts: day.fajer!.minut!,
            second: 0);
      }
    } catch (e) {
      kdp(name: "schedual notification fajer", msg: e, c: 'r');
    }
    // try {
    //   if ((date.month == day.month &&
    //       date.day == day.day &&
    //       date.hour >= day.emsak!.hour!)) {
    //   } else {
    //     pushIosNotification(
    //         title: " الامساك",
    //         body: "حان الان موعد  الامساك اي الامتناع عن الاكل و والشرب",
    //         sound: "emsak_ios.caf",
    //         year: date.year,
    //         month: day.month!,
    //         day: day.day!,
    //         hour: day.emsak!.hour!,
    //         minuts: day.emsak!.minut!,
    //         second: 0);
    //   }
    // } catch (e) {
    //   kdp(name: "schedual notification fajer", msg: e, c: 'r');
    // }

    try {
      if ((date.month == day.month &&
          date.day == day.day &&
          date.hour >= day.duhur!.hour!)) {
      } else {
        pushIosNotification(
            title: "اذان الظهر",
            body: "حان الان موعد اذان الظهر",
            sound: "athan_ios.caf",
            year: date.year,
            month: day.month!,
            day: day.day!,
            hour: day.duhur!.hour ?? 0,
            minuts: day.duhur!.minut!,
            second: 0);
      }
    } catch (e) {
      kdp(name: "schedual notification fajer", msg: e, c: 'r');
    }

    try {
      if ((date.month == day.month &&
          date.day == day.day &&
          date.hour >= day.magrib!.hour!)) {
      } else {
        pushIosNotification(
            title: "اذان المغرب",
            body: "حان الان موعد اذان المغرب",
            sound: "athan_ios.caf",
            year: date.year,
            month: day.month!,
            day: day.day!,
            hour: (day.magrib!.hour!),
            minuts: day.magrib!.minut!,
            second: 0);
      }
    } catch (e) {
      kdp(name: "schedual notification fajer", msg: e, c: 'r');
    }

    if ((data.days!.length - 1) > index) {
      seIostNotification(data, index + 1, number + 1);
    }
  }

  void setCityIndex(int i) {
    state.setting.setting ??= SettingModel();

    state.setting.setting?.city = i;

    state.setting.setting!.selectCity = CityDetails(
        state.setting.cities!.provinces![state.setting.setting!.city!].name,
        state.setting.cities!.provinces![state.setting.setting!.city!].nameAr,
        state.setting.cities!.provinces![state.setting.setting!.city!]
            .coordinates!.latitude,
        state.setting.cities!.provinces![state.setting.setting!.city!]
            .coordinates!.longitude);

    LocalDB.saveSettingDb(state.setting.setting!);
  }

  setEnableNotification(bool value) {
    state.setting.setting ??= SettingModel();
    state.setting.setting!.enableNotification = value;
    refresh();
    LocalDB.saveSettingDb(state.setting.setting!);
  }

  listenSpeach() async {
    // SpeechToText _speechToText = SpeechToText();
    // final _speechEnabled = await _speechToText.initialize();
    // await _speechToText.listen(onResult: (a) {
    //   print(a.recognizedWords);
    //   if (a.recognizedWords.split(" ").length == 3) {
    //     _speechToText.cancel();
    //     listenSpeach();
    //   }
    // });
    // print(_speechEnabled);
    // refresh();
  }
}

Route to(Widget page) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, anotherAnimation, child) {
        animation = CurvedAnimation(curve: Curves.easeIn, parent: animation);
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      });
}
