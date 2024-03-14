import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/src/main_app/quran/juzu/cubit/quran_juzu_cubit.dart';
import 'package:ramadan/src/main_app/quran/juzu/widgets/aya_juzu_widget.dart';
import 'package:ramadan/src/main_app/quran/juzu/widgets/bottom_controlls.dart';
import 'package:ramadan/src/main_app/quran/quran_sound/quran_sound_cubit.dart';
import 'package:ramadan/utils/injector.dart';
import 'package:ramadan/utils/utils.dart';

class SuraViewForJuzu extends StatefulWidget {
  const SuraViewForJuzu({super.key, required this.quranListJuzua});
  final QuranJuzuSearchItem quranListJuzua;

  @override
  State<SuraViewForJuzu> createState() => _SuraViewForJuzuState();
}

class _SuraViewForJuzuState extends State<SuraViewForJuzu> {
  late QuranJuzuCubit quranJuzuCubit;
  late QuranSoundCubit quranSoundCubit;

  int selectedAyah = 0;
  late ScrollController scrollController;
  bool isSoundShow = false;

  @override
  void initState() {
    super.initState();
    quranJuzuCubit = context.read<QuranJuzuCubit>();
    quranSoundCubit = getIt<QuranSoundCubit>();
    scrollController = ScrollController();
    quranJuzuCubit.iniCurrentJuzu(widget.quranListJuzua);
    scrollController.addListener(() {
      setState(() {
        isSoundShow = false;
      });
    });
    try {
      Future.delayed(const Duration(milliseconds: 200)).then((value) =>
          Scrollable.ensureVisible(
              widget
                  .quranListJuzua
                  .juzuModel
                  .data!
                  .juzuPages[quranJuzuCubit.state.currentPage]
                  .ayahs![quranJuzuCubit.state.currentAyaIndex ?? 0]
                  .key
                  .currentContext!,
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear));
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        quranJuzuCubit.resetScrool();
        return true;
      },
      child: BlocBuilder<QuranJuzuCubit, QuranJuzuState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child:
                  // isSoundShow
                  //     ? BlocProvider.value(
                  //         value: quranSoundCubit,
                  //         child: AyahPlayerView(
                  //             aya: widget
                  //                 .quranListJuzua
                  //                 .juzuModel
                  //                 .data!
                  //                 .juzuPages[quranJuzuCubit.state.currentPage]
                  //                 .ayahs![selectedAyah],
                  //             theme: theme),
                  //       )
                  //     :
                  state.currentQuranJuzu == null
                      ? const SizedBox()
                      : const BottomControllers(),
            ),
            appBar: AppBar(
              flexibleSpace: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListTile(
                          title:
                              "الجزء ${juzuArray[(state.currentQuranJuzu?.data?.ayahs?.first.juz ?? 1) - 1]}"
                                  .toGradiant(
                            style: theme.textTheme.displayLarge!,
                            colors: [
                              theme.primaryColor,
                              theme.textTheme.titleLarge!.color!
                            ],
                          ),
                        ),
                      ),
                      Text(
                        state.currentAyaIndex != null &&
                                state.currentQuranJuzu != null &&
                                state.currentQuranJuzu!.data!
                                    .juzuPages[state.currentPage].ayahs!
                                    .asMap()
                                    .containsKey(state.currentAyaIndex)
                            ? state
                                .currentQuranJuzu!
                                .data!
                                .juzuPages[state.currentPage]
                                .ayahs![state.currentAyaIndex!]
                                .surah!
                                .name!
                            : "",
                        style: theme.textTheme.displayLarge!
                            .copyWith(fontSize: 20, color: theme.disabledColor),
                      ),
                      IconButton(
                          onPressed: () {
                            quranJuzuCubit.resetScrool();
                            quranSoundCubit.release();
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            LucideIcons.x,
                            color: theme.textTheme.titleLarge!.color,
                          ))
                    ],
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
            ),
            body: PageView(
              controller: state.pageController,
              onPageChanged: (page) {
                quranJuzuCubit.changePage(page);
              },
              children: state.currentQuranJuzu == null
                  ? []
                  : (state.currentQuranJuzu?.data?.juzuPages ?? [])
                      .map(
                        (e) => SingleChildScrollView(
                          controller: scrollController,
                          padding: const EdgeInsets.only(bottom: 50, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: e.ayahs!
                                .asMap()
                                .map(
                                  (i, aya) => MapEntry(
                                    i,
                                    // InkWell(
                                    //   onLongPress: () =>
                                    //       quranJuzuCubit.setContinu(
                                    //     juzuIndex: aya.juz! - 1,
                                    //     page: aya.page!,
                                    //     ayahsJuzu: aya,
                                    //   ),
                                    //   // onTap: () {
                                    //   //   setState(() {
                                    //   //     quranSoundCubit.release();
                                    //   //     isSoundShow = true;
                                    //   //     quranSoundCubit
                                    //   //         .playAya(aya.number ?? 0);
                                    //   //     selectedAyah = i;
                                    //   //   });
                                    //   // },
                                    //   child:
                                    AyaJuzuWidget(
                                      quranSoundCubit: quranSoundCubit,
                                      aya: aya,
                                      index: i,
                                      searchedAya:
                                          widget.quranListJuzua.ayahs?.text,
                                      // ),
                                    ),
                                  ),
                                )
                                .values
                                .toList(),
                          ),
                        ),
                      )
                      .toList(),
            ),
          );
        },
      ),
    );
  }
}
