import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigator_state.dart';
part 'navigator_cubit.freezed.dart';

class NavigatorCubit extends Cubit<NavigatorCubitState> {
  NavigatorCubit() : super(const NavigatorCubitState.initial());
  changeSelected(int index) {
    emit(state.copyWith(selected: index));
  }
}
