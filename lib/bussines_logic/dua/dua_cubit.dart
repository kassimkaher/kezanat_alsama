import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:ramadan/model/ramadan_dua.dart';
import 'package:ramadan/model/zyarat_model.dart';

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

  getZyaratMunajat() async {
    emit(DuaStateLoading(state.info));
    try {
      final String response =
          await rootBundle.loadString('assets/docs/zyarat.json');
      final jsondata = await json.decode(response);
      final data = ZyaratMunajatModel.fromJson(jsondata);
      state.info.zyaratData = data;

      refresh();
    } catch (e) {
      print(e);
      emit(DuaStateFiald(state.info));
    }
  }

  refresh() {
    emit(DuaStateLoading(state.info));
    emit(DuaStateLoaded(state.info));
  }

  Future<void> loadContent(
      String? path, Function(String? content) onComplete) async {
    if (path == null) {
      return;
    }
    try {
      final String response =
          await rootBundle.loadString('assets/docs/${path}');
      onComplete(response);
    } catch (e) {
      onComplete(null);
    }
  }
}
