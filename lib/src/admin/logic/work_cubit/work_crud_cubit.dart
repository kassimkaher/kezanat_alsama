import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ramadan/src/core/data_source/remote.dart';
import 'package:ramadan/src/core/entity/data_state.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/core/entity/work_entity.dart';
import 'package:ramadan/src/core/enum/work_timing.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/daily_work_model.dart';

part 'work_crud_state.dart';
part 'work_crud_cubit.freezed.dart';

@Singleton()
class WorkCrudCubit extends Cubit<WorkCrudState> {
  WorkCrudCubit() : super(const WorkCrudState.initial(dataStatus: DataIdeal()));
  submitEvent(DailyWorkData dailyWorkData) async {
    if (dailyWorkData.id != null && dailyWorkData.refrence != null) {
      updateWork(dailyWorkData);
      return;
    }
    addNewWork(dailyWorkData);
  }

  addNewWork(DailyWorkData dailyWorkData) async {
    emit(state.copyWith(dataStatus: const StateLoading()));

    final result = await FireStoreRemote.addWork(dailyWorkData);

    if (result is DataFailed) {
      emit(state.copyWith(dataStatus: const StateError()));
      return;
    }

    dailyWorkData.id = result.data!.id;
    dailyWorkData.refrence = result.data;

    emit(state.copyWith(
        dataStatus: const DataSucessOperation(), dailyWorkData: dailyWorkData));
    emit(state.copyWith(dataStatus: const SateSucess()));
    add(state.dailyWorkData!);
  }

  updateWork(DailyWorkData dailyWorkData) async {
    emit(state.copyWith(dataStatus: StateLoading(data: dailyWorkData.id)));

    final result =
        await FireStoreRemote.updateWork(dailyWorkData: dailyWorkData);

    if (result is DataFailed) {
      emit(state.copyWith(dataStatus: const StateError()));
      return;
    }

    emit(state.copyWith(
        dataStatus: const DataSucessOperation(), dailyWorkData: dailyWorkData));
    emit(state.copyWith(dataStatus: const SateSucess()));
  }

  getWorkData() async {
    emit(state.copyWith(dataStatus: const StateLoading()));

    final data = await FireStoreRemote.getWorkspi();
    if (data is DataSuccess) {
      emit(state.copyWith(
          dataStatus: const SateSucess(),
          worksData: data.data,
          workListModel: data.data?.dailyWorkModel));

      return;
    }
    emit(state.copyWith(dataStatus: const StateError()));
  }

  deletWork(String id) async {
    emit(state.copyWith(dataStatus: StateLoading(data: id)));

    try {
      await state.worksData!.refrenses
          ?.where((element) => element.id == id)
          .first
          .reference
          .delete();

      state.worksData?.dailyWorkModel?.data
          ?.removeWhere((element) => element.id == id);

      emit(state.copyWith(
          dataStatus: const DataSucessOperation(),
          workListModel: state.worksData?.dailyWorkModel));
      emit(state.copyWith(dataStatus: const SateSucess()));
    } catch (e) {
      emit(state.copyWith(dataStatus: const StateError()));
      emit(state.copyWith(dataStatus: const SateSucess()));
    }
  }

  deletRelation(String id) async {
    emit(state.copyWith(dataStatus: StateLoading(data: id)));

    try {
      await state.worksData!.refrenses
          ?.where((element) => element.id == id)
          .first
          .reference
          .delete();
      state.worksData?.dailyWorkModel?.data
          ?.removeWhere((element) => element.id == id);

      emit(state.copyWith(
          dataStatus: const DataSucessOperation(),
          workListModel: state.worksData?.dailyWorkModel));
      emit(state.copyWith(dataStatus: const SateSucess()));
    } catch (e) {
      emit(state.copyWith(dataStatus: const StateError()));
    }
  }

  void add(DailyWorkData dailyWorkData) {
    final index = state.worksData?.dailyWorkModel?.data
            ?.indexWhere((element) => element.id == dailyWorkData.id) ??
        -1;
    if ((state.worksData?.dailyWorkModel?.data?.isEmpty ?? false) ||
        index == -1) {
      state.worksData!.dailyWorkModel!.data!.insert(0, dailyWorkData);
    } else {
      state.worksData?.dailyWorkModel?.data?[index] = dailyWorkData;
    }

    emit(state.copyWith(
        dataStatus: const SateSucess(),
        workListModel: state.worksData?.dailyWorkModel));
    return;
  }

  void filterData(int tab) {
    if (tab == 0) {
      emit(state.copyWith(workListModel: state.worksData?.dailyWorkModel));
      return;
    }

    emit(state.copyWith(
        workListModel: DailyWorkModel(
            data: state.worksData?.dailyWorkModel?.data
                ?.where((element) =>
                    element.workTiming == WorkTiming.values[tab - 1])
                .toList())));
  }
}
