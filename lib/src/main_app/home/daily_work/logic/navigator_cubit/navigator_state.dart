part of 'navigator_cubit.dart';

@freezed
class NavigatorCubitState with _$NavigatorCubitState {
  const factory NavigatorCubitState.initial({@Default(0) int selected}) =
      _Initial;
}
