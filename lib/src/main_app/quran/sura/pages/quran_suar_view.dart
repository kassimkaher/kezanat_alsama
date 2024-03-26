import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/src/main_app/quran/data/model/sura/sura_model.dart';
import 'package:ramadan/src/main_app/quran/juzu/cubit/quran_juzu_cubit.dart';
import 'package:ramadan/src/main_app/quran/widgets/aya_juzu_widget.dart';
import 'package:ramadan/src/main_app/quran/quran_sound/quran_sound_cubit.dart';
import 'package:ramadan/src/main_app/quran/sura/cubit/quran_sura_cubit.dart';
import 'package:ramadan/utils/injector.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:sizer/sizer.dart';

class SuraViewForSuar extends StatefulWidget {
  const SuraViewForSuar(
      {super.key,
      required this.data,
      required this.index,
      this.ayaIndex,
      this.selectedAyah});
  final SuraModel data;
  final int index;
  final int? ayaIndex;
  final int? selectedAyah;

  @override
  State<SuraViewForSuar> createState() => _SuraViewForSuarState();
}

class _SuraViewForSuarState extends State<SuraViewForSuar> {
  late ScrollController scrollController;

  late QuranSoundCubit quranSoundCubit;
  late QuranJuzuCubit quranJuzuCubit;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    quranSoundCubit = getIt<QuranSoundCubit>();
    quranJuzuCubit = context.read<QuranJuzuCubit>();
    quranSoundCubit.changeSelectAyah(widget.selectedAyah ?? 0);

    if (widget.selectedAyah != null && widget.selectedAyah! > 0) {
      Future.delayed(const Duration(milliseconds: 200)).then((value) =>
          Scrollable.ensureVisible(
              widget.data.ayaht[widget.selectedAyah!].key.currentContext!,
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final query = MediaQuery.of(context);

    return BlocBuilder<QuranSuraCubit, QuranSuraState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: query.viewPadding.top, bottom: 0),
                decoration: BoxDecoration(
                    border: Border.all(color: theme.colorScheme.outline),
                    borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                    color: theme.cardColor),
                child: Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          widget.data.surahInfo.name!,
                          style: theme.textTheme.titleLarge,
                        ),
                        subtitle: Text(
                          "   ${widget.data.ayaht.length} آية",
                          style: theme.textTheme.displaySmall,
                        ),
                      ),
                    ),
                    // IconButton(
                    //     onPressed: () => quranController.startReading(),
                    //     icon: const Icon(LucideIcons.speaker)),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(LucideIcons.x))
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: SizerUtil.deviceType == DeviceType.tablet
                      ? const EdgeInsets.all(34)
                      : const EdgeInsets.only(bottom: 30, top: kDefaultSpacing),
                  child: Column(children: [
                    // widget.index != 0
                    //     ? Text(
                    //         "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
                    //         style: theme.textTheme.displayLarge!
                    //             .copyWith(fontWeight: FontWeight.w600),
                    //       )
                    //     : const SizedBox(),
                    ...widget.data.ayaht
                        .asMap()
                        .map((i, aya) => MapEntry(
                                  i,
                               AyaJuzuWidget(
                                    quranSoundCubit: quranSoundCubit,
                                    aya: aya,
                                    index: i,
                                    searchedAya: widget.selectedAyah != -1
                                        ? widget
                                            .data
                                            .ayaht[widget.selectedAyah ?? 0]
                                            .text
                                        : null,
                                  ),
                                )
                            // InkWell(
                            //   onTap: () => setState(() {
                            //     quranSoundCubit.release();
                            //     isSoundShow = true;
                            //     quranSoundCubit.playAya(aya.number ?? 0);
                            //     selectedAyah = i;
                            //   }),
                            //   child: AyaJuzuWidget(
                            //     aya: aya,
                            //     index: i,
                            //     searchedAya: widget.selectedAyah != -1
                            //         ? widget
                            //             .data
                            //             .ayaht[widget.selectedAyah ?? 0]
                            //             .text
                            //         : null,
                            //   ),
                            // ),
                            )
                        .values
                        .toList()
                  ]),
                ),
              ),
            ],
          ),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerDocked,
          // floatingActionButton: BlocProvider.value(
          //   value: quranSoundCubit,
          //   child: BlocBuilder<QuranSoundCubit, QuranSoundState>(
          //     builder: (context, state) {
          //       return Visibility(
          //         visible: state.isSoundShow,
          //         child: AyahPlayerView(
          //             aya: AyahsJuzu(
          //                 number: widget.data.ayaht[state.ayahSelected].number,
          //                 surah: SurahInfo(name: widget.data.surahInfo.name),
          //                 text: widget.data.ayaht[state.ayahSelected].text),
          //             theme: theme),
          //       );
          //     },
          //   ),
          // ),
        );
      },
    );
  }
}
