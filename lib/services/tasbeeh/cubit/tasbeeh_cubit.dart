import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ramadan/services/tasbeeh/entity/model/tasbeeh_model.dart';
import 'package:ramadan/src/core/resources/local_db.dart';
import 'package:ramadan/utils/utils.dart';

part 'tasbeeh_state.dart';
part 'tasbeeh_cubit.freezed.dart';

class TasbeehCubit extends Cubit<TasbeehState> {
  final TasbeehModel tasbeehModel;
  TasbeehCubit({required this.tasbeehModel})
      : super(const TasbeehState.initial());

  Future<void> incrementCount(int index) async {
    if (tasbeehModel.tasbeehList.isEmpty) {
      incrementOpenTasbeeh(index);

      AssetsAudioPlayer.newPlayer().open(
        Audio("assets/sound/bead.wav"),
        autoStart: true,
      );

      HapticFeedback.heavyImpact();
      return;
    }

    emit(state.copyWith(repetitionNumber: index));
    LocalDB.setTasbeehCache(
        TasbeehLocalModel(tasbeehModel: tasbeehModel, repetitionNumber: index));

    HapticFeedback.heavyImpact();

    AssetsAudioPlayer.newPlayer().open(
      Audio("assets/sound/bead.wav"),
      autoStart: true,
    );

    emit(state.copyWith(index: getRangeIndex()));
    if (state.repetitionNumber - 1 ==
        getExactlyNumber(tasbeehModel.tasbeehList.length - 1)) {
//end of tasbeeh
      HapticFeedback.vibrate();

      emit(state.copyWith(repetitionNumber: 1, index: 0));
      LocalDB.setTasbeehCache(
          TasbeehLocalModel(tasbeehModel: tasbeehModel, repetitionNumber: 0));
    }

    return;

    // speak(tasbeehModel.tasbeehList[state.index].speak);
  }

  int getRangeIndex() {
    for (var i = 0; i < tasbeehModel.tasbeehList.length; i++) {
      if (state.repetitionNumber <= getExactlyNumber(i)) {
        return i;
      }
    }

    return 0;
  }

  int getExactlyNumber(int index) {
    int count = tasbeehModel.tasbeehList[index].number + index;

    for (var i = 0; i < index; i++) {
      count += tasbeehModel.tasbeehList[i].number;
    }

    return count;
  }

  resete() {
    emit(state.copyWith(repetitionNumber: 0, index: 0, count: 0));
  }

  void incrementOpenTasbeeh(int index) {
    if (state.repetitionNumber == 101) {
      emit(state.copyWith(repetitionNumber: 1, index: 0, count: 0));
      LocalDB.setTasbeehCache(
          TasbeehLocalModel(tasbeehModel: tasbeehModel, repetitionNumber: 0));
      return;
    }
    emit(state.copyWith(repetitionNumber: index));
    LocalDB.setTasbeehCache(
        TasbeehLocalModel(tasbeehModel: tasbeehModel, repetitionNumber: index));
  }

  checkIfThereIsLocalContinue() {
    final oldData = LocalDB.getTasbeehCache();
    if (oldData != null &&
        tasbeehModel.tasbeehList.isEmpty &&
        oldData.tasbeehModel.tasbeehList.isEmpty) {
      emit(state.copyWith(repetitionNumber: oldData.repetitionNumber));
      return;
    }
    if (oldData == null ||
        tasbeehModel.tasbeehList.isEmpty ||
        oldData.tasbeehModel.tasbeehList.isEmpty) {
      return;
    }
    for (var i = 0; i < oldData.tasbeehModel.tasbeehList.length; i++) {
      if (!oldData.tasbeehModel.tasbeehList[i]
          .isEqual(tasbeehModel.tasbeehList[i])) {
        return;
      }
    }
    emit(state.copyWith(repetitionNumber: oldData.repetitionNumber));
  }
}
