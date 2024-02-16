import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ramadan/services/tasbeeh/entity/model/tasbeeh_model.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:text_to_speech/text_to_speech.dart';

part 'tasbeeh_state.dart';
part 'tasbeeh_cubit.freezed.dart';

class TasbeehCubit extends Cubit<TasbeehState> {
  final TasbeehModel tasbeehModel;
  TasbeehCubit({required this.tasbeehModel})
      : super(const TasbeehState.initial());
  speak(String text) {
    TextToSpeech tts = TextToSpeech();

    tts.speak(text);
  }

  void incrementCount(int index) {
    HapticFeedback.selectionClick();

    AudioPlayer().play(AssetSource('sound/bead.wav'));

    if (state.repetitionNumber ==
        tasbeehModel.tasbeehList[state.index].number) {
      if (tasbeehModel.tasbeehList.length - 1 > state.index) {
        emit(state.copyWith(repetitionNumber: 0, index: state.index + 1));

        // change to next
        return;
      }

//end of tasbeeh

      return;
    }
    emit(state.copyWith(repetitionNumber: index));
  }

  resete() {
    emit(state.copyWith(repetitionNumber: 0, index: 0, count: 0));
  }
}
