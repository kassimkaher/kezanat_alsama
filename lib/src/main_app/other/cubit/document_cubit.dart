import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ramadan/model/ramadan_dua.dart';
import 'package:ramadan/src/core/entity/works_document_model.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/core/enum/work_type.dart';
import 'package:ramadan/utils/utils.dart';

part 'document_state.dart';
part 'document_cubit.freezed.dart';

class DocumentCubit extends Cubit<DocumentState> {
  DocumentCubit() : super(const DocumentState.initial(dataStatus: DataIdeal()));

  getWorksDocumentModel() async {
    emit(state.copyWith(dataStatus: const StateLoading()));
    try {
      final String response =
          await rootBundle.loadString('assets/docs/mufateh_aljynan.json');
      final jsondata = await json.decode(response);
      final data = WorksDocumentModel.fromJson(jsondata);
      emit(state.copyWith(
          dataStatus: const SateSucess(),
          zyaratData: data,
          casheZyarat: data.zyaratList,
          casheDua: data.dua,
          casheMunajat: data.munajatList));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(dataStatus: const StateError()));
    }
  }

  changeWorkType(WorkType workType) {
    emit(state.copyWith(workType: workType));
  }

  void searchZyarat(String a) {
    final searchedData = state.zyaratData?.zyaratList
        ?.where((element) => element.title!.contains(a))
        .toList();

    emit(state.copyWith(casheZyarat: searchedData));
  }

  void searchMunajat(String a) {
    final searchedData = state.zyaratData?.munajatList
        ?.where((element) => element.title!.contains(a))
        .toList();

    emit(state.copyWith(casheMunajat: searchedData));
  }

  void clearSearch() {
    emit(state.copyWith(
        casheMunajat: state.zyaratData?.munajatList,
        casheZyarat: state.zyaratData?.zyaratList));
  }
}
