part of 'quran_cubit.dart';

abstract class QuranState extends Equatable {
  final QuranData info;
  const QuranState(this.info);

  @override
  List<Object> get props => [info];
}

class QuranStateInital extends QuranState {
  const QuranStateInital(super.info);
}

class QuranStateLoaded extends QuranState {
  const QuranStateLoaded(super.info);
}

class QuranStateLoading extends QuranState {
  const QuranStateLoading(super.info);
}

class QuranStateFiald extends QuranState {
  const QuranStateFiald(super.info);
}

class QuranData {
  ContinuQuranModel? continuQuranModel;
  QuranModel? quranModel;
  List<Surahs>? cachQuranModel;
  var isScroll = false;
  QuranData();

  var documentExpanded = false;
}
