part of 'calendar_cubit.dart';

@freezed
class CalendarState with _$CalendarState {
  const factory CalendarState.initial(
      {required DataStatus datastatus,
      CalendarModel? calendarModel,
      CalendarModel? today}) = _Initial;
}
