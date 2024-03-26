import 'package:ramadan/src/main_app/quran/data/model/quran_juzu_model.dart';
import 'package:ramadan/src/main_app/quran/juzu/cubit/quran_juzu_cubit.dart';
import 'package:ramadan/src/main_app/quran/widgets/aya_player_view.dart';
import 'package:ramadan/src/main_app/quran/quran_sound/quran_sound_cubit.dart';
import 'package:ramadan/src/main_app/quran/widgets/component.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AyaJuzuWidget extends StatelessWidget {
  const AyaJuzuWidget(
      {super.key,
      required this.aya,
      required this.index,
      this.searchedAya,
      required this.quranSoundCubit});
  final AyahsJuzu aya;
  final int index;
  final String? searchedAya;
  final QuranSoundCubit quranSoundCubit;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final quranJuzuCubit = context.read<QuranJuzuCubit>();

    return BlocBuilder<QuranJuzuCubit, QuranJuzuState>(
      builder: (context, state) {
        return BlocProvider.value(
            value: quranSoundCubit,
            child: BlocBuilder<QuranSoundCubit, QuranSoundState>(
              builder: (context, quranSoundState) {
                return InkWell(
                  onTap: () => quranSoundCubit.toogleSoundWidget(aya),
                  onDoubleTap: () => quranJuzuCubit.setContinu(
                      juzuIndex: aya.juz! - 1, page: aya.page!, ayahsJuzu: aya),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                        color: quranSoundState.ayaShow == aya
                            ? theme.canvasColor
                            : null,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        aya.isNew && aya.numberInSurah == 1
                            ? Column(
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 80),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 1),
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/sura_title.png"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      child: (aya.surah?.name ?? "").toGradiant(
                                          style: theme.textTheme.displayLarge!
                                              .copyWith(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w500),
                                          colors: [
                                            theme.primaryColor,
                                            theme.disabledColor
                                          ])),
                                  // const SizedBox(height: kDefaultPadding),
                                  aya.numberInSurah == 1 &&
                                          aya.surah?.englishName !=
                                              "Al-Faatiha" &&
                                          aya.surah?.englishName != "At-Tawba"
                                      ? "﷽".toGradiant(
                                          style: theme.textTheme.displayLarge!
                                              .copyWith(
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.w500),
                                          colors: [
                                              theme.primaryColor,
                                              theme.disabledColor
                                            ])
                                      : const SizedBox()
                                ],
                              )
                            : const SizedBox(),
                        VisibilityDetector(
                          key: aya.key,
                          onVisibilityChanged: (a) {
                            // if (a.visibleFraction == 1) {
                            //   quranJuzuCubit.setAyaIndex(index);
                            // }
                          },
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(kDefaultBorderRadius),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            dense: true,
                            tileColor: aya.sajda != null
                                ? theme.primaryColor.withOpacity(0.2)
                                : Colors.transparent,
                            title: aya.sajda != null
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kDefaultPadding),
                                    child: Text(
                                      aya.sajda!.obligatory == true
                                          ? "سجدة واجبة"
                                          : "سجدة مستحبة",
                                      style: theme.textTheme.displaySmall,
                                    ),
                                  )
                                : null,
                            subtitle: Container(
                              alignment: Alignment.centerRight,
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  InkWell(
                                    // onTap: quranSoundState.ayaShow ==
                                    //     aya
                                    //     ? () => quranSoundCubit
                                    //     .readWord(aya.text!, i)
                                    //     : null,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      decoration: BoxDecoration(
                                        color: searchedAya == aya.text
                                            ? theme.primaryColor
                                                .withOpacity(0.2)
                                            : null,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Text(
                                        aya.text ?? "",
                                        style: theme.textTheme.displayLarge!
                                            .copyWith(
                                          height: 2,
                                          // color: e.contains(
                                          //     "\u06da")
                                          //     ? Colors.red
                                          //     : null
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ),
                                  // ...aya.text!
                                  //     .split(" ")
                                  //     .asMap()
                                  //     .map((i, e) => MapEntry(
                                  //           i,
                                  //   InkWell(
                                  //             onTap: quranSoundState.ayaShow ==
                                  //                     aya
                                  //                 ? () => quranSoundCubit
                                  //                     .readWord(aya.text!, i)
                                  //                 : null,
                                  //             child: Container(
                                  //               padding:
                                  //                   const EdgeInsets.symmetric(
                                  //                       horizontal: 2),
                                  //               decoration: BoxDecoration(
                                  //                 color: searchedAya == aya.text
                                  //                     ? theme.primaryColor
                                  //                         .withOpacity(0.2)
                                  //                     : null,
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(16),
                                  //               ),
                                  //               child: Text(
                                  //                 e,
                                  //                 style: theme
                                  //                     .textTheme.displayLarge!
                                  //                     .copyWith(
                                  //                         height: 2,
                                  //                         color: e.contains(
                                  //                                 "\u06da")
                                  //                             ? Colors.red
                                  //                             : null),
                                  //                 textAlign: TextAlign.right,
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ))
                                  //     .values,
                                  NumberWidget(
                                    theme: theme,
                                    size: 30,
                                    number: aya.numberInSurah.toString(),
                                  ),
                                  state.continuQuranModel != null &&
                                          state.continuQuranModel!.ayaNumber ==
                                              aya.number
                                      ? const Icon(
                                          Icons.bookmark_rounded,
                                          color: Colors.green,
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          height: quranSoundState.ayaShow == aya ? 130 : 0,
                          duration: const Duration(milliseconds: 300),
                          child: quranSoundState.ayaShow == aya
                              ? AyahPlayerView(aya: aya, theme: theme)
                              : const SizedBox(),
                        )
                      ],
                    ),
                  ),
                );
              },
            ));
      },
    );
  }
}
