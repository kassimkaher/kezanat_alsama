import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ramadan/model/quran_juzu_model.dart';
import 'package:ramadan/model/quran_model.dart';
import 'package:ramadan/services/local_db.dart';
import 'package:ramadan/utils/extention.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit() : super(QuranStateInital(QuranData()));

  getQuran() async {
    emit(QuranStateLoading(state.info));
    try {
      final String response =
          await rootBundle.loadString('assets/docs/quran.json');
      final jsondata = await json.decode(response);

      state.info.quranModel = QuranModel.fromJson(jsondata);
      try {
        state.info.cachQuranModel = state.info.quranModel!.data!.surahs;
      } catch (e) {}
      await getContinu();
      getQuranJuzu();
      emit(QuranStateLoaded(state.info));
    } catch (e) {
      print(e);
      emit(QuranStateFiald(state.info));
    }
  }

  search(String value) {
    if (value.isEmpty) {
      resetQuran();

      return;
    }
    state.info.quranModel!.data!.surahs = state.info.cachQuranModel;
    final data = state.info.quranModel?.data?.surahs?.where((sura) => sura.name!
        .replaceAll("َ", "")
        .replaceAll("ً", "")
        .replaceAll("ِ", "")
        .replaceAll("ٍ", "")
        .replaceAll("ُ", "")
        .replaceAll("ٌ", "")
        .replaceAll("ْ", "")
        .replaceAll("ّ", "")
        .replaceAll("ء", "")
        .replaceAll("ٓ", "")
        .replaceAll("أ", "ا")
        .contains(value));

    if (data != null && data.isNotEmpty) {
      state.info.quranModel?.data?.surahs = data.toList();
      refresh();
      print(state.info.quranModel!.data!.surahs!.length);
      print(state.info.cachQuranModel!.length);
      return;
    }
  }

  refresh() {
    emit(QuranStateLoading(state.info));
    emit(QuranStateLoaded(state.info));
  }

  void resetQuran() {
    state.info.quranModel!.data!.surahs = state.info.cachQuranModel;
    refresh();
  }

  Future<void> getContinu() async {
    try {
      final data = LocalDB.getContinu();

      state.info.continuQuranModel = data;
    } catch (e) {
      // kdp(name: "QuranCubit /getContinu", msg: e, c: 'r');
    }
    refresh();
  }

  Future<void> setContinu(
      {required String suraName,
      required int pageNumber,
      required int ayaNumber,
      required int juzuNumber,
      required int number}) async {
    try {
      final continuQuran = ContinuQuranModel(
          pageNumber: pageNumber,
          ayaNumber: ayaNumber,
          number: number,
          nameSura: suraName,
          juzuNumber: juzuNumber);
      state.info.continuQuranModel = continuQuran;

      await LocalDB.setContinu(continuQuran);
      state.info.continuQuranModel = continuQuran;
    } catch (e) {
      print(e);
    }
    refresh();
  }

  void resetScrool() {
    state.info.isScroll = false;
    state.info.currentPage = 0;
    state.info.currentAyaIndex = 0;
    state.info.pageController = PageController(initialPage: 0);
    state.info.currentQuranJuzu = null;

    refresh();
  }

  changeDisplayType(bool value) {
    state.info.isSuraType = value;
    refresh();
  }

  // startReading() async {
  //   bool available = await state.info.speech.initialize(onStatus: (a) {
  //     kdp(name: "speach", msg: a, c: 'm');
  //   }, onError: (error) {
  //     kdp(name: "speach", msg: error, c: 'r');
  //   });
  //   if (available) {
  //     state.info.speech.listen(onResult: (a) {
  //       kdp(name: "speach", msg: a, c: 'gr');
  //     });
  //   } else {
  //     kdp(
  //         name: "speach",
  //         msg: "The user has denied the use of speech recognition.",
  //         c: 'y');
  //   }
  //   // some time later...
  // }

  getQuranJuzu() async {
    for (var i = 1; i < 31; i++) {
      try {
        final String response =
            await rootBundle.loadString('assets/docs/quran/quran_juz$i.json');
        final jsondata = await json.decode(response);

        final juzu = QuranJuzuModel.fromJson(jsondata);
        state.info.quranJuzuList.add(juzu);
      } catch (e) {
        kdp(name: "quran juzu ", msg: "error $e==$i", c: 'r');
      }
    }
    refresh();
  }

  void changePage(int page) {
    state.info.currentAyaIndex = 0;
    state.info.currentPage = page;
    refresh();
  }

  void setPage(int? page) {
    state.info.pageController = PageController(initialPage: page ?? 0);
    state.info.currentPage = page ?? 0;
    refresh();
  }

  void setAyaIndex(int i) {
    state.info.currentAyaIndex = i;
    refresh();
  }

  void nextJuzu(int juzu) {
    state.info.currentPage = 0;
    state.info.currentAyaIndex = 0;

    state.info.currentQuranJuzu = state.info.quranJuzuList[juzu];
    state.info.pageController.jumpToPage(0);

    setContinu(
        suraName: state.info.currentQuranJuzu!.data!.ayahs!.first.surah!.name!,
        juzuNumber: state.info.currentQuranJuzu!.data!.ayahs!.first.juz! - 1,
        pageNumber: 0,
        ayaNumber: 0,
        number: state.info.currentQuranJuzu!.data?.ayahs?.length ?? 0);

    refresh();
  }

  void setCurrentJuzu(QuranJuzuModel quranListJuzua) {
    state.info.currentQuranJuzu = quranListJuzua;

    refresh();
  }

  void previousPage(int juzu) {
    state.info.currentPage =
        (state.info.quranJuzuList[juzu - 2].data?.juzuPages?.length ?? 1) - 1;
    state.info.currentAyaIndex = 0;

    state.info.currentQuranJuzu = state.info.quranJuzuList[juzu - 2];
    state.info.pageController.jumpToPage(state.info.currentPage);

    //   setContinu(
    //       suraName:
    //           state.info.currentQuranJuzu!.data!.ayahs!.first.surah!.name!,
    //       juzuNumber: state.info.currentQuranJuzu!.data!.ayahs!.first.juz! - 1,
    //       pageNumber: 0,
    //       ayaNumber: 0,
    //       number: state.info.currentQuranJuzu!.data?.ayahs?.length ?? 0);
    // }

    refresh();
  }

  void setPlayerState(PlayerState playerState) {
    state.info.playerState = playerState;
    refresh();
  }

  togglePlaye() {
    if (state.info.youtubeController.value.isPlaying) {
      state.info.youtubeController.pause();
    } else {
      state.info.youtubeController.play();
    }
  }
}
