part of 'setting_cubit.dart';

@freezed
class SettingState with _$SettingState {
  const factory SettingState.initial(
      {@Default(false) bool isEndEvent,
      @Default(0) int currentpageIndex,
      @Default(Lang.arbic) Lang currentLang,
      SettingModel? setting,
      CitesModel? cities,
      @Default(NavPages.home) NavPages currentPage,
      @Default(DataIdeal()) DataStatus dataStatus}) = _Initial;
}
