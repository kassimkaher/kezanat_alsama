part of 'settings_cubit.dart';

@immutable
abstract class NavigationState extends Equatable {
  final SettingInfo setting;

  const NavigationState(this.setting);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SettingStateMain extends NavigationState {
  final SettingInfo setting;
  const SettingStateMain(this.setting) : super(setting);
}

class SettingStateSecond extends NavigationState {
  final SettingInfo setting;
  const SettingStateSecond(this.setting) : super(setting);
}

class SettingInfo {
  late bool menuKey;
  late int currentpageIndex;
  late NavPages currentPage;
  late Lang currentLang;
  late List<FocusNode> nodes;
  bool isSetNotification = false;

  SettingInfo(
      {required this.menuKey,
      required this.currentpageIndex,
      required this.currentPage,
      required this.currentLang,
      required this.nodes});
}
