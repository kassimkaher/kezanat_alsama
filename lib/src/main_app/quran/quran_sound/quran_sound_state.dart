part of 'quran_sound_cubit.dart';

@freezed
class QuranSoundState with _$QuranSoundState {
  const factory QuranSoundState.initial(
      {@Default(DataIdeal()) DataStatus dataStatus,
      AudioPlayer? player,
      @Default(0) int duration,
      @Default(0) int currentPossition,
      @Default(PlayerState.disposed) PlayerState playerState,
      AyahsJuzu? ayaShow,
      @Default(0) int ayahSelected}) = _Initial;
}
