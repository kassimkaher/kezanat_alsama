import 'package:ramadan/utils/utils.dart';

class PrayersTimeModel {
  List<DaysPrayerTimes>? days;

  PrayersTimeModel({this.days});
}

class DaysPrayerTimes {
  int? month;
  int? day;
  int? dayname;

  PrayerTimeData? fajer;
  PrayerTimeData? sunset;
  PrayerTimeData? duhur;
  PrayerTimeData? sunrise;
  PrayerTimeData? magrib;
  PrayerTimeData? esha;
  PrayerTimeData? middileNight;

  DaysPrayerTimes(
      {this.month,
      this.day,
      this.dayname,
      this.fajer,
      this.sunrise,
      this.duhur,
      this.sunset,
      this.magrib,
      this.esha,
      this.middileNight});
}

class PrayerTimeData {
  int? hour;
  int? minut;
  PrayerTimeData.fill(double time) {
    hour = time.toDuration().inHours;
    minut = time.toDuration().inMinutes % 60;
  }
  PrayerTimeData({this.hour, this.minut});
}

class FullTime {
  int hour;
  int minuts;
  int seconds;
  FullTime(this.hour, this.minuts, this.seconds);
}
