import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:ramadan/model/quran_model.dart';
import 'package:ramadan/services/local_db.dart';

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
      getContinu();
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
    print("okndj");
    try {
      final data = LocalDB.getContinu();

      state.info.continuQuranModel = data;
    } catch (e) {
      print(e);
    }
    refresh();
  }

  Future<void> setContinu(
      {required String suraName,
      required int suraIndex,
      required int ayaIndex,
      required int number}) async {
    try {
      final continuQuran = ContinuQuranModel(
          suara: suraIndex, aya: ayaIndex, number: number, nameSura: suraName);
      state.info.continuQuranModel = continuQuran;

      final data = await LocalDB.setContinu(continuQuran);
      state.info.continuQuranModel = continuQuran;
    } catch (e) {
      print(e);
    }
    refresh();
  }

  void resetScrool() {
    state.info.isScroll = false;
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
}
