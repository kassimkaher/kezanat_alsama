import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:ramadan/bussines_logic/Setting/model/setting_model.dart';
import 'package:ramadan/bussines_logic/prayer/fuctions/functions.dart';
import 'package:ramadan/bussines_logic/prayer/model/arabic_date_model.dart';
import 'package:ramadan/bussines_logic/prayer/model/prayer_model.dart';
import 'package:ramadan/services/local_db.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/main_app/dua/bussines_logic/dua_cubit.dart';
import 'package:ramadan/utils/extention.dart';

part 'paryer_state.dart';

part 'prayer_cubit.freezed.dart';

class PrayerCubit extends Cubit<PrayerState> {
  PrayerCubit() : super(PrayerState.initial());
  ArabicDateEntry? arabicDate;
  getPrayer(CityDetails? cityDetails) async {
    if (cityDetails == null) {
      return;
    }

    final preyerTimes = getPrayersTimeOfMonth(cityDetails);

    emit(state.copyWith(preyerTimes: preyerTimes));
  }

  listenTime(DuaCubit duaCubit) async {
    emit(state.copyWith(datastatus: DataStatus.success));
    if (state.timer) {
      return;
    }

    emit(state.copyWith(timer: true));

    Timer.periodic(const Duration(seconds: 1), (timer) {
      var now = DateTime.now();

      if (state.preyerTimes != null) {
        final currentdayIndex = state.preyerTimes!.days!
            .indexWhere((day) => day.month == now.month && day.day == now.day);

        //  kdp(name: "chek time ", msg: currentdayIndex, c: 'gr');
        if (currentdayIndex > -1) {
          emit(state.copyWith(
              currentDay: state.preyerTimes!.days![currentdayIndex],
              dayNumber: currentdayIndex + 1));
          if (state.preyerTimes!.days!.length > (currentdayIndex + 1)) {
            emit(state.copyWith(
                nextDay: state.preyerTimes!.days![currentdayIndex + 1]));
          }
          if ((currentdayIndex - 1) > -1) {
            emit(state.copyWith(
                agoDay: state.preyerTimes!.days![currentdayIndex + -1]));
          }

          if (now.hour < state.currentDay!.fajer!.hour! ||
              (now.hour == state.currentDay!.fajer!.hour! &&
                  now.minute <= state.currentDay!.fajer!.minut! + 5)) {
            final nextTime = getNextTime(
                state.currentDay!.fajer!,
                state.currentDay!.fajer!,
                state.currentDay!,
                now,
                "fajer_prayer.png",
                "موعد صلاة الفجر",
                "ص");
            emit(state.copyWith(nextTime: nextTime));
          }
//"موعد صلاة الظهر"
          else if (now.hour >= (state.currentDay!.fajer!.hour!) &&
              (now.hour < state.currentDay!.duhur!.hour! ||
                  (now.hour == state.currentDay!.duhur!.hour! &&
                      now.minute <= state.currentDay!.duhur!.minut! + 5))) {
            emit(state.copyWith(
                nextTime: getNextTime(
                    state.currentDay!.duhur!,
                    state.currentDay!.fajer!,
                    state.currentDay!,
                    now,
                    "afternoon_prayer.png",
                    "موعد صلاة الظهر",
                    "م")));
          }
          // "موعد صلاة المغرب",
          else if ((now.hour >= state.currentDay!.duhur!.hour!) &&
              (now.hour < state.currentDay!.magrib!.hour! ||
                  (now.hour == state.currentDay!.magrib!.hour! &&
                      now.minute <= state.currentDay!.magrib!.minut! + 5))) {
            emit(state.copyWith(
                nextTime: getNextTime(
                    state.currentDay!.magrib!,
                    state.currentDay!.duhur!,
                    state.currentDay!,
                    now,
                    "mugrab_prayer.png",
                    "موعد صلاة المغرب",
                    "م")));
          } else if (now.hour > state.currentDay!.magrib!.hour! ||
              (now.hour == state.currentDay!.magrib!.hour! &&
                  now.minute > state.currentDay!.magrib!.minut! + 5)) {
            emit(state.copyWith(
                nextTime: fajerTimeStay(
              state.nextDay!.fajer!,
              state.currentDay!.magrib!,
              state.currentDay!,
              now,
              "fajer_prayer.png",
              "موعد صلاة الفجر",
              "ص",
            )));
          }
        }
      }
    });
  }

  NextTime getNextTime(
      PrayerTimeData nextPryer,
      PrayerTimeData? agoPryer,
      PrayerTimesEntity currentPryer,
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
      daysPrayerTimes: state.currentDay!,
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

  NextTime fajerTimeStay(
      PrayerTimeData nextPryer,
      PrayerTimeData? agoPryer,
      PrayerTimesEntity currentPryer,
      DateTime now,
      String image,
      String title,
      String timeExtention) {
    late FullTime finalTime;

    var progress = 0.0;
    final now = DateTime.now();
    final datenext = now
        .copyWith(hour: nextPryer.hour, minute: nextPryer.minut, second: 0)
        .add(Duration(days: 1));

    final dateagow =
        now.copyWith(hour: agoPryer!.hour, minute: agoPryer.minut, second: 0);

    final diffrent = datenext.difference(now);
    final diffrentProgress = datenext.difference(dateagow);

    finalTime = getDateFromSecond(diffrent.inSeconds);
    progress = diffrent.inSeconds / diffrentProgress.inSeconds;

    return NextTime(
      daysPrayerTimes: state.currentDay!,
      fullTime: finalTime,
      image: image,
      progress: progress,
      title: title,
      isKnow: diffrent.inSeconds <= 0,
      timeText:
          "${getTimeFormatWithoutSecond(hour: nextPryer.hour!, minut: nextPryer.minut!, seconds: 0)}  $timeExtention  ",
      staytimeText: getTimeFormat(
          hour: finalTime.hour,
          minut: finalTime.minuts,
          seconds: finalTime.seconds),
    );
  }

  getArabicDate() async {
    arabicDate = LocalDB.getArabicDay();

    final url =
        Uri.parse("https://www.habibur.com/hijri/api01/date/?format=json");

    try {
      final response = await http.get(url);
      // kdp(name: "getDaysApi", msg: response.statusCode, c: 'y');
      // kdp(name: "getDaysApi", msg: response.body, c: 'y');

      if (response.statusCode == 200) {
        final info = response.body.split("-");
        final arabicDateEntry = ArabicDateEntry(info[2], info[1], info[0]);
        LocalDB.saveArabicDate(arabicDateEntry);
        arabicDate = arabicDateEntry;
      }
    } catch (e) {
      print("kjdkcljdskljcklsd===$e");
    }
  }
}
