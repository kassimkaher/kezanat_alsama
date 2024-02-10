part of 'slider_cubit.dart';

@freezed
class SliderState with _$SliderState {
  const factory SliderState.initial(
      {@Default(DataStatus.ideal) DataStatus datastatus,
      DailyPostsModel? postlist,
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? refrenses}) = _Initial;
}
