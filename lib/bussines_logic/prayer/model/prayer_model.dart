import 'package:ramadan/utils/utils.dart';

class PrayersTimeModel {
  List<PrayerTimesEntity>? days;

  PrayersTimeModel({this.days});
}

class PrayerTimesEntity {
  int? month;
  int? day;
  String? dayname;

  PrayerTimeData? fajer;
  PrayerTimeData? sunset;
  PrayerTimeData? duhur;
  PrayerTimeData? sunrise;
  PrayerTimeData? magrib;
  PrayerTimeData? esha;
  PrayerTimeData? middileNight;
  PrayerTimeData? emsak;

  PrayerTimesEntity(
      {this.month,
      this.day,
      this.dayname,
      this.fajer,
      this.sunrise,
      this.duhur,
      this.sunset,
      this.magrib,
      this.esha,
      this.middileNight,
      this.emsak});
}

class PrayerTimeData {
  int? hour;
  int? minut;
  PrayerTimeData.fill(double time) {
    hour = time.toDuration().inHours;
    minut = time.toDuration().inMinutes % 60;
  }
  PrayerTimeData({this.hour, this.minut});
  addMinuts(minuts) =>
      PrayerTimeData(hour: hour, minut: (minut! + minuts).toInt());
}

class FullTime {
  int hour;
  int minuts;
  int seconds;
  FullTime(this.hour, this.minuts, this.seconds);
}
