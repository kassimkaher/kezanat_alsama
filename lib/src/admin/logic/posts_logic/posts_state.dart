part of 'posts_cubit.dart';

@freezed
class PostsCRUDState with _$PostsCRUDState {
  const factory PostsCRUDState.initial(
      {required DataStatus datastatus,
      DailyPostsModel? dailyPostsModel,
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? refrenses}) = _Initial;
}
