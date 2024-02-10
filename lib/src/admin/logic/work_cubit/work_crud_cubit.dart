import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ramadan/src/core/data_source/remote.dart';
import 'package:ramadan/src/core/entity/data_state.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/daily_work_model.dart';

part 'work_crud_state.dart';
part 'work_crud_cubit.freezed.dart';

class WorkCrudCubit extends Cubit<WorkCrudState> {
  WorkCrudCubit() : super(const WorkCrudState.initial());
  addWork(DailyWorkData dailyWorkData) async {
    emit(state.copyWith(dataStatus: DataStatus.loading));

    final result = await FireStoreRemote.addWork(dailyWorkData);

    if (result is DataFailed) {
      emit(state.copyWith(dataStatus: DataStatus.error));
      return;
    }

    emit(state.copyWith(
        dataStatus: DataStatus.success, dailyWorkData: dailyWorkData));
  }
}
