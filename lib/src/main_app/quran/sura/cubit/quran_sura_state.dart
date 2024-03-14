part of 'quran_sura_cubit.dart';

@freezed
class QuranSuraState with _$QuranSuraState {
  const factory QuranSuraState.initial({
    required DataStatus dataStatus,
    List<SuraModel>? quranModel,
    List<QuranSuraSearchItem>? cachQuranModelForSearch,
  }) = _Initial;
}

class QuranSuraSearchItem {
  SuraModel surahs;
  AyahsJuzu? ayahs;
  QuranSuraSearchItem({required this.surahs, this.ayahs});
}
