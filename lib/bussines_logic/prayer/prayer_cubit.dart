import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:bloc/bloc.dart';
import 'package:ramadan/bussines_logic/Setting/cubit/setting_cubit.dart';
import 'package:ramadan/bussines_logic/prayer/fuctions/functions.dart';
import 'package:ramadan/bussines_logic/prayer/model/prayer_model.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/calendar_model.dart';
import 'package:ramadan/utils/utils.dart';

part 'paryer_state.dart';

part 'prayer_cubit.freezed.dart';

class PrayerCubit extends Cubit<PrayerState> {
  PrayerCubit() : super(const PrayerState.initial(datastatus: DataIdeal()));
  ArabicDateEntry? arabicDate;
  getPrayer(CityDetails? cityDetails, CalendarModel calendarModel) async {
    if (cityDetails == null) {
      return;
    }

    final preyerTimes = getPrayersTimeOfMonth(cityDetails, calendarModel);
    //preyerTimes?.days?.forEach((element) {
//       kdp(
//           name: "prayer time",
//           msg: '''
// element.month=${element.month}
// element.day=${element.day}
// element.dayname=${element.dayname}
// element.fajer=${element.fajer?.hour}:${element.fajer?.minut}

// ''',
//           c: 'm');
//     });

    emit(state.copyWith(preyerTimes: preyerTimes));

    final settingCubit = navigatorKey.currentContext!.read<SettingCubit>();
    if (state.preyerTimes != null &&
        settingCubit.state.setting?.isSetNotification != DateTime.now().day) {
      settingCubit.setNotification(state.preyerTimes!);
    }
  }

  prayerSchedular(CalendarModel calendarModel) async {
    emit(state.copyWith(datastatus: const SateSucess()));
    if (state.timer) {
      return;
    }

    emit(state.copyWith(timer: true));

    Timer.periodic(const Duration(seconds: 1), (timer) {
      var time = DateTime.now();

      if (state.preyerTimes == null) {
        return;
      }
      final currentdayIndex = state.preyerTimes!.days!.indexWhere((day) =>
          day.month == calendarModel.meladyMonth &&
          day.day == calendarModel.meladyDay);

      if (currentdayIndex > -1) {
        final curprayer = state.preyerTimes!.days![currentdayIndex];
        curprayer.fajer =
            time.hour > state.preyerTimes!.days![currentdayIndex].fajer!.hour!
                ? state.preyerTimes!.days![currentdayIndex + 1].fajer
                : state.preyerTimes!.days![currentdayIndex].fajer;
        emit(state.copyWith(
            currentDay: curprayer, dayNumber: currentdayIndex + 1));
        if (state.preyerTimes!.days!.length > (currentdayIndex + 1)) {
          emit(state.copyWith(
              nextDay: state.preyerTimes!.days![currentdayIndex + 1]));
        }
        if ((currentdayIndex - 1) > -1) {
          emit(state.copyWith(
              agoDay: state.preyerTimes!.days![currentdayIndex + -1]));
        }

        if (time.hour < state.currentDay!.fajer!.hour! ||
            (time.hour == state.currentDay!.fajer!.hour! &&
                time.minute <= state.currentDay!.fajer!.minut! + 5)) {
          final nextTime = getNextTime(
              state.currentDay!.fajer!,
              state.currentDay!.fajer!,
              state.currentDay!,
              time,
              "fajer_prayer.png",
              "موعد صلاة الفجر",
              "ص");
          emit(state.copyWith(nextTime: nextTime));
        }
//"موعد صلاة الظهر"
        else if (time.hour >= (state.currentDay!.fajer!.hour!) &&
            (time.hour < state.currentDay!.duhur!.hour! ||
                (time.hour == state.currentDay!.duhur!.hour! &&
                    time.minute <= state.currentDay!.duhur!.minut! + 5))) {
          emit(state.copyWith(
              nextTime: getNextTime(
                  state.currentDay!.duhur!,
                  state.currentDay!.fajer!,
                  state.currentDay!,
                  time,
                  "afternoon_prayer.png",
                  "موعد صلاة الظهر",
                  "م")));
        }
        // "موعد صلاة المغرب",
        else if ((time.hour >= state.currentDay!.duhur!.hour!) &&
            (time.hour < state.currentDay!.magrib!.hour! ||
                (time.hour == state.currentDay!.magrib!.hour! &&
                    time.minute <= state.currentDay!.magrib!.minut! + 5))) {
          emit(state.copyWith(
              nextTime: getNextTime(
                  state.currentDay!.magrib!,
                  state.currentDay!.duhur!,
                  state.currentDay!,
                  time,
                  "mugrab_prayer.png",
                  "موعد صلاة المغرب",
                  "م")));
        } else if (time.hour > state.currentDay!.magrib!.hour! ||
            (time.hour == state.currentDay!.magrib!.hour! &&
                time.minute > state.currentDay!.magrib!.minut! + 5)) {
          emit(state.copyWith(
              nextTime: fajerTimeStay(
            state.nextDay!.fajer!,
            state.currentDay!.magrib!,
            state.currentDay!,
            time,
            "fajer_prayer.png",
            "موعد صلاة الفجر",
            "ص",
          )));
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
}
