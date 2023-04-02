part of 'ramadan_cubit.dart';

abstract class RamadanState extends Equatable {
  final RamadanInfo info;
  const RamadanState(this.info);

  @override
  List<Object> get props => [info];
}

class RamadanStateInital extends RamadanState {
  const RamadanStateInital(super.info);
}

class RamadanStateLoaded extends RamadanState {
  const RamadanStateLoaded(super.info);
}

class RamadanStateLoading extends RamadanState {
  const RamadanStateLoading(super.info);
}

class RamadanStateFiald extends RamadanState {
  const RamadanStateFiald(super.info);
}

class RamadanInfo {
  dynamic storage;
  EmsackModel? emsackModel;
  DaysPrayerTimes? currentDay;
  DaysPrayerTimes? nextDay;
  NextTime? nextTime;
  bool isListener = false;
  RamadanInfo({
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
