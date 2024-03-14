import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/model/quran_juzu_model.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
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
    return BlocBuilder<QuranSoundCubit, QuranSoundState>(
      builder: (context, state) {
        return Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
                color: theme.canvasColor,
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        "القارئ عبد الباسط عبد الصمد",
                        style: theme.textTheme.titleMedium,
                      ),
                      const Spacer(),
                      switch (state.dataStatus) {
                        StateLoading() => const SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator()),
                        SateSucess() => IconButton(
                            onPressed: () => state.playerState ==
                                    PlayerState.playing
                                ? quranSoundCubit.pause()
                                : state.playerState == PlayerState.paused
                                    ? quranSoundCubit.play()
                                    : quranSoundCubit.playAya(aya.number ?? 0),
                            icon: Icon(
                              state.playerState == PlayerState.playing
                                  ? Icons.pause_circle
                                  : state.playerState == PlayerState.paused
                                      ? Icons.play_circle_fill_rounded
                                      : state.playerState ==
                                              PlayerState.completed
                                          ? LucideIcons.rotateCcw
                                          : LucideIcons.loader,
                              size: 35,
                            )),
                        _ => IconButton(
                            onPressed: () =>
                                quranSoundCubit.playAya(aya.number ?? 0),
                            icon: const Icon(LucideIcons.refreshCcw,
                                color: Colors.red))
                      }
                    ],
                  ),
                ),

                SizedBox(
                  height: 25,
                  child: state.dataStatus == const StateError()
                      ? Text(
                          "حدث خطأ في الانترنيت",
                          style: theme.textTheme.bodyLarge!
                              .copyWith(color: Colors.red),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            LinearProgressIndicator(
                              value: state.dataStatus is SateSucess
                                  ? state.currentPossition / state.duration
                                  : 0,
                              backgroundColor: theme.colorScheme.outline,
                            ),
                          ],
                        ),
                )
                /////end
              ],
            )
            // : Wrap(
            //     children: [
            //       switch (state.dataStatus) {
            //         StateLoading() => const CircularProgressIndicator(),
            //         SateSucess() => Column(
            //             children: [
            //               const SizedBox(height: 24),
            //               LinearProgressIndicator(
            //                 value: state.dataStatus is SateSucess
            //                     ? state.currentPossition / state.duration
            //                     : 0,
            //                 backgroundColor: theme.colorScheme.outline,
            //               ),
            //               const SizedBox(height: 12),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                 children: [
            //                   IconButton(
            //                       onPressed: () => quranSoundCubit
            //                           .seek(state.currentPossition + 10),
            //                       icon: const Icon(LucideIcons.fastForward)),
            //                   IconButton(
            //                       onPressed: () =>
            //                           state.playerState == PlayerState.playing
            //                               ? quranSoundCubit.pause()
            //                               : state.playerState ==
            //                                       PlayerState.paused
            //                                   ? quranSoundCubit.play()
            //                                   : quranSoundCubit
            //                                       .playAya(aya.number ?? 0),
            //                       icon: Icon(
            //                         state.playerState == PlayerState.playing
            //                             ? LucideIcons.pauseCircle
            //                             : state.playerState ==
            //                                     PlayerState.paused
            //                                 ? LucideIcons.playCircle
            //                                 : state.playerState ==
            //                                         PlayerState.completed
            //                                     ? LucideIcons.rotateCcw
            //                                     : LucideIcons.loader,
            //                         size: 30,
            //                       )),
            //                   IconButton(
            //                       onPressed: () => quranSoundCubit
            //                           .seek(state.currentPossition - 10),
            //                       icon: const Icon(LucideIcons.rewind))
            //                 ],
            //               )
            //             ],
            //           ),
            //         _ => Center(
            //             child: Column(
            //               children: [
            //                 Text(
            //                   "حدث خطأ في الانترنيت",
            //                   style: theme.textTheme.bodyLarge!
            //                       .copyWith(color: Colors.red),
            //                 ),
            //                 IconButton(
            //                     onPressed: () =>
            //                         quranSoundCubit.playAya(aya.number ?? 0),
            //                     icon: const Icon(LucideIcons.refreshCcw,
            //                         color: Colors.red))
            //               ],
            //             ),
            //           )
            //       }
            //     ],
            //   ),
            );
      },
    );
  }
}
