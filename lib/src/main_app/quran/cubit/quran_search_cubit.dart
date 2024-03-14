import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ramadan/model/quran_model.dart';
import 'package:ramadan/src/core/entity/data_status.dart';

part 'quran_search_state.dart';
part 'quran_search_cubit.freezed.dart';

@singleton
class QuranSearchCubit extends Cubit<QuranSearchState> {
  QuranSearchCubit() : super(const QuranSearchState.initial());

  void changeIsSearch(bool value) {
    emit(state.copyWith(isSearch: value));
  }

  changeDisplayType(SearchType value) {
    emit(state.copyWith(searchType: value));
  }
}
