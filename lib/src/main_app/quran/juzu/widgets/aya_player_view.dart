import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/model/quran_juzu_model.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/core/widget/jb_button.dart';
import 'package:ramadan/src/main_app/quran/juzu/cubit/quran_juzu_cubit.dart';
import 'package:ramadan/src/main_app/quran/quran_sound/quran_sound_cubit.dart';

import 'package:ramadan/utils/utils.dart';

class AyahPlayerView extends StatelessWidget {
  const AyahPlayerView({
    super.key,
    required this.aya,
    required this.theme,
  });

  final AyahsJuzu aya;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final quranSoundCubit = context.read<QuranSoundCubit>();
    final quranJuzuCubit = context.read<QuranJuzuCubit>();
    return BlocBuilder<QuranSoundCubit, QuranSoundState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ).copyWith(bottom: 16),
          child: Row(
            children: [
              IconButton(
                  onPressed: () => quranSoundCubit.toogleSoundWidget(null),
                  icon: const Icon(LucideIcons.x)),
              const SizedBox(width: 4),
              Text(
                "القارئ عبد الباسط عبد الصمد",
                style: theme.textTheme.titleMedium,
              ),
              const Spacer(),
              switch (state.dataStatus) {
                StateLoading() => const SizedBox(
                    width: 25, height: 25, child: CircularProgressIndicator()),
                SateSucess() => IconButton(
                    onPressed: () => state.playerState == PlayerState.playing
                        ? quranSoundCubit.pause()
                        : state.playerState == PlayerState.paused
                            ? quranSoundCubit.play()
                            : quranSoundCubit.playAya(aya.number ?? 0),
                    icon: Icon(
                      state.playerState == PlayerState.playing
                          ? Icons.pause_circle
                          : state.playerState == PlayerState.paused
                              ? Icons.play_circle_fill_rounded
                              : state.playerState == PlayerState.completed
                                  ? LucideIcons.rotateCcw
                                  : LucideIcons.loader,
                      size: 35,
                    )),
                DataIdeal() => IconButton(
                    onPressed: () => quranSoundCubit.playAya(aya.number ?? 0),
                    icon: const Icon(
                      Icons.play_circle_fill_rounded,
                      size: 35,
                    )),
                _ => IconButton(
                    onPressed: () => quranSoundCubit.playAya(aya.number ?? 0),
                    icon: const Icon(LucideIcons.refreshCcw, color: Colors.red))
              },
              const SizedBox(width: 4),
              JBButton(
                title: "حفظ",
                backgroundColor: Colors.green,
                onPressed: () {
                  quranJuzuCubit.setContinu(
                    juzuIndex: aya.juz! - 1,
                    page: aya.page!,
                    ayahsJuzu: aya,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
