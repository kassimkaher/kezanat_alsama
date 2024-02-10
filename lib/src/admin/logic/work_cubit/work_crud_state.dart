part of 'work_crud_cubit.dart';

@freezed
class WorkCrudState with _$WorkCrudState {
  const factory WorkCrudState.initial(
      {@Default(DataStatus.ideal) DataStatus dataStatus,
      DailyWorkData? dailyWorkData}) = _Initial;
}
