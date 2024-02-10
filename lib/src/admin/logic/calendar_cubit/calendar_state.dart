part of 'calendar_cubit.dart';

@freezed
class CalendarState with _$CalendarState {
  const factory CalendarState.initial(
      {@Default(DataStatus.ideal) DataStatus datastatus,
      CalendarModel? calendarModel,
      CalendarModel? today}) = _Initial;
}
