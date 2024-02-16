part of 'alqadr_cubit.dart';

@immutable
abstract class AlqadrState extends Equatable {
  final AlqadrInfo alqadrInfo;

  const AlqadrState(this.alqadrInfo);
  @override
  List<Object?> get props => [];
}

class AlqadrStateInitial extends AlqadrState {
  final AlqadrInfo alqadrInfo;
  const AlqadrStateInitial(this.alqadrInfo) : super(alqadrInfo);
}

class AlqadrStateMain extends AlqadrState {
  final AlqadrInfo alqadrInfo;
  const AlqadrStateMain(this.alqadrInfo) : super(alqadrInfo);
}

class AlqadrStateLoading extends AlqadrState {
  final AlqadrInfo alqadrInfo;
  const AlqadrStateLoading(this.alqadrInfo) : super(alqadrInfo);
}

class AlqadrStateSecond extends AlqadrState {
  final AlqadrInfo alqadrInfo;
  const AlqadrStateSecond(this.alqadrInfo) : super(alqadrInfo);
}

class AlqadrInfo {
  int selectDay = 0;
  DayDetails? selectDayDetails;
  AlqadrModel? alqadrModel;
  SalatContinus? salatDayCountinus;
  SalatContinus? salatCounterContinus;

  int cardIndex = -1;
  TasbeehDataOld? currentTasbeeh;
}

class TasbeehDataOld {
  int all;
  int current;
  TasbeehDataOld(this.all, this.current);
}
