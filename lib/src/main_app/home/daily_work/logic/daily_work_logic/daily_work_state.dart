part of 'daily_work_cubit.dart';

@freezed
class DailyWorkState with _$DailyWorkState {
  const factory DailyWorkState.initial(
      {@Default(DataStatus.ideal) DataStatus datastatus,
      DailyWorkModel? allDailyWorkModel,
      DailyWorkModel? todayWorkModel,
      DailyWorkModel? monthWorkModel,
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? refrenses}) = _Initial;
}
