part of 'prayer_cubit.dart';

abstract class PrayerState extends Equatable {
  final PrayerInfo info;
  const PrayerState(this.info);

  @override
  List<Object> get props => [info];
}

class PrayerStateInital extends PrayerState {
  const PrayerStateInital(super.info);
}

class PrayerStateLoaded extends PrayerState {
  const PrayerStateLoaded(super.info);
}

class PrayerStateLoading extends PrayerState {
  const PrayerStateLoading(super.info);
}

class PrayerStateFiald extends PrayerState {
  const PrayerStateFiald(super.info);
}

class PrayerInfo {
  dynamic storage;
  PrayersTimeModel? preyerTimes;
  DaysPrayerTimes? currentDay;
  DaysPrayerTimes? nextDay;
  NextTime? nextTime;
  bool isListener = false;
  PrayerInfo({
    this.storage,
  });

  var documentExpanded = false;

  DaysPrayerTimes? agoDay;

  var dayNumber = 0;
  bool timer = false;
  RamadanAmalModel? ramadanAmal;
  TodayPrayer? todayPrayer;
}

class NextTime {
  FullTime fullTime;
  String title;
  String timeText;
  String staytimeText;
  String image;
  DaysPrayerTimes daysPrayerTimes;
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
