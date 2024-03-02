part of 'slider_cubit.dart';

@freezed
class SliderState with _$SliderState {
  const factory SliderState.initial(
      {required DataStatus datastatus,
      @Default(0.0) double activeIndex,
      String? displayedPostId,
      DailyPostsModel? postlist,
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? refrenses}) = _Initial;
}
