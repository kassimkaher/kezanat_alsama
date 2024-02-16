import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ramadan/src/core/data_source/remote.dart';
import 'package:ramadan/src/core/entity/data_state.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/main_app/slider/data/model/slider_model.dart';

part 'slider_state.dart';
part 'slider_cubit.freezed.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(SliderState.initial());
  getSliders() async {
    emit(state.copyWith(datastatus: DataStatus.loading));

    final data = await FireStoreRemote.getPostsApi();
    if (data is DataSuccess) {
      emit(state.copyWith(
          datastatus: DataStatus.success,
          postlist: data.data,
          displayedPostId: data.data?.data?.first.id));
      Future.delayed(const Duration(seconds: 5))
          .then((value) => changeActiveIndex(1));
      return;
    }
    emit(state.copyWith(datastatus: DataStatus.error));
  }

  changeActiveIndex(int index) {
    if (index >= state.postlist!.data!.length) {
      emit(state.copyWith(activeIndex: 0));

      return;
    }

    emit(state.copyWith(activeIndex: index));
  }
}
