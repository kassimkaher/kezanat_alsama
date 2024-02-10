part of 'navigator_cubit.dart';

@freezed
class NavigatorState with _$NavigatorState {
  const factory NavigatorState.initial({@Default(0) int selected}) = _Initial;
}
