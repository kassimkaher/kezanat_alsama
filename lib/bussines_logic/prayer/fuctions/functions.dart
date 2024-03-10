import 'dart:math';

import 'package:intl/intl.dart';
import 'package:ramadan/bussines_logic/Setting/model/setting_model.dart';
import 'package:ramadan/bussines_logic/prayer/model/prayer_model.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/calendar_model.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:solar_calculator/solar_calculator.dart';

double equationOfTime(int dayOfYear) {
  // Convert the day of year to radians
  double n = 2 * pi * (dayOfYear - 1) / 365;

  // Calculate the equation of time in minutes
  double e = 229.18 *
      (0.000075 +
          0.001868 * cos(n) -
          0.032077 * sin(n) -
          0.014615 * cos(2 * n) -
          0.040849 * sin(2 * n));

  // Convert the equation of time to hours
  double equationInHours = e / 60;

  return equationInHours;
}

int getDayNumberInYear(DateTime currentDate) {
  int dayOfYear =
      currentDate.difference(DateTime(currentDate.year, 1, 1)).inDays + 1;
  return dayOfYear;
}

double sunDeclinationFunc(int dayOfYear) {
  double angle = 23.45; // Earth's axial tilt in degrees

  double declination = angle * sin(2 * pi * (284 + dayOfYear) / 365);
  return declination;
}

double calculateFajer(DateTime date, Dhuhr, double latitiude) {
  final sunDeclination = sunDeclinationFunc(getDayNumberInYear(date));

  final top = (-sin(degToRad(18)) -
      (sin(degToRad(latitiude)) * sin(degToRad(sunDeclination))));
  final bottom = (cos(degToRad(latitiude)) * cos(degToRad(sunDeclination)));
  final qst = (top / bottom);
  var acrcos = radToDeg(acos(qst));

  var T = (1 / 15) * acrcos;

  double fajer = Dhuhr - T;

  return fajer;
}

double calculateEsha(DateTime date, Dhuhr, double latitiude) {
  var d = sunDeclinationFunc(getDayNumberInYear(date));

  var top =
      (-sin(degToRad(14)) - (sin(degToRad(latitiude)) * sin(degToRad(d))));
  var bottom = (cos(degToRad(latitiude)) * cos(degToRad(d)));
  var qst = (top / bottom);
  var acrcos = radToDeg(acos(qst));

  var T = (1 / 15) * acrcos;

  double esha = Dhuhr + T;

  return esha;
}

double calculateMugrib(DateTime date, Dhuhr, double latitiude) {
  var d = sunDeclinationFunc(getDayNumberInYear(date));

  var top = (-sin(degToRad(4)) - (sin(degToRad(latitiude)) * sin(degToRad(d))));
  var bottom = (cos(degToRad(latitiude)) * cos(degToRad(d)));
  var qst = (top / bottom);
  var acrcos = radToDeg(acos(qst));

  var T = (1 / 15) * acrcos;

  double esha = Dhuhr + T;

  return esha;
}

double calculateMidnite({required double fajer, required Duration sunset}) {
  final nightD = Duration(minutes: 1440 - sunset.inMinutes);
  final dur = fajer.toDuration().inMinutes + nightD.inMinutes;
  final halfDur = dur / 2;
  final midnight = Duration(minutes: halfDur.toInt() + sunset.inMinutes);

  return midnight.toTime();
}

String getTimeText(num hours) {
  var hour = (hours.toInt());
  var min = ((hours % 1) * 60).toInt();
  return "$hour:$min";
}

double durationToTime(Duration duration) {
  final du = (duration.inHours + (duration.inMinutes % 60) / 60);
  return du;
}

Duration timeToDuration(double time) {
  final h = time.toInt();
  var m = ((time % 1) * 60).toInt();

  return Duration(hours: h, minutes: m);
}

double degToRad(double degrees) {
  return degrees * pi / 180;
}

double radToDeg(double radians) {
  return radians * 180 / pi;
}

PrayersTimeModel? getPrayersTimeOfMonth(
    CityDetails cityDetails, CalendarModel calendarModel) {
  final prayers = PrayersTimeModel(days: []);
  var date = DateTime(DateTime.now().year, calendarModel.meladyMonth!,
      calendarModel.meladyDay!);

  for (int i = 0; i < 30; i++) {
    final timezone = date.timeZoneName.toTimeZone();
    double equationTime = equationOfTime(getDayNumberInYear(date));
    final duhurPrayer =
        12 + timezone - (cityDetails.longitude! / 15) - (equationTime);

    final instant = Instant(
        year: date.year,
        month: date.month,
        day: date.day,
        hour: 12,
        timeZoneOffset: timezone);

    final calc =
        SolarCalculator(instant, cityDetails.latitude!, cityDetails.longitude!);

    final fajrTime = calculateFajer(date, duhurPrayer, cityDetails.latitude!);
    final esha = calculateEsha(date, duhurPrayer, cityDetails.latitude!);
    final mugrib = calculateMugrib(date, duhurPrayer, cityDetails.latitude!);
    final midnight =
        calculateMidnite(sunset: calc.sunsetTime.time, fajer: fajrTime);
    final sunset = calc.sunsetTime.time.toTime();
    final sunris = calc.sunriseTime.time.toTime();
//     kdp(
//         name: "prayer day name",
//         msg: '''
// date.weekday=${date.weekday}
// day name=${DateFormat('EEEE').format(date)}
// date = $date
// ''',
//         c: "cy");
    prayers.days!.add(
      PrayerTimesEntity(
          month: date.month,
          day: date.day,
          dayname: DateFormat('EEEE', "ar").format(date),
          emsak: calendarModel.hijreeMonth == 9
              ? PrayerTimeData.fill(fajrTime)
              : null,
          fajer: PrayerTimeData.fill(fajrTime),
          duhur: PrayerTimeData.fill(duhurPrayer),
          magrib: PrayerTimeData.fill(mugrib).addMinuts(2),
          esha: PrayerTimeData.fill(esha),
          middileNight: PrayerTimeData.fill(midnight),
          sunrise: PrayerTimeData.fill(sunris),
          sunset: PrayerTimeData.fill(sunset)),
    );
    date = date.add(const Duration(days: 1));
  }
  return prayers;
}
