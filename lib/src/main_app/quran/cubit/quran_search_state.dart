part of 'quran_search_cubit.dart';

@freezed
class QuranSearchState with _$QuranSearchState {
  const factory QuranSearchState.initial({
    DataStatus? dataStatus,
    QuranModel? quranModel,
    // @Default(false) bool isSearch,
    @Default(SearchType.sura) SearchType searchType,
  }) = _Initial;
}

enum SearchType { juzu, sura }
