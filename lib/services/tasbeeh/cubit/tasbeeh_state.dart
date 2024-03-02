part of 'tasbeeh_cubit.dart';

@freezed
class TasbeehState with _$TasbeehState {
  const factory TasbeehState.initial({
    TasbeehModel? tasbeehModel,
    @Default(0) int count,
    @Default(0) int index,
    @Default(1) int repetitionNumber,
  }) = _Initial;
}
