import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ramadan/src/core/data_source/remote.dart';
import 'package:ramadan/src/core/entity/data_state.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/core/enum/work_timing.dart';
import 'package:ramadan/src/core/enum/work_type.dart';
import 'package:ramadan/src/main_app/home/daily_work/logic/daily_work_logic/functions.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/calendar_model.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/daily_work_model.dart';
import 'package:ramadan/utils/utils.dart';

part 'daily_work_state.dart';
part 'daily_work_cubit.freezed.dart';

class DailyWorkCubit extends Cubit<DailyWorkState> {
  DailyWorkCubit()
      : super(const DailyWorkState.initial(datastatus: DataIdeal()));
  getTodayWorkFromRemote(CalendarModel? calendarModel) async {
    emit(state.copyWith(datastatus: const StateLoading()));

    final data = await FireStoreRemote.getWorkspi();
    if (data is DataSuccess) {
      DailyWorkModel allWorkModel = DailyWorkModel(dateTime: DateTime.now());
      DailyWorkModel allRelationShipModel =
          DailyWorkModel(dateTime: DateTime.now());

      DailyWorkModel monthlyWork = DailyWorkModel(dateTime: DateTime.now());
      DailyWorkModel relationShipData =
          DailyWorkModel(dateTime: DateTime.now());

      // get all work exepct
      allWorkModel.data = data.data?.dailyWorkModel!.data
          ?.where((element) => element.type != WorkType.relationship)
          .toList();

      // get all relationship
      allRelationShipModel.data = data.data?.dailyWorkModel!.data
          ?.where((element) => element.type == WorkType.relationship)
          .toList();

      monthlyWork.data = data.data?.dailyWorkModel!.data
          ?.where((element) =>
              element.month == calendarModel!.hijreeMonth &&
              element.type != WorkType.relationship)
          .toList();

      relationShipData.data = data.data?.dailyWorkModel!.data
          ?.where((element) =>
              element.month == calendarModel!.hijreeMonth &&
              element.day == calendarModel.hijreeDay &&
              element.type == WorkType.relationship)
          .toList();

      emit(state.copyWith(
          datastatus: const SateSucess(),
          todayWorkModel:
              filterTodayWork(calendarModel, data.data!.dailyWorkModel!.data),
          allDailyWorkModel: data.data!.dailyWorkModel,
          monthWorkModel: monthlyWork,
          //مناسبات
          allRelationShipModel: allRelationShipModel,
          relationShipData: relationShipData,
          refrenses: data.data!.refrenses));
      startSchedual(calendarModel!);
      return;
    }
    emit(state.copyWith(datastatus: const StateError()));
  }

  getTodayWorkFromLocal(CalendarModel? calendarModel) async {
    emit(state.copyWith(datastatus: const StateLoading()));

    final data = await FireStoreRemote.getWorkspi(fromLocal: true);
    if (data is DataSuccess) {
      DailyWorkModel allWorkModel = DailyWorkModel(dateTime: DateTime.now());
      DailyWorkModel allRelationShipModel =
          DailyWorkModel(dateTime: DateTime.now());

      DailyWorkModel monthlyWork = DailyWorkModel(dateTime: DateTime.now());
      DailyWorkModel relationShipData =
          DailyWorkModel(dateTime: DateTime.now());

      // get all work exepct
      allWorkModel.data = data.data?.dailyWorkModel!.data
          ?.where((element) => element.type != WorkType.relationship)
          .toList();

      // get all relationship
      allRelationShipModel.data = data.data?.dailyWorkModel!.data
          ?.where((element) => element.type == WorkType.relationship)
          .toList();

      monthlyWork.data = data.data?.dailyWorkModel!.data
          ?.where((element) =>
              element.month == calendarModel!.hijreeMonth &&
              element.type != WorkType.relationship)
          .toList();

      relationShipData.data = data.data?.dailyWorkModel!.data
          ?.where((element) =>
              element.month == calendarModel!.hijreeMonth &&
              element.day == calendarModel.hijreeDay &&
              element.type == WorkType.relationship)
          .toList();

      emit(state.copyWith(
          datastatus: const SateSucess(),
          todayWorkModel:
              filterTodayWork(calendarModel, data.data!.dailyWorkModel!.data),
          allDailyWorkModel: data.data!.dailyWorkModel,
          monthWorkModel: monthlyWork,
          //مناسبات
          allRelationShipModel: allRelationShipModel,
          relationShipData: relationShipData,
          refrenses: data.data!.refrenses));

      return;
    }
    emit(state.copyWith(datastatus: const StateError()));
  }

  DailyWorkModel? filterTodayWork(
      CalendarModel? calendarModel, List<DailyWorkData>? data) {
    DailyWorkModel todaWork =
        DailyWorkModel(dateTime: DateTime.now(), data: []);

    if (calendarModel != null && data != null && data.isNotEmpty) {
      for (var element in data) {
        if (element.type == WorkType.relationship ||
            DateTime.now().hour < element.hour!) {
          continue;
        }

        switch (element.workTiming) {
          case WorkTiming.daily:
            todaWork.data!.add(element);

            break;

          case WorkTiming.dailyInMonth
              when element.month == calendarModel.hijreeMonth:
            todaWork.data!.add(element);
            break;
          case WorkTiming.dayInmonth
              when (element.month == calendarModel.hijreeMonth &&
                  element.day == calendarModel.hijreeDay):
            todaWork.data!.add(element);
            break;
          case WorkTiming.oneWeekDayInMonth
              when (element.month == calendarModel.hijreeMonth &&
                  getLastWeekDayDate(calendarModel, element.weekDay!, 1)):
            todaWork.data!.add(element);
            break;
          case WorkTiming.weekly
              when (DateTime.now().weekday == element.weekDay!.index + 1):
            todaWork.data!.add(element);

            break;
          case WorkTiming.weeklyInMonth
              when (element.month == calendarModel.hijreeMonth &&
                  element.weekDay!.index + 1 == DateTime.now().weekday):
            todaWork.data!.add(element);
            break;
          default:
        }
      }

      return todaWork;
    } else {
      return null;
    }
  }

  void startSchedual(CalendarModel calendarMode) {
    Timer.periodic(const Duration(minutes: 1), (timer) {
      getTodayWorkFromLocal(calendarMode);
    });
  }
}
