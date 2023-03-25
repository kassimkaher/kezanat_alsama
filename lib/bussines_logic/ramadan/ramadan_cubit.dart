import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:ramadan/bussines_logic/dua/dua_cubit.dart';
import 'package:ramadan/bussines_logic/notification_service.dart';
import 'package:ramadan/model/emsak.dart';
import 'package:ramadan/model/ramadan_amal.dart';
import 'package:ramadan/model/ramadan_dua.dart';
import 'package:ramadan/utils/extention.dart';

part 'ramadan_state.dart';

class RamadanCubit extends Cubit<RamadanState> {
  RamadanCubit() : super(RamadanStateInital(RamadanInfo()));

  getRamadan() async {
    try {
      final String response =
          await rootBundle.loadString('assets/docs/ramadan.json');
      final jsondata = await json.decode(response);
      state.info.emsackModel = EmsackModel.fromJson(jsondata);

      emit(RamadanStateLoaded(state.info));

      refresh();
    } catch (e) {
      print("klsdfjnks");
      print(e);
    }
  }

  listenTime(DuaCubit duaCubit) async {
    await getRamadan();
    await loadAmal();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      var now = DateTime.now();
      if (now.day < 23) {
        now = DateTime.now().copyWith(day: 23);
      }
      checkTodayAmal(duaCubit);
      if (state is RamadanStateLoaded) {
        final currentdayIndex = state.info.emsackModel!.days!
            .indexWhere((day) => day.month == now.month && day.day == now.day);
        if (currentdayIndex > -1) {
          state.info.currentDay =
              state.info.emsackModel!.days![currentdayIndex];
          state.info.dayNumber = currentdayIndex + 1;

          if (state.info.emsackModel!.days!.length > (currentdayIndex + 1)) {
            state.info.nextDay =
                state.info.emsackModel!.days![currentdayIndex + 1];
          }
          if ((currentdayIndex - 1) > -1) {
            state.info.agoDay =
                state.info.emsackModel!.days![currentdayIndex + -1];
          }
          // kdp(
          //     name: "emsac now",
          //     msg: nowt.hour.toString() + ":" + nowt.minute.toString(),
          //     c: 'gr');

          // kdp(
          //     name: "emsac mints",
          //     msg: (state.info.currentDay!.nightPrayer!.minut! + 5).toString() +
          //         ((nowt.hour < state.info.currentDay!.nightPrayer!.hour!))
          //             .toString(),
          //     c: 'y');
          if (now.hour < state.info.currentDay!.emsak!.hour! ||
              (now.hour == state.info.currentDay!.emsak!.hour! &&
                  now.minute <= state.info.currentDay!.emsak!.minut! + 5)) {
            state.info.nextTime = getNextTime(
              state.info.currentDay!.emsak!,
              state.info.agoDay?.nightPrayer,
              state.info.currentDay!,
              now,
              "emsak.png",
              "موعد  الامساك",
              "ص",
            );
          } else if (now.hour < state.info.currentDay!.morningPrayer!.hour! ||
              (now.hour == state.info.currentDay!.morningPrayer!.hour! &&
                  now.minute <=
                      state.info.currentDay!.morningPrayer!.minut! + 5)) {
            state.info.nextTime = getNextTime(
                state.info.currentDay!.morningPrayer!,
                state.info.currentDay!.emsak!,
                state.info.currentDay!,
                now,
                "fajer_prayer.png",
                "موعد صلاة الفجر",
                "ص");
          }
//"موعد صلاة الظهر"
          else if (now.hour >= (state.info.currentDay!.morningPrayer!.hour!) &&
              (now.hour < state.info.currentDay!.sunPrayer!.hour! ||
                  (now.hour == state.info.currentDay!.sunPrayer!.hour! &&
                      now.minute <=
                          state.info.currentDay!.sunPrayer!.minut! + 5))) {
            state.info.nextTime = getNextTime(
                state.info.currentDay!.sunPrayer!,
                state.info.currentDay!.morningPrayer!,
                state.info.currentDay!,
                now,
                "afternoon_prayer.png",
                "موعد صلاة الظهر",
                "م");
          }
          // "موعد صلاة المغرب",
          else if ((now.hour >= state.info.currentDay!.sunPrayer!.hour!) &&
              (now.hour < state.info.currentDay!.nightPrayer!.hour! ||
                  (now.hour == state.info.currentDay!.nightPrayer!.hour! &&
                      now.minute <=
                          state.info.currentDay!.nightPrayer!.minut! + 5))) {
            state.info.nextTime = getNextTime(
                state.info.currentDay!.nightPrayer!,
                state.info.currentDay!.sunPrayer!,
                state.info.currentDay!,
                now,
                "mugrab_prayer.png",
                "موعد صلاة المغرب",
                "م");
          } else if (now.hour > state.info.currentDay!.nightPrayer!.hour! ||
              (now.hour == state.info.currentDay!.nightPrayer!.hour! &&
                  now.minute >
                      state.info.currentDay!.nightPrayer!.minut! + 5)) {
            state.info.nextTime = getNextTime(
                state.info.nextDay!.emsak!,
                state.info.currentDay!.nightPrayer!,
                state.info.currentDay!,
                now,
                "emsak.png",
                "موعد  الامساك",
                "ص",
                isEmsak: true);
          } else {
            // if (nowt.hour >= state.info.currentDay!.emsak!.hour! &&
            // (state.info.currentDay!.emsak!.hour! == state.info.currentDay!.morningPrayer!.hour!)
            //     nowt.hour < state.info.currentDay!.morningPrayer!.hour!) {
          }

          refresh();
        }
      }
    });
  }

  NextTime getNextTime(
      PrayerTimeData nextPryer,
      PrayerTimeData? agoPryer,
      DaysPrayerTimes currentPryer,
      DateTime now,
      String image,
      String title,
      String timeExtention,
      {bool isEmsak = false}) {
    var currentTimeInSecond = 0;
    var nextPrayerTimeInSecond = 0;
    var agoPrayerTimeInSecond = 0;

    var diffrentInseconds = 0;

    late FullTime finalTime;

    var progress = 0.0;

    if (isEmsak) {
      currentTimeInSecond = getSeconds(24 - now.hour, now.minute, now.second);
      nextPrayerTimeInSecond = getSeconds(nextPryer.hour, nextPryer.minut, 0);
      agoPrayerTimeInSecond =
          getSeconds(24 - (agoPryer?.hour ?? 0), (agoPryer?.minut) ?? 0, 0);

      diffrentInseconds = nextPrayerTimeInSecond + currentTimeInSecond;

      finalTime = getDateFromSecond(diffrentInseconds);

      progress =
          diffrentInseconds / (nextPrayerTimeInSecond + agoPrayerTimeInSecond);
      print("00000");
    } else {
      currentTimeInSecond = getSeconds(now.hour, now.minute, now.second);
      nextPrayerTimeInSecond = getSeconds(nextPryer.hour, nextPryer.minut, 0);
      agoPrayerTimeInSecond =
          getSeconds((agoPryer?.hour ?? 0), (agoPryer?.minut) ?? 0, 0);

      diffrentInseconds = nextPrayerTimeInSecond - currentTimeInSecond;

      finalTime = getDateFromSecond(diffrentInseconds);

      if (agoPryer!.hour! > nextPryer.hour!) {
        progress = diffrentInseconds /
            (nextPrayerTimeInSecond + agoPrayerTimeInSecond);
      } else {
        progress = diffrentInseconds /
            (nextPrayerTimeInSecond - agoPrayerTimeInSecond);
      }
    }

    return NextTime(
      daysPrayerTimes: state.info.currentDay!,
      fullTime: finalTime,
      image: image,
      progress: progress,
      title: title,
      isKnow: diffrentInseconds <= 0,
      timeText:
          "${getTimeFormatWithoutSecond(hour: nextPryer.hour!, minut: nextPryer.minut!, seconds: 0)}  $timeExtention  ",
      staytimeText: getTimeFormat(
          hour: finalTime.hour,
          minut: finalTime.minuts,
          seconds: finalTime.seconds),
    );
  }

  refresh() {
    emit(RamadanStateLoading(state.info));
    emit(RamadanStateLoaded(state.info));
  }

  Future<void> loadAmal() async {
    try {
      final String response =
          await rootBundle.loadString('assets/docs/amal.json');
      final jsondata = await json.decode(response);
      state.info.ramadanAmal = RamadanAmalModel.fromJson(jsondata);
    } catch (e) {
      print("klsdfjnks");
      print(e);
    }
  }

  setNotification(EmsackModel data, index) async {
    final day = data.days![index];
    final date = DateTime.now();
    if (date.day > day.day!) {
      if ((data.days!.length - 1) > index) {
        setNotification(data, index + 1);
      }
      return;
    }
    try {
      if (Platform.isAndroid) {
        await showSchedualNotificationAthan(
            title: "اذان",
            subtitle: "حان الان موعد اذان الفجر",
            dateTime: DateTime(2023, day.month!, day.day!,
                day.morningPrayer!.hour!, day.morningPrayer!.minut!),
            id: 100 + day.day!);

        await showSchedualNotificationAthan(
            title: "اذان",
            subtitle: "حان الان موعد اذان الظهر",
            dateTime: DateTime(2023, day.month!, day.day!, day.sunPrayer!.hour!,
                day.sunPrayer!.minut!),
            id: 200 + day.day!);
        await showSchedualNotificationAthan(
            title: "اذان",
            subtitle: "حان الان موعد اذان المغرب",
            dateTime: DateTime(2023, day.month!, day.day!,
                day.nightPrayer!.hour!, day.nightPrayer!.minut!),
            id: 300 + day.day!);
      }
      if (Platform.isIOS) {
        await showSchedualIOSNotificationAthan(
            title: "اذان",
            subtitle: "حان الان موعد اذان الفجر",
            dateTime: DateTime(2023, day.month!, day.day!,
                day.morningPrayer!.hour!, day.morningPrayer!.minut!),
            id: 100 + day.day!);

        await showSchedualIOSNotificationAthan(
            title: "اذان",
            subtitle: "حان الان موعد اذان الظهر",
            dateTime: DateTime(2023, day.month!, day.day!, day.sunPrayer!.hour!,
                day.sunPrayer!.minut!),
            id: 200 + day.day!);
        await showSchedualIOSNotificationAthan(
            title: "اذان",
            subtitle: "حان الان موعد اذان المغرب",
            dateTime: DateTime(2023, day.month!, day.day!,
                day.nightPrayer!.hour!, day.nightPrayer!.minut!),
            id: 300 + day.day!);
      }

      await showSchedualNotificationEmsak(
          title: "امساك",
          subtitle: "حان الان موعد  الامساك اي الامتناع عن الاكل و والشرب",
          dateTime: DateTime(
              2023, day.month!, day.day!, day.emsak!.hour!, day.emsak!.minut!),
          id: 400 + day.day!);
    } catch (e) {
      print(e);
    }
    if ((data.days!.length - 1) > index) {
      setNotification(data, index + 1);
    }
  }

  checkTodayAmal(DuaCubit duaCubit) {
    if ((state.info.todayPrayer != null &&
            state.info.todayPrayer!.amaoOfToday != null &&
            state.info.todayPrayer!.day == state.info.dayNumber) ||
        duaCubit.state is! DuaStateLoaded) {
      return;
    }

    if (state.info.ramadanAmal != null && state.info.currentDay != null) {
      try {
        final index = state.info.ramadanAmal?.ramadan
            ?.indexWhere((element) => element.day == state.info.dayNumber);

        if (index != null && index != -1) {
          state.info.todayPrayer = state.info.ramadanAmal!.ramadan![index];

          if (duaCubit.state is DuaStateLoaded &&
              duaCubit.state.info.ramadanDuaModel != null) {
            state.info.todayPrayer!.amaoOfToday!
                .add(duaCubit.state.info.ramadanDuaModel!.dua![0]);
            state.info.todayPrayer!.amaoOfToday!
                .add(duaCubit.state.info.ramadanDuaModel!.dua![11]);
            state.info.todayPrayer!.amaoOfToday!
                .add(duaCubit.state.info.ramadanDuaModel!.dua![12]);
            state.info.todayPrayer!.amaoOfToday!
                .add(duaCubit.state.info.ramadanDuaModel!.dua![13]);
            if (DateTime.now().hour < 6) {
              state.info.todayPrayer!.amaoOfToday!
                  .insert(0, duaCubit.state.info.ramadanDuaModel!.dua![6]);
            }
          }
        }
      } catch (e) {}
    }
  }

  Future<void> loadData(Dua data, int index) async {
    if (data.path == null) {
      return;
    }
    try {
      final String response =
          await rootBundle.loadString('assets/docs/${data.path}');

      state.info.todayPrayer!.amaoOfToday![index].text = response;

      refresh();
    } catch (e) {
      print(e);
      refresh();
    }
  }
}
