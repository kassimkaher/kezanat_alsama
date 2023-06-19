import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:ramadan/bussines_logic/dua/dua_cubit.dart';
import 'package:ramadan/model/prayer_model.dart';
import 'package:ramadan/model/ramadan_amal.dart';
import 'package:ramadan/model/ramadan_dua.dart';
import 'package:ramadan/model/setting_model.dart';
import 'package:ramadan/services/validation.dart';
import 'package:ramadan/utils/extention.dart';
import 'package:solar_calculator/solar_calculator.dart';

part 'paryer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  PrayerCubit() : super(PrayerStateInital(PrayerInfo()));

  getPrayer(CityDetails? cityDetails) async {
    if (cityDetails == null) {
      return;
    }
    try {
      state.info.preyerTimes = PrayersTimeModel(days: []);
      var date = DateTime.now();

      for (int i = 0; i < 30; i++) {
        final timezone = DateTime.now().timeZoneName.toTimeZone();
        double equationTime = equationOfTime(getDayNumberInYear(date));
        final duhurPrayer =
            12 + timezone - (cityDetails.longitude! / 15) - (equationTime);

        final instant = Instant(
            year: date.year,
            month: date.month,
            day: date.day,
            hour: 1,
            timeZoneOffset: timezone);

        final calc = SolarCalculator(
            instant, cityDetails.latitude!, cityDetails.longitude!);

        final fajrTime =
            calculateFajer(date, duhurPrayer, cityDetails.latitude!);
        final esha = calculateEsha(date, duhurPrayer, cityDetails.latitude!);
        final mugrib =
            calculateMugrib(date, duhurPrayer, cityDetails.latitude!);
        final midnight =
            calculateMidnite(sunset: calc.sunsetTime.time, fajer: fajrTime);
        final sunset = calc.sunsetTime.time.toTime();
        final sunris = calc.sunriseTime.time.toTime();

        state.info.preyerTimes!.days!.add(
          DaysPrayerTimes(
              month: date.month,
              day: date.day,
              dayname: date.weekday,
              fajer: PrayerTimeData.fill(fajrTime),
              duhur: PrayerTimeData.fill(duhurPrayer),
              magrib: PrayerTimeData.fill(mugrib),
              esha: PrayerTimeData.fill(esha),
              middileNight: PrayerTimeData.fill(midnight),
              sunrise: PrayerTimeData.fill(sunris),
              sunset: PrayerTimeData.fill(sunset)),
        );
        date = date.add(const Duration(days: 1));
      }

      emit(PrayerStateLoaded(state.info));

      refresh();
    } catch (e) {
      print(e);
    }
  }

  listenTime(DuaCubit duaCubit) async {
    if (state.info.timer) {
      return;
    }
    state.info.timer = true;
    refresh();

    await loadAmal();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      var now = DateTime.now();

      checkTodayAmal(duaCubit);
      if (state is PrayerStateLoaded && state.info.preyerTimes != null) {
        final currentdayIndex = state.info.preyerTimes!.days!
            .indexWhere((day) => day.month == now.month && day.day == now.day);

        //  kdp(name: "chek time ", msg: currentdayIndex, c: 'gr');
        if (currentdayIndex > -1) {
          state.info.currentDay =
              state.info.preyerTimes!.days![currentdayIndex];
          state.info.dayNumber = currentdayIndex + 1;

          if (state.info.preyerTimes!.days!.length > (currentdayIndex + 1)) {
            state.info.nextDay =
                state.info.preyerTimes!.days![currentdayIndex + 1];
          }
          if ((currentdayIndex - 1) > -1) {
            state.info.agoDay =
                state.info.preyerTimes!.days![currentdayIndex + -1];
          }

          if (now.hour < state.info.currentDay!.fajer!.hour! ||
              (now.hour == state.info.currentDay!.fajer!.hour! &&
                  now.minute <= state.info.currentDay!.fajer!.minut! + 5)) {
            state.info.nextTime = getNextTime(
                state.info.currentDay!.fajer!,
                state.info.currentDay!.fajer!,
                state.info.currentDay!,
                now,
                "fajer_prayer.png",
                "موعد صلاة الفجر",
                "ص");
          }
//"موعد صلاة الظهر"
          else if (now.hour >= (state.info.currentDay!.fajer!.hour!) &&
              (now.hour < state.info.currentDay!.duhur!.hour! ||
                  (now.hour == state.info.currentDay!.duhur!.hour! &&
                      now.minute <=
                          state.info.currentDay!.duhur!.minut! + 5))) {
            state.info.nextTime = getNextTime(
                state.info.currentDay!.duhur!,
                state.info.currentDay!.fajer!,
                state.info.currentDay!,
                now,
                "afternoon_prayer.png",
                "موعد صلاة الظهر",
                "م");
          }
          // "موعد صلاة المغرب",
          else if ((now.hour >= state.info.currentDay!.duhur!.hour!) &&
              (now.hour < state.info.currentDay!.magrib!.hour! ||
                  (now.hour == state.info.currentDay!.magrib!.hour! &&
                      now.minute <=
                          state.info.currentDay!.magrib!.minut! + 5))) {
            state.info.nextTime = getNextTime(
                state.info.currentDay!.magrib!,
                state.info.currentDay!.duhur!,
                state.info.currentDay!,
                now,
                "mugrab_prayer.png",
                "موعد صلاة المغرب",
                "م");
          } else if (now.hour > state.info.currentDay!.magrib!.hour! ||
              (now.hour == state.info.currentDay!.magrib!.hour! &&
                  now.minute > state.info.currentDay!.magrib!.minut! + 5)) {
            state.info.nextTime = getNextTime(
                state.info.nextDay!.fajer!,
                state.info.currentDay!.magrib!,
                state.info.currentDay!,
                now,
                "emsak.png",
                "موعد  الامساك",
                "ص",
                isEmsak: true);
          } else {
            // if (nowt.hour >= state.info.currentDay!.emsak!.hour! &&
            // (state.info.currentDay!.emsak!.hour! == state.info.currentDay!.fajer!.hour!)
            //     nowt.hour < state.info.currentDay!.fajer!.hour!) {
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

    currentTimeInSecond = getSeconds(now.hour, now.minute, now.second);
    nextPrayerTimeInSecond = getSeconds(nextPryer.hour, nextPryer.minut, 0);
    agoPrayerTimeInSecond =
        getSeconds((agoPryer?.hour ?? 0), (agoPryer?.minut) ?? 0, 0);

    diffrentInseconds = nextPrayerTimeInSecond - currentTimeInSecond;

    finalTime = getDateFromSecond(diffrentInseconds);

    if (agoPryer!.hour! > nextPryer.hour!) {
      progress =
          diffrentInseconds / (nextPrayerTimeInSecond + agoPrayerTimeInSecond);
    } else {
      progress =
          diffrentInseconds / (nextPrayerTimeInSecond - agoPrayerTimeInSecond);
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
    emit(PrayerStateLoading(state.info));
    emit(PrayerStateLoaded(state.info));
  }

  Future<void> loadAmal() async {
    try {
      final String response =
          await rootBundle.loadString('assets/docs/amal.json');
      final jsondata = await json.decode(response);
      state.info.ramadanAmal = RamadanAmalModel.fromJson(jsondata);
    } catch (e) {
      // print("klsdfjnks");
      // print(e);
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
