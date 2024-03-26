import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ramadan/bussines_logic/prayer/model/prayer_model.dart';
import 'package:ramadan/model/city.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/core/resources/local_db.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:timezone/timezone.dart' as tz;
part 'setting_state.dart';
part 'setting_cubit.freezed.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(const SettingState.initial());

  changePage(NavPages page, int index) {
    emit(state.copyWith(currentpageIndex: index, currentPage: page));
  }

  locadCity() async {
    final String response =
        await rootBundle.loadString('assets/docs/cites_n.json');
    final data = CitesModel.fromJson(json.decode(response));
    emit(state.copyWith(cities: data));
  }

  Future<void> getLocalSetting() async {
    emit(state.copyWith(dataStatus: const StateLoading()));

    final data = LocalDB.getSetting();

    emit(state.copyWith(
        dataStatus: const SateSucess(),
        setting: data ??
            SettingModel(
                isDarkMode: 0,
                enableNotification: true,
                isSetNotification: -1)));

    locadCity();
  }

  Future<void> setDark(int v) async {
    emit(state.copyWith(setting: state.setting!.copyWith(isDarkMode: v)));

    LocalDB.saveSettingDb(state.setting!);
  }

  Future<void> saveNotificationDay() async {
    emit(state.copyWith(
        setting:
            state.setting!.copyWith(isSetNotification: DateTime.now().day)));

    LocalDB.saveSettingDb(state.setting!);
  }

  setNotification(PrayersTimeModel data) {
    cancelAllNotification();
    saveNotificationDay();

    if (Platform.isAndroid) {
      setAndroidNotification(data, 0);
      log("is android ");
    }
    if (Platform.isIOS) {
      seIostNotification(data, 0, 0);
      log("is ios ");
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
          dateTime: tz.TZDateTime(tz.local, date.year, day.month!, day.day!,
              day.fajer!.hour!, day.fajer!.minut!),
          id: 100 + day.day!,
          type: NotificationType.fajer);
    } catch (e) {
      kdp(
          name: "schedual notification fajer",
          msg:
              "$e${tz.TZDateTime(tz.local, date.year, date.month, date.day, day.fajer!.hour!, day.fajer!.minut!)}",
          c: 'r');
    }

    try {
      await showSchedualNotificationAthan(
          title: "اذان",
          subtitle: "حان الان موعد اذان الظهر",
          dateTime: tz.TZDateTime(tz.local, date.year, day.month!, day.day!,
              day.duhur!.hour!, day.duhur!.minut!),
          id: 200 + day.day!,
          type: NotificationType.duhur);
    } catch (e) {
      kdp(
          name: "schedual notification duhur",
          msg:
              "$e${tz.TZDateTime(tz.local, date.year, date.month, date.day, day.duhur!.hour!, day.duhur!.minut!)}",
          c: 'r');
    }
    try {
      await showSchedualNotificationAthan(
          title: "اذان",
          subtitle: "حان الان موعد اذان المغرب",
          dateTime: tz.TZDateTime(tz.local, date.year, day.month!, day.day!,
              day.magrib!.hour!, day.magrib!.minut!),
          id: 300 + day.day!,
          type: NotificationType.mugrib);
    } catch (e) {
      kdp(
          name: "schedual notification mugrib",
          msg:
              "$e${tz.TZDateTime(tz.local, date.year, date.month, date.day, day.magrib!.hour!, day.magrib!.minut!)}",
          c: 'r');
    }

    if (day.emsak != null) {
      try {
        await showSchedualNotificationEmsak(
            title: "امساك",
            subtitle: "حان الان موعد  الامساك اي الامتناع عن الاكل و والشرب",
            dateTime: tz.TZDateTime(tz.local, date.year, day.month!, day.day!,
                day.emsak!.hour!, day.emsak!.minut!),
            id: 400 + day.day!);
      } catch (e) {
        kdp(
            name: "schedual notification emsak",
            msg:
                "$e${tz.TZDateTime(tz.local, date.year, date.month, date.day, day.fajer!.hour!, day.fajer!.minut!)}=====${tz.TZDateTime.now(tz.local)}",
            c: 'r');
      }
    }
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
    try {
      if (day.emsak != null &&
          (date.month == day.month &&
              date.day == day.day &&
              date.hour >= day.emsak!.hour!)) {
      } else {
        pushIosNotification(
            title: "امساك",
            body: "حان وقت الامساك   ",
            sound: "emsak_ios.caf",
            year: date.year,
            month: day.month!,
            day: day.day!,
            hour: (day.emsak!.hour!),
            minuts: day.emsak!.minut!,
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
    emit(state.copyWith(
        setting: state.setting!.copyWith(
            city: i,
            selectCity: state.cities!.provinces![i].toCityDetailsModel())));

    LocalDB.saveSettingDb(state.setting!);
  }

  setEnableNotification(bool value) {
    emit(state.copyWith(
        setting: state.setting!.copyWith(enableNotification: value)));

    LocalDB.saveSettingDb(state.setting!);
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

  isDarkMode() {
    return state.setting?.isDarkMode == 1
        ? false
        : state.setting?.isDarkMode == 2
            ? true
            : SchedulerBinding.instance.window.platformBrightness ==
                Brightness.dark;
  }

  endAnimationEvent() {
    emit(state.copyWith(isEndEvent: true));
  }
}
