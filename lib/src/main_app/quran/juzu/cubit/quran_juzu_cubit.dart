import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ramadan/src/main_app/quran/data/model/quran_juzu_model.dart';
import 'package:ramadan/src/main_app/quran/data/model/quran_model.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/core/resources/local_db.dart';
import 'package:ramadan/src/main_app/quran/sura/cubit/quran_sura_cubit.dart';
import 'package:ramadan/utils/utils.dart';

part 'quran_juzu_state.dart';
part 'quran_juzu_cubit.freezed.dart';

@singleton
class QuranJuzuCubit extends Cubit<QuranJuzuState> {
  QuranJuzuCubit()
      : super(QuranJuzuState.initial(
            pageController: PageController(), dataStatus: const DataIdeal()));
  void resetScrool() => emit(state.copyWith(
      currentPage: 0,
      currentAyaIndex: 0,
      pageController: PageController(initialPage: 0),
      currentQuranJuzu: null,
      isScroll: false));

  getQuranJuzuData() async {
    emit(state.copyWith(dataStatus: const StateLoading()));

    final quranJuzu = await getQuranData();
    navigatorKey.currentContext!
        .read<QuranSuraCubit>()
        .getQuranEvent(quranJuzu);
    emit(state.copyWith(
        quranJuzuList: quranJuzu, dataStatus: const SateSucess()));
    fillCache();
    await getContinu();
  }

  searchInJuzu(String value) {
    if (value.isEmpty) {
      fillCache();
      return;
    }

    List<QuranJuzuSearchItem> listsearch = [];
    for (var element in state.quranJuzuList) {
      try {
        final ayahResult = element.data?.ayahs?.firstWhere((sura) {
          try {
            final normalize = normalise(sura.text!);

            if (normalize.contains(value)) {
//               kdp(
//                   name: "searchInJuzu",
//                   msg: '''
// sura page =${sura.surah!.name}
// sura page =${sura.page}
// sura juzu =${sura.juz}
// sura number =${sura.number}
// result=${sura.text}
// ''',
//                   c: 'm');
              return true;
            }
            return false;
          } catch (e) {
            return false;
          }
        });

        if (ayahResult != null) {
          listsearch.add(QuranJuzuSearchItem(
              juzuModel: element,
              ayahs: ayahResult,
              ayaIndex: element.data?.ayahs?.indexOf(ayahResult)));
        }
      } catch (_) {}
    }

    if (listsearch.isNotEmpty) {
      emit(state.copyWith(quranjuzuSearch: listsearch));
    }
  }

  void fillCache() {
    emit(state.copyWith(
        quranjuzuSearch: state.quranJuzuList
            .map((e) => QuranJuzuSearchItem(juzuModel: e))
            .toList()));
  }

  void changePage(int page) =>
      emit(state.copyWith(currentPage: page, currentAyaIndex: 0));

  void setPage(int? page) => emit(state.copyWith(
      pageController: PageController(
        initialPage: page ?? 0,
      ),
      currentPage: page ?? 0));

  void setAyaIndex(int i) {
    emit(state.copyWith(currentAyaIndex: i));
  }

  void nextJuzu(int juzu) {
    setContinu(
      juzuIndex: state.currentQuranJuzu!.data!.ayahs!.first.juz!,
      page: state.quranJuzuList[state.currentQuranJuzu!.data!.ayahs!.first.juz!]
          .data!.juzuPages.first.ayahs!.first.page!,
      ayahsJuzu: state
          .quranJuzuList[state.currentQuranJuzu!.data!.ayahs!.first.juz!]
          .data!
          .juzuPages
          .first
          .ayahs!
          .first,
    );

    emit(state.copyWith(
        currentPage: 0,
        currentAyaIndex: 0,
        currentQuranJuzu: state.quranJuzuList[juzu]));

    state.pageController.jumpToPage(0);
  }

  void iniCurrentJuzu(QuranJuzuSearchItem quranListJuzua) {
    emit(state.copyWith(currentQuranJuzu: quranListJuzua.juzuModel));
    if (quranListJuzua.ayahs != null) {
      final indexOfPage = quranListJuzua.juzuModel.data!.juzuPages.indexWhere(
          (element) => element.realPageNumber == quranListJuzua.ayahs!.page);
      final indexOfAya = quranListJuzua
          .juzuModel.data!.juzuPages[indexOfPage].ayahs!
          .indexOf(quranListJuzua.ayahs!);

      setPage(indexOfPage);
      setAyaIndex(indexOfAya);
      return;
    }

    if (state.continuQuranModel != null &&
        state.continuQuranModel!.juzuNumber ==
            (quranListJuzua.juzuModel.data!.ayahs!.first.juz! - 1)) {
      setPage(state.continuQuranModel!
          .pageIndex(quranListJuzua.juzuModel.data!.juzuPages));

      setAyaIndex(state.continuQuranModel
              ?.ayaIndex(quranListJuzua.juzuModel.data!.juzuPages) ??
          0);
      return;
    }
    setAyaIndex(0);
  }

  void previousPage(int juzu) {
    emit(state.copyWith(
        currentPage:
            (state.quranJuzuList[juzu - 2].data?.juzuPages.length ?? 1) - 1,
        currentAyaIndex: 0,
        currentQuranJuzu: state.quranJuzuList[juzu - 2]));
    state.pageController.jumpToPage(state.currentPage);
  }

  Future<void> setContinu({
    required int page,
    required AyahsJuzu ayahsJuzu,
    required int juzuIndex,
  }) async {
    try {
      final continuQuran = ContinuQuranModel(
          page: page,
          ayaNumber: ayahsJuzu.number,
          nameSura: ayahsJuzu.surah?.name,
          juzuNumber: juzuIndex);

      await LocalDB.setContinu(continuQuran);

      emit(state.copyWith(
          continuQuranModel: continuQuran,
          currentAyaIndex: continuQuran.ayaNumber));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getContinu() async {
    try {
      final data = LocalDB.getContinu();
      emit(state.copyWith(
          continuQuranModel: data, currentAyaIndex: data?.ayaNumber ?? 0));
    } catch (e) {
      // kdp(name: "QuranCubit /getContinu", msg: e, c: 'r');
    }
  }

  Future<List<QuranJuzuModel>> getQuranData() async {
    final localCache = LocalDB.getQuranJuzu();
    if (localCache != null && localCache.isNotEmpty) {
      return localCache;
    }
    List<QuranJuzuModel> quranJuzu = [];
    for (var i = 1; i < 31; i++) {
      try {
        final String response =
            await rootBundle.loadString('assets/docs/quran/quran_juz$i.json');
        final jsondata = await json.decode(response);

        final juzu = QuranJuzuModel.fromJson(jsondata);

        quranJuzu.add(juzu);
      } catch (e) {
        kdp(name: "quran juzu ", msg: "error $e==$i", c: 'r');
        emit(state.copyWith(dataStatus: const StateError()));
      }
    }
    LocalDB.saveQuranJuzu(quranJuzu);
    return quranJuzu;
  }
}
