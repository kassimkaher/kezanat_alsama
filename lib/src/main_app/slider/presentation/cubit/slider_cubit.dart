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
      emit(state.copyWith(datastatus: DataStatus.success, postlist: data.data));
      return;
    }
    emit(state.copyWith(datastatus: DataStatus.error));
  }
}
