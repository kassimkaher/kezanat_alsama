import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:ramadan/model/ramadan_dua.dart';

part 'dua_state.dart';

class DuaCubit extends Cubit<DuaState> {
  DuaCubit() : super(DuaStateInital(DuaData()));

  getMufatehALgynan() async {
    emit(DuaStateLoading(state.info));
    try {
      final String response =
          await rootBundle.loadString('assets/docs/dua.json');
      final jsondata = await json.decode(response);
      state.info.ramadanDuaModel = RamadanDuaModel.fromJson(jsondata);

      emit(DuaStateLoaded(state.info));
    } catch (e) {
      print(e);
      emit(DuaStateFiald(state.info));
    }
  }

  refresh() {
    emit(DuaStateLoading(state.info));
    emit(DuaStateLoaded(state.info));
  }

  Future<void> loadData(Dua data, int index) async {
    if (data.path == null) {
      return;
    }
    try {
      final String response =
          await rootBundle.loadString('assets/docs/${data.path}');

      state.info.ramadanDuaModel!.dua![index].text = response;

      refresh();
    } catch (e) {
      print(e);
      refresh();
    }
  }
}
