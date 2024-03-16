import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ramadan/model/quran_juzu_model.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/utils/utils.dart';

part 'quran_sound_state.dart';
part 'quran_sound_cubit.freezed.dart';

@injectable
class QuranSoundCubit extends Cubit<QuranSoundState> {
  QuranSoundCubit() : super(const QuranSoundState.initial());
  playAya(int aya) async {
    emit(state.copyWith(
        player: AudioPlayer(), dataStatus: const StateLoading()));

    final file = await loadAudio(aya);

    if (file != null) {
      await state.player!.setSourceDeviceFile(file.path);
      play();
      emit(state.copyWith(
          dataStatus: const SateSucess(),
          playerState: PlayerState.playing,
          duration: (await state.player!.getDuration())?.inSeconds ?? 0));
      state.player!.onPositionChanged.listen(
        (p) {
          if (!state.isChangingCurrentPossition) {
            emit(state.copyWith(currentPossition: p.inSeconds));
          }
        },
      );

      state.player!.onPlayerStateChanged.listen(
        (p) => emit(state.copyWith(playerState: p)),
      );
      return;
    }
    emit(state.copyWith(dataStatus: const StateError()));
    // kdp(name: "playAya", msg: url, c: 'gr');
    // try {
    //   await state.player!.play(UrlSource(url));
    // } catch (_) {
    //   emit(state.copyWith(dataStatus: const StateError()));
    // }
  }

  play() {
    state.player!.resume();
  }

  pause() {
    state.player!.pause();
  }

  rePlay() {
    state.player!.seek(Duration.zero);
  }

  seek(int seconds) {
    if (seconds < 0 && seconds > state.duration) {
      return;
    }
    emit(state.copyWith(isChangingCurrentPossition: false));
    state.player!.seek(
      Duration(seconds: seconds),
    );
  }

  release() async {
    try {
      if (state.player == null) {
        return;
      }
      emit(state.copyWith(dataStatus: const DataIdeal()));
      await state.player!.release();
      emit(state.copyWith(duration: 0, currentPossition: 0));
    } catch (e) {}
  }

  Future<File?> loadAudio(int ayah) async {
    final url =
        'https://cdn.islamic.network/quran/audio/64/ar.abdulbasitmurattal/$ayah.mp3';

    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/quran_ar_abdulbasitmurattal_$ayah.mp3');

    if (await file.exists()) {
      kdp(name: "get file", msg: "from local", c: "gr");
      return file;
    }

    final HttpClient httpClient = HttpClient();
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      await file.create();
      await file.writeAsBytes(bytes);
      return file;
    } catch (e) {
      kdp(name: "get file", msg: e, c: "r");
      return null;
    }
  }

  void toogleSoundWidget(AyahsJuzu? ayahsJuzu) {
    release();
    emit(
        state.copyWith(ayaShow: state.ayaShow == ayahsJuzu ? null : ayahsJuzu));
  }

  void changeSelectAyah(int value) {
    if (value < 0) {
      return;
    }
    emit(state.copyWith(ayahSelected: value));
  }

  void changeCurrentPossition(double v) {
    emit(state.copyWith(
        currentPossition: v.toInt(), isChangingCurrentPossition: true));
  }

  beginSlide() {
    emit(state.copyWith(isChangingCurrentPossition: true));
  }

  readWord(String text, int index) {
    final durationall = state.duration;
    if (durationall < 1) {
      return;
    }
    final letterDuration = durationall / text.length;
    var letterCount = 0;
    final wordList = text.split(" ");
    for (var i = 0; i < wordList.length; i++) {
      if (i >= index) {
        continue;
      }
      letterCount += wordList[i].length;
    }
    play();
    seek((letterCount * letterDuration).toInt());
  }
}
