import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ramadan/services/tasbeeh/entity/model/tasbeeh_model.dart';
import 'package:ramadan/utils/utils.dart';

part 'tasbeeh_state.dart';
part 'tasbeeh_cubit.freezed.dart';

class TasbeehCubit extends Cubit<TasbeehState> {
  final TasbeehModel tasbeehModel;
  TasbeehCubit({required this.tasbeehModel})
      : super(const TasbeehState.initial());
  // speak(String text) async {
  //   TextToSpeech tts = TextToSpeech();
  //   tts.setVolume(100);
  //   tts.setRate(1);

  //   tts.setLanguage("ar-001");

  //   tts.setPitch(1);

  //   tts.speak(text);
  // }

  void incrementCount(int index) {
    log("continu of tasbeeh");
    emit(state.copyWith(repetitionNumber: index));
    HapticFeedback.heavyImpact();

    AudioPlayer().play(AssetSource('sound/bead.wav'));

    if (state.repetitionNumber ==
        tasbeehModel.tasbeehList[state.index].number) {
      if (tasbeehModel.tasbeehList.length - 1 > state.index) {
        emit(state.copyWith(index: state.index + 1));

        // change to next
        log("change to next");
        return;
      }

//end of tasbeeh
      log("end of tasbeeh");
      return;
    }
    // speak(tasbeehModel.tasbeehList[state.index].speak);
  }

  resete() {
    emit(state.copyWith(repetitionNumber: 0, index: 0, count: 0));
  }
}
