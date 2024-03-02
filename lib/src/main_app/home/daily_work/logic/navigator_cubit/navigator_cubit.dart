import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigator_state.dart';
part 'navigator_cubit.freezed.dart';

class NavigatorCubit extends Cubit<NavigatorState> {
  NavigatorCubit() : super(NavigatorState.initial());
  changeSelected(int index) {
    log(index.toString());
    emit(state.copyWith(selected: index));
  }
}
