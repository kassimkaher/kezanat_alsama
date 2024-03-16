part of 'work_crud_cubit.dart';

@freezed
class WorkCrudState with _$WorkCrudState {
  const factory WorkCrudState.initial(
      {required DataStatus dataStatus,
      DailyWorkData? dailyWorkData,
      WorkEntity? worksData,
      DailyWorkModel? workListModel,
      MufatehAljynanModel? mufatehAljynanModel}) = _Initial;
}
