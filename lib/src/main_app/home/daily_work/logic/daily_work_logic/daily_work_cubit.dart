import 'dart:developer';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ramadan/src/core/data_source/remote.dart';
import 'package:ramadan/src/core/entity/data_state.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/core/enum/week_day.dart';
import 'package:ramadan/src/core/enum/work_timing.dart';
import 'package:ramadan/src/main_app/home/daily_work/logic/daily_work_logic/functions.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/calendar_model.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/daily_work_model.dart';
import 'package:ramadan/utils/utils.dart';

part 'daily_work_state.dart';
part 'daily_work_cubit.freezed.dart';

class DailyWorkCubit extends Cubit<DailyWorkState> {
  DailyWorkCubit() : super(const DailyWorkState.initial());
  getTodayWork(CalendarModel? calendarModel) async {
    emit(state.copyWith(datastatus: DataStatus.loading));

    final data = await FireStoreRemote.getWorkspi();
    if (data is DataSuccess) {
      DailyWorkModel todaWork = DailyWorkModel(dateTime: DateTime.now());
      DailyWorkModel monthlyWork = DailyWorkModel(dateTime: DateTime.now());

      monthlyWork.data = data.data?.dailyWorkModel!.data
          ?.where((element) => element.month == calendarModel!.hijreeMonth)
          .toList();

      todaWork.data =
          filterTodayWork(calendarModel, data.data!.dailyWorkModel!.data);

      emit(state.copyWith(
          datastatus: DataStatus.success,
          todayWorkModel: todaWork,
          allDailyWorkModel: data.data!.dailyWorkModel,
          monthWorkModel: monthlyWork,
          refrenses: data.data!.refrenses));
      return;
    }
    emit(state.copyWith(datastatus: DataStatus.error));
  }

  deletWork(String id) async {
    emit(state.copyWith(datastatus: DataStatus.loading));

    try {
      await state.refrenses
          ?.where((element) => element.id == id)
          .first
          .reference
          .delete();
      final allwork = state.allDailyWorkModel!;
      final todaywork = state.todayWorkModel!;
      allwork.data!.removeWhere((element) => element.id == id);
      todaywork.data!.removeWhere((element) => element.id == id);

      emit(state.copyWith(
          datastatus: DataStatus.success,
          todayWorkModel: todaywork,
          allDailyWorkModel: allwork));
    } catch (e) {
      emit(state.copyWith(datastatus: DataStatus.error));
    }
  }

  void add(DailyWorkData dailyWorkData) {
    emit(state.copyWith(datastatus: DataStatus.loading));

    final data = state.allDailyWorkModel ?? DailyWorkModel(data: []);
    data.data!.insert(0, dailyWorkData);

    emit(state.copyWith(
        datastatus: DataStatus.success, allDailyWorkModel: data));
  }

  List<DailyWorkData>? filterTodayWork(
      CalendarModel? calendarModel, List<DailyWorkData>? data) {
    // Get the first day of the month

    //final lastFriday = getLastWeekDayDate(firstDayOfMonth, WeekDay.friday, 1);

    if (calendarModel != null && data != null && data.isNotEmpty) {
      log("90834902849");
      final filteredData = <DailyWorkData>[];

      for (var element in data) {
        switch (element.workTiming) {
          case WorkTiming.daily:
            filteredData.add(element);
            break;

          case WorkTiming.dailyInMonth
              when element.month == calendarModel.hijreeMonth:
            filteredData.add(element);
            break;
          case WorkTiming.dayInmonth
              when (element.month == calendarModel.hijreeMonth &&
                  element.day == calendarModel.hijreeDay):
            filteredData.add(element);
            break;
          case WorkTiming.oneWeekDayInMonth
              when (element.month == calendarModel.hijreeMonth &&
                  getFirstWeekDayDate(calendarModel, WeekDay.friday, 1)):
            filteredData.add(element);
            break;
          case WorkTiming.weekly when DateTime.now().weekday == element.weekDay:
            filteredData.add(element);

            break;
          case WorkTiming.weeklyInMonth
              when (element.month == calendarModel.hijreeMonth &&
                  element.weekDay == DateTime.now().weekday):
            filteredData.add(element);
            break;
          default:
        }
      }
      // filteredData = data
      //     ?.where((element) =>
      //         element.day == calendarModel.hijreeDay &&
      //         element.month == calendarModel.hijreeMonth &&
      //         (element.weekDay ?? -1) < 0)
      //     .toList();

      return filteredData;
    } else {
      return [];
    }
  }
}
