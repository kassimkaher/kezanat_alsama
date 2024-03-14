import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/model/quran_juzu_model.dart';
import 'package:ramadan/src/main_app/quran/juzu/cubit/quran_juzu_cubit.dart';
import 'package:ramadan/src/main_app/quran/juzu/widgets/aya_player_view.dart';
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
                  child: Container(
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
                                      decoration: BoxDecoration(
                                        image:
                                            theme.brightness == Brightness.dark
                                                ? null
                                                : const DecorationImage(
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
                                  const SizedBox(height: kDefaultPadding),
                                  aya.numberInSurah == 1 &&
                                          aya.surah?.englishName !=
                                              "Al-Faatiha" &&
                                          aya.surah?.englishName != "At-Tawba"
                                      ? Text(
                                          "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
                                          style: theme.textTheme.displayLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        )
                                      : const SizedBox()
                                ],
                              )
                            : const SizedBox(),
                        VisibilityDetector(
                          key: aya.key,
                          onVisibilityChanged: (a) {
                            if (a.visibleFraction == 1) {
                              quranJuzuCubit.setAyaIndex(index);
                            }
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
                                child: RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: index == 0
                                            ? aya.text
                                            : aya.text!.replaceFirst(
                                                "بسم اللَّه الرحمن الرحيم", ""),
                                        style: theme.textTheme.displayLarge!
                                            .copyWith(
                                                height: 2,
                                                backgroundColor:
                                                    searchedAya == aya.text
                                                        ? theme.primaryColor
                                                            .withOpacity(0.2)
                                                        : null),
                                      ),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              NumberWidget(
                                                theme: theme,
                                                size: 30,
                                                number: aya.numberInSurah
                                                    .toString(),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                                width: 5,
                                              ),
                                              state.continuQuranModel != null &&
                                                      state.continuQuranModel!
                                                              .ayaNumber ==
                                                          aya.number
                                                  ? const Icon(
                                                      LucideIcons.bookmark,
                                                      color: Colors.green,
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        Visibility(
                          visible: quranSoundState.ayaShow == aya,
                          child: AyahPlayerView(aya: aya, theme: theme),
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