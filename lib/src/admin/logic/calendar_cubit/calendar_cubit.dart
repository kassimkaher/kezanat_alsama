import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ramadan/src/core/data_source/remote.dart';
import 'package:ramadan/src/core/entity/data_state.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/calendar_model.dart';
import 'package:ramadan/utils/utils.dart';

part 'calendar_state.dart';
part 'calendar_cubit.freezed.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(const CalendarState.initial(datastatus: DataIdeal()));
  getCalendar() async {
    emit(state.copyWith(datastatus: const DataLoading()));

    final data = await FireStoreRemote.getCalendarApi();

    if (data is DataSuccess) {
      final today = getCalculation(data.data!);
      emit(state.copyWith(
          datastatus: const DataSucess(),
          calendarModel: data.data,
          today: today));
      return;
    }
    emit(state.copyWith(datastatus: const DataError()));
  }

  getCalculation(CalendarModel calendarModel) {
    try {
      if (calendarModel.meladyMonth == DateTime.now().month &&
          calendarModel.meladyDay == DateTime.now().day) {
        return calendarModel;
      }

      final delta = calendarModel.hijreeDay! - calendarModel.meladyDay!;

      final monthAgo =
          calendarModel.meladyMonth! > DateTime.now().month ? 30 : 0;

      final today = monthAgo + DateTime.now().day + delta;
      // log(delta.toString() + "=====" + monthAgo.toString());
      final todayCalendar = calendarModel;
      todayCalendar.hijreeDay = today;
      return todayCalendar;
    } catch (e) {}
  }

  Future<void> updateCalendar(CalendarModel calendarModel) async {
    emit(state.copyWith(datastatus: const DataLoading()));

    final data = await FireStoreRemote.updateCalendarApi(calendarModel);

    if (data is DataSuccess) {
      final today = getCalculation(calendarModel);
      emit(state.copyWith(
          datastatus: const DataSucess(),
          calendarModel: calendarModel,
          today: today));
      return;
    }
    emit(state.copyWith(datastatus: const DataError()));
  }
}
