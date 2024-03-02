import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ramadan/src/admin/data/remote.dart';
import 'package:ramadan/src/core/entity/data_state.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/main_app/slider/data/model/slider_model.dart';

part 'posts_state.dart';
part 'posts_cubit.freezed.dart';

class PostsCRUDCubit extends Cubit<PostsCRUDState> {
  PostsCRUDCubit() : super(PostsCRUDState.initial(datastatus: DataIdeal()));

  getPosts() async {
    emit(state.copyWith(datastatus: const DataLoading()));

    final data = await FirestorePost.getPostsApi();
    if (data is DataSuccess) {
      emit(
        state.copyWith(
            datastatus: const DataSucess(),
            dailyPostsModel: data.data!.dailyPostsModel,
            refrenses: data.data!.refrenses),
      );
      return;
    }
    emit(state.copyWith(datastatus: const DataError()));
  }

  addPost(DailyPostData dailyPostData) async {
    emit(state.copyWith(datastatus: const DataLoading()));
    final result = await FirestorePost.addPost(dailyPostData);

    if (result is DataFailed) {
      emit(state.copyWith(datastatus: const DataError()));
      return;
    }

    emit(state.copyWith(datastatus: const DataSucess()));
  }

  deletWork(String id) async {
    emit(state.copyWith(datastatus: const DataLoading()));

    try {
      await state.refrenses
          ?.where((element) => element.id == id)
          .first
          .reference
          .delete();
      final posts = state.dailyPostsModel!;

      posts.data!.removeWhere((element) => element.id == id);

      emit(state.copyWith(
          datastatus: const DataSucess(), dailyPostsModel: posts));
    } catch (e) {
      emit(state.copyWith(datastatus: const DataError()));
    }
  }
}
