import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramadan/bussines_logic/dua/dua_cubit.dart';
import 'package:ramadan/bussines_logic/notification_service.dart';
import 'package:ramadan/bussines_logic/ramadan/ramadan_cubit.dart';
import 'package:ramadan/model/city.dart';
import 'package:ramadan/model/emsak.dart';
import 'package:ramadan/model/setting_model.dart';
import 'package:ramadan/services/local_db.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:speech_to_text/speech_to_text.dart';
part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit()
      : super(SettingStateInitial(SettingInfo(
          currentpageIndex: 2,
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
        await rootBundle.loadString('assets/docs/calendar/cites.json');
    state.setting.cities = CityModel.fromJson(json.decode(response));
  }

  refresh() {
    emit(SettingStateSecond(state.setting));
    emit(SettingStateMain(state.setting));
  }

  Future<void> getSetting(RamadanCubit ramadanCubit, DuaCubit duaCubit) async {
    emit(SettingStateLoading(state.setting));
    await LocalDB.inite();
    final data = await LocalDB.getSetting();
    state.setting.setting = data;
    locadCity();
    if (state.setting.setting != null &&
        state.setting.setting!.selectCity != null) {
      ramadanCubit.getRamadan(state.setting.setting!.selectCity!.path!);
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

  setNotification(EmsackModel data) {
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

  setAndroidNotification(EmsackModel data, index) async {
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
          dateTime: DateTime(2023, day.month!, day.day!,
              day.morningPrayer!.hour!, day.morningPrayer!.minut!),
          id: 100 + day.day!);
    } catch (e) {
      kdp(name: "schedual notification fajer", msg: e, c: 'r');
    }

    try {
      await showSchedualNotificationAthan(
          title: "اذان",
          subtitle: "حان الان موعد اذان الظهر",
          dateTime: DateTime(2023, day.month!, day.day!, day.sunPrayer!.hour!,
              day.sunPrayer!.minut!),
          id: 200 + day.day!);
    } catch (e) {
      kdp(name: "schedual notification duhur", msg: e, c: 'r');
    }
    try {
      await showSchedualNotificationAthan(
          title: "اذان",
          subtitle: "حان الان موعد اذان المغرب",
          dateTime: DateTime(2023, day.month!, day.day!, day.nightPrayer!.hour!,
              day.nightPrayer!.minut!),
          id: 300 + day.day!);
    } catch (e) {
      kdp(name: "schedual notification mugrib", msg: e, c: 'r');
    }

    try {
      await showSchedualNotificationEmsak(
          title: "امساك",
          subtitle: "حان الان موعد  الامساك اي الامتناع عن الاكل و والشرب",
          dateTime: DateTime(
              2023, day.month!, day.day!, day.emsak!.hour!, day.emsak!.minut!),
          id: 400 + day.day!);
    } catch (e) {
      kdp(name: "schedual notification emsak", msg: e, c: 'r');
    }

    if ((data.days!.length - 1) > index) {
      setAndroidNotification(data, index + 1);
    }
  }

  seIostNotification(EmsackModel data, int index, int number) async {
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
          date.hour >= day.morningPrayer!.hour!)) {
      } else {
        pushIosNotification(
            title: "اذان الفجر",
            body: "حان الان موعد اذان الفجر",
            sound: "athan_ios.caf",
            year: date.year,
            month: day.month!,
            day: day.day!,
            hour: day.morningPrayer!.hour!,
            minuts: day.morningPrayer!.minut!,
            second: 0);
      }
    } catch (e) {
      kdp(name: "schedual notification fajer", msg: e, c: 'r');
    }
    try {
      if ((date.month == day.month &&
          date.day == day.day &&
          date.hour >= day.emsak!.hour!)) {
      } else {
        pushIosNotification(
            title: " الامساك",
            body: "حان الان موعد  الامساك اي الامتناع عن الاكل و والشرب",
            sound: "emsak_ios.caf",
            year: date.year,
            month: day.month!,
            day: day.day!,
            hour: day.emsak!.hour!,
            minuts: day.emsak!.minut!,
            second: 0);
      }
    } catch (e) {
      kdp(name: "schedual notification fajer", msg: e, c: 'r');
    }

    try {
      if ((date.month == day.month &&
          date.day == day.day &&
          date.hour >= day.sunPrayer!.hour!)) {
      } else {
        pushIosNotification(
            title: "اذان الظهر",
            body: "حان الان موعد اذان الظهر",
            sound: "athan_ios.caf",
            year: date.year,
            month: day.month!,
            day: day.day!,
            hour: day.sunPrayer!.hour ?? 0,
            minuts: day.sunPrayer!.minut!,
            second: 0);
      }
    } catch (e) {
      kdp(name: "schedual notification fajer", msg: e, c: 'r');
    }

    try {
      if ((date.month == day.month &&
          date.day == day.day &&
          date.hour >= day.nightPrayer!.hour!)) {
      } else {
        pushIosNotification(
            title: "اذان المغرب",
            body: "حان الان موعد اذان المغرب",
            sound: "athan_ios.caf",
            year: date.year,
            month: day.month!,
            day: day.day!,
            hour: (day.nightPrayer!.hour!),
            minuts: day.nightPrayer!.minut!,
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
        state.setting.cities!.city![state.setting.setting!.city!].name,
        state.setting.cities!.city![state.setting.setting!.city!].path);

    LocalDB.saveSettingDb(state.setting.setting!);
  }

  setEnableNotification(bool value) {
    state.setting.setting ??= SettingModel();
    state.setting.setting!.enableNotification = value;
    refresh();
    LocalDB.saveSettingDb(state.setting.setting!);
  }

  listenSpeach() async {
    SpeechToText _speechToText = SpeechToText();
    final _speechEnabled = await _speechToText.initialize();
    await _speechToText.listen(onResult: (a) {
      print(a.recognizedWords);
      if (a.recognizedWords.split(" ").length == 3) {
        _speechToText.cancel();
        listenSpeach();
      }
    });
    print(_speechEnabled);
    refresh();
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
