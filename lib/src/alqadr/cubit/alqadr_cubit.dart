import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:ramadan/bussines_logic/Setting/model/setting_model.dart';
import 'package:ramadan/model/alqadr_model.dart';
import 'package:ramadan/services/local_db.dart';

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

  setSalaConter() async {
    HapticFeedback.heavyImpact();
    AudioPlayer().play(AssetSource('sound/tick.MP3'));
    state.alqadrInfo.salatCounterContinus ??= SalatContinus();
    if (state.alqadrInfo.salatCounterContinus!.salaNumber == 50) {
      return;
    }

    state.alqadrInfo.salatCounterContinus!.salaNumber =
        state.alqadrInfo.salatCounterContinus!.salaNumber + 1;
    LocalDB.setSalatCounter(state.alqadrInfo.salatCounterContinus!);
    if (state.alqadrInfo.salatCounterContinus!.salaNumber == 50) {
      HapticFeedback.vibrate();
      AudioPlayer().play(AssetSource('sound/salat.m4a'));
    }
    refresh();
  }

  setSalaDay() async {
    HapticFeedback.heavyImpact();

    state.alqadrInfo.salatDayCountinus ??= SalatContinus();
    if (state.alqadrInfo.salatDayCountinus!.day == 6) {
      return;
    }
    if (state.alqadrInfo.salatDayCountinus!.salaNumber == 5) {
      return;
    }

    state.alqadrInfo.salatDayCountinus!.salaNumber =
        state.alqadrInfo.salatDayCountinus!.salaNumber + 1;

    LocalDB.setSalatDay(state.alqadrInfo.salatDayCountinus!);
    refresh();
    if (state.alqadrInfo.salatDayCountinus!.salaNumber == 5) {
      Future.delayed(const Duration(milliseconds: 1000)).then((value) {
        state.alqadrInfo.salatDayCountinus!.day =
            state.alqadrInfo.salatDayCountinus!.day + 1;
        state.alqadrInfo.salatDayCountinus!.salaNumber = 0;
        LocalDB.setSalatDay(state.alqadrInfo.salatDayCountinus!);
        if (state.alqadrInfo.salatDayCountinus!.day == 6) {
          HapticFeedback.vibrate();
          AudioPlayer().play(AssetSource('sound/salat.m4a'));
        }
        refresh();
      });
    }

    refresh();
  }

  resetSalatDay() {
    state.alqadrInfo.salatDayCountinus!.day = 0;
    state.alqadrInfo.salatDayCountinus!.salaNumber = 0;
    LocalDB.setSalatDay(state.alqadrInfo.salatDayCountinus!);
    refresh();
  }

  resetSalatCounter() {
    state.alqadrInfo.salatCounterContinus!.day = 0;
    state.alqadrInfo.salatCounterContinus!.salaNumber = 0;
    LocalDB.setSalatCounter(state.alqadrInfo.salatCounterContinus!);
    refresh();
  }

  getSala() async {
    try {
      final salaDay = await LocalDB.getSalatDay();
      state.alqadrInfo.salatDayCountinus = salaDay;
    } catch (e) {}

    try {
      final salaCounter = await LocalDB.getSalatCounter();
      state.alqadrInfo.salatCounterContinus = salaCounter;
    } catch (e) {}
    refresh();
  }

  increesTasbeeh(int all, int current) {
    HapticFeedback.heavyImpact();
    state.alqadrInfo.currentTasbeeh ??= TasbeehData(all, current);

    if (state.alqadrInfo.currentTasbeeh!.current ==
        state.alqadrInfo.currentTasbeeh!.all) {
      return;
    }
    state.alqadrInfo.currentTasbeeh!.current = current;

    refresh();
  }

  resetTasbeeh() {
    state.alqadrInfo.currentTasbeeh = null;

    refresh();
  }
}
