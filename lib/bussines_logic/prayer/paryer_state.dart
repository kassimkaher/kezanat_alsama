part of 'prayer_cubit.dart';

@freezed
class PrayerState with _$PrayerState {
  const factory PrayerState.initial(
      {required DataStatus datastatus,
      PrayersTimeModel? preyerTimes,
      PrayerTimesEntity? currentDay,
      PrayerTimesEntity? nextDay,
      NextTime? nextTime,
      PrayerTimesEntity? agoDay,
      @Default(false) bool timer,
      @Default(0) int dayNumber}) = _Initial;
}

class NextTime {
  FullTime fullTime;
  String title;
  String timeText;
  String staytimeText;
  String image;
  PrayerTimesEntity daysPrayerTimes;
  double progress;
  bool isKnow;

  NextTime(
      {required this.daysPrayerTimes,
      required this.timeText,
      required this.title,
      required this.staytimeText,
      required this.fullTime,
      required this.progress,
      required this.image,
      required this.isKnow});
}
