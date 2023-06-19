import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/bussines_logic/Setting/settings_cubit.dart';
import 'package:ramadan/bussines_logic/quran/quran_cubit.dart';
import 'package:ramadan/model/quran_model.dart';
import 'package:ramadan/pages/quran/component.dart';
import 'package:ramadan/utils/color.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class QuranListSuar extends StatelessWidget {
  const QuranListSuar({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        return ListView.separated(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.only(bottom: 100),
          separatorBuilder: (c, i) => Divider(
            indent: 60,
            endIndent: 60,
            height: 2,
            color: theme.scaffoldBackgroundColor,
          ),
          itemCount: state.info.quranModel?.data?.surahs?.length ?? 0,
          itemBuilder: (c, i) => InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();

              Navigator.push(
                  context,
                  to(SuraViewForSuar(
                    data: state.info.quranModel!.data!.surahs![i],
                    index: i,
                  )));
            },
            child: Container(
              color: theme.cardColor,
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: 12),
              child: Row(
                children: [
                  NumberWidget(
                    theme: theme,
                    number: state.info.quranModel!.data!.surahs![i].number
                        .toString(),
                    size: 40,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.info.quranModel!.data!.surahs![i].name!,
                        style: theme.textTheme.titleSmall,
                      ),
                      Text(
                        "${state.info.quranModel!.data!.surahs![i].ayahs!.length} آية  ",
                        style: theme.textTheme.displaySmall,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    LucideIcons.chevronLeft,
                    color: jbSecondary,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SuraViewForSuar extends StatelessWidget {
  const SuraViewForSuar(
      {super.key, required this.data, required this.index, this.ayaIndex});
  final Surahs data;
  final int index;
  final int? ayaIndex;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final query = MediaQuery.of(context);
    final quranController = context.read<QuranCubit>();

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          return Stack(
            children: [
              YoutubePlayer(
                controller: state.info.youtubeController,
                showVideoProgressIndicator: true,
                progressColors: const ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                ),
                onReady: () {
                  state.info.youtubeController.addListener(() {
                    quranController.setPlayerState(
                        state.info.youtubeController.value.playerState);
                  });
                },
              ),
              Scaffold(
                body: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: query.viewPadding.top, bottom: 0),
                      decoration: BoxDecoration(
                          border: Border.all(color: theme.colorScheme.outline),
                          borderRadius:
                              BorderRadius.circular(kDefaultBorderRadius),
                          color: theme.cardColor),
                      child: Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(
                                data.name!,
                                style: theme.textTheme.titleLarge,
                              ),
                              subtitle: Text(
                                "   ${data.ayahs!.length} آية",
                                style: theme.textTheme.displaySmall,
                              ),
                            ),
                          ),
                          // IconButton(
                          //     onPressed: () => quranController.startReading(),
                          //     icon: const Icon(LucideIcons.speaker)),
                          IconButton(
                              onPressed: () {
                                quranController.resetQuran();
                                Navigator.pop(context);
                              },
                              icon: const Icon(LucideIcons.x))
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(
                            bottom: 30, top: kDefaultSpacing),
                        child: Column(children: [
                          index != 0
                              ? Text(
                                  "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
                                  style: theme.textTheme.displayLarge!
                                      .copyWith(fontWeight: FontWeight.w600),
                                )
                              : const SizedBox(),
                          ...data.ayahs!
                              .asMap()
                              .map((i, aya) => MapEntry(
                                    i,
                                    VisibilityDetector(
                                      key: aya.key,
                                      onVisibilityChanged: (a) {},
                                      child: ListTile(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                kDefaultBorderRadius)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 6),
                                        dense: true,
                                        tileColor: aya.sajda != null
                                            ? theme.primaryColor
                                                .withOpacity(0.2)
                                            : Colors.transparent,
                                        title: aya.sajda != null
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal:
                                                            kDefaultPadding),
                                                child: Text(
                                                  aya.sajda!.obligatory == true
                                                      ? "سجدة واجبة"
                                                      : "سجدة مستحبة",
                                                  style: theme
                                                      .textTheme.displaySmall,
                                                ),
                                              )
                                            : null,
                                        subtitle: InkWell(
                                          // onLongPress: () =>
                                          //     quranController.setContinu(
                                          //         suraName: data.name!,
                                          //         juzuNumber: data.ayahs,
                                          //         ayaIndex: i,
                                          //         number: data.ayahs!.length),
                                          child: Container(
                                              alignment: Alignment.centerRight,
                                              // margin: const EdgeInsets.symmetric(
                                              //     vertical: 12),
                                              // padding: const EdgeInsets.symmetric(
                                              //     horizontal: 12),
                                              // decoration: BoxDecoration(
                                              //     borderRadius:
                                              //         BorderRadius.circular(
                                              //             kDefaultBorderRadius),

                                              child: RichText(
                                                textAlign: TextAlign.start,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: i == 0
                                                          ? aya.text
                                                          : aya.text!.replaceFirst(
                                                              "بسم اللَّه الرحمن الرحيم",
                                                              ""),
                                                      style: theme.textTheme
                                                          .displayLarge!
                                                          .copyWith(height: 2),
                                                    ),
                                                    WidgetSpan(
                                                      alignment:
                                                          PlaceholderAlignment
                                                              .middle,
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 5),
                                                        child: Wrap(
                                                          crossAxisAlignment:
                                                              WrapCrossAlignment
                                                                  .center,
                                                          children: [
                                                            NumberWidget(
                                                              theme: theme,
                                                              size: 30,
                                                              number: (i + 1)
                                                                  .toString(),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                              width: 5,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ))
                              .values
                              .toList()
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                left: 30,
                right: 30,
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 300),
                  offset: const Offset(0, 0),
                  child: SizedBox(
                    height: 50,
                    child: Material(
                      elevation: 2,
                      shadowColor:
                          theme.textTheme.titleMedium!.color!.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(30),
                      child: Row(
                        children: [
                          (state.info.playerState?.name ?? "") == "playing" ||
                                  (state.info.playerState?.name ?? "") ==
                                      "paused"
                              ? IconButton(
                                  onPressed: () =>
                                      quranController.togglePlaye(),
                                  icon: (state.info.playerState?.name ?? "") ==
                                          "playing"
                                      ? Lottie.asset(
                                          "assets/lottie/play_pause.json",
                                          repeat: false,
                                          animate:
                                              (state.info.playerState?.name ??
                                                      "") ==
                                                  "playing")
                                      : LottieBuilder.asset(
                                          "assets/lottie/play_pause.json",
                                          repeat: false,
                                          delegates: const LottieDelegates(),
                                          reverse: true)
                                  // : Icon((state.info.playerState?.name ??
                                  //             "") ==
                                  //         "playing"
                                  //     ? LucideIcons.pauseCircle
                                  //     : LucideIcons.playCircle)

                                  )
                              : SizedBox(
                                  height: 29,
                                  width: 29,
                                  child: const CircularProgressIndicator()),
                          Text(state.info.playerState?.name ?? "wait ")
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
