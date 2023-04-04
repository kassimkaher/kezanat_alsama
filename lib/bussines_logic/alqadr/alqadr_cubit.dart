import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:ramadan/model/alqadr_model.dart';

part 'alqadr_state.dart';

class AlqadrCubit extends Cubit<AlqadrState> {
  AlqadrCubit() : super(AlqadrStateInitial(AlqadrInfo()));

  refresh() {
    if (state is AlqadrStateInitial) {
      emit(AlqadrStateMain(state.alqadrInfo));
      return;
    }
    if (state is AlqadrStateMain) {
      emit(AlqadrStateSecond(state.alqadrInfo));
      emit(AlqadrStateMain(state.alqadrInfo));
      return;
    }
    if (state is AlqadrStateLoading) {
      emit(AlqadrStateSecond(state.alqadrInfo));
      emit(AlqadrStateLoading(state.alqadrInfo));
      return;
    }
  }

  getData() async {
    emit(AlqadrStateLoading(state.alqadrInfo));
    try {
      final String response =
          await rootBundle.loadString('assets/docs/alqadr.json');
      final jsondata = await json.decode(response);
      state.alqadrInfo.alqadrModel = AlqadrModel.fromJson(jsondata);
      state.alqadrInfo.selectDayDetails = state.alqadrInfo.alqadrModel?.day19;
      emit(AlqadrStateMain(state.alqadrInfo));
    } catch (e) {
      print(e);
    }
  }

  setDay(int day) {
    state.alqadrInfo.selectDay = day;
    state.alqadrInfo.selectDayDetails = day == 0
        ? state.alqadrInfo.alqadrModel?.day19
        : day == 1
            ? state.alqadrInfo.alqadrModel?.day21
            : state.alqadrInfo.alqadrModel?.day23;
    refresh();
  }

  setCardExpand(int cardIndex) {
    state.alqadrInfo.cardIndex = cardIndex;

    refresh();
  }
}
