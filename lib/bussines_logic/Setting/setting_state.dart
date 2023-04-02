part of 'settings_cubit.dart';

@immutable
abstract class SettingState extends Equatable {
  final SettingInfo setting;

  const SettingState(this.setting);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SettingStateInitial extends SettingState {
  final SettingInfo setting;
  const SettingStateInitial(this.setting) : super(setting);
}

class SettingStateMain extends SettingState {
  final SettingInfo setting;
  const SettingStateMain(this.setting) : super(setting);
}

class SettingStateLoading extends SettingState {
  final SettingInfo setting;
  const SettingStateLoading(this.setting) : super(setting);
}

class SettingStateSecond extends SettingState {
  final SettingInfo setting;
  const SettingStateSecond(this.setting) : super(setting);
}

class SettingInfo {
  late int currentpageIndex;
  late NavPages currentPage;
  late Lang currentLang;
  SettingModel? setting;
  var isBegin = false;
  SettingInfo({
    required this.currentpageIndex,
    required this.currentPage,
    required this.currentLang,
  });

  CityModel? cities;
}
