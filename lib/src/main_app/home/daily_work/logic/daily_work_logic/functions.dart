import 'package:ramadan/src/core/enum/week_day.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/calendar_model.dart';

getLastWeekDayDate(CalendarModel calendarModel, WeekDay weekDay, int dayes) {
  // Find the last Friday
  DateTime lastDayOfMonth = DateTime(2024, calendarModel.hijreeMonth! + 1, 0);

  final dateByArabic = DateTime.now().add(Duration(days: 30 - dayes));
  int lastFridayOffset =
      (weekDay.index + 1) - dateByArabic.weekday; // 5 represents Friday
  if (lastFridayOffset > 0) {
    lastFridayOffset -=
        7; // If the last day is before Friday, move to previous Friday
  }

  // Calculate the date of the last Friday

  DateTime lastFriday = DateTime(
      lastDayOfMonth.year, calendarModel.hijreeMonth! + 1, lastFridayOffset);
  // lastDayOfMonth.add(Duration(days: lastFridayOffset - 1));

  // return lastFriday;

  if (lastFriday.month == calendarModel.hijreeMonth &&
      lastFriday.day == calendarModel.hijreeDay) {
    return true;
  }
  return false;
}

bool getFirstWeekDayDate(
    CalendarModel calendarModel, WeekDay weekDay, int dayes) {
  // Find the first Friday
  DateTime firstDayOfMonth = DateTime(2024, calendarModel.hijreeMonth!, 1);
  final dateByArabic = DateTime.now().subtract(Duration(days: dayes));

  int firstFridayOffset =
      (weekDay.index + 1) - dateByArabic.weekday; // 5 represents Friday
  if (firstFridayOffset < 0) {
    firstFridayOffset +=
        7; // If the first day is after Friday, move to next Friday
  }

  // Calculate the date of the first Friday
  final workDate = firstDayOfMonth.add(Duration(days: firstFridayOffset - 1));

  if (workDate.month == calendarModel.hijreeMonth &&
      workDate.day == calendarModel.hijreeDay) {
    return true;
  }
  return false;
}
