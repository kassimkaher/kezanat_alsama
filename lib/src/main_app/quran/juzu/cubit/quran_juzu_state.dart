part of 'quran_juzu_cubit.dart';

@freezed
class QuranJuzuState with _$QuranJuzuState {
  const factory QuranJuzuState.initial(
      {required DataStatus dataStatus,
      required PageController pageController,
      int? currentAyaIndex,
      QuranJuzuModel? currentQuranJuzu,
      @Default([]) List<QuranJuzuModel> quranJuzuList,
      @Default(0) int currentPage,
      ContinuQuranModel? continuQuranModel,
      @Default(false) bool isScroll,
      List<QuranJuzuSearchItem>? quranjuzuSearch}) = _Initial;
}

class QuranJuzuSearchItem {
  int? ayaIndex;
  int? page;

  AyahsJuzu? ayahs;
  QuranJuzuModel juzuModel;
  QuranJuzuSearchItem(
      {required this.juzuModel, this.ayahs, this.ayaIndex, this.page});
}
