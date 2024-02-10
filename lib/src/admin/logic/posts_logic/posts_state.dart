part of 'posts_cubit.dart';

@freezed
class PostsCRUDState with _$PostsCRUDState {
  const factory PostsCRUDState.initial(
      {@Default(DataStatus.ideal) DataStatus datastatus,
      DailyPostsModel? dailyPostsModel,
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? refrenses}) = _Initial;
}
