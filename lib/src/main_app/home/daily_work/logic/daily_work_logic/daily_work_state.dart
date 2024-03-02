part of 'daily_work_cubit.dart';

@freezed
class DailyWorkState with _$DailyWorkState {
  const factory DailyWorkState.initial(
      {required DataStatus datastatus,
      DailyWorkModel? allDailyWorkModel,
      DailyWorkModel? allRelationShipModel,
      DailyWorkModel? todayWorkModel,
      DailyWorkModel? monthWorkModel,
      DailyWorkModel? relationShipData,
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? refrenses}) = _Initial;
}
