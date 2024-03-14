import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/src/main_app/quran/juzu/cubit/quran_juzu_cubit.dart';
import 'package:ramadan/utils/utils.dart';

class BottomControllers extends StatelessWidget {
  const BottomControllers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final quranJuzuCubit = context.read<QuranJuzuCubit>();
    final theme = Theme.of(context);
    return BlocBuilder<QuranJuzuCubit, QuranJuzuState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding)
              .copyWith(bottom: 10),
          child: Row(
            children: [
              AnimatedSlide(
                duration: const Duration(milliseconds: 300),
                offset: state.currentPage == 0 &&
                        state.currentQuranJuzu!.data!.ayahs!.first.juz! > 1
                    ? const Offset(0, 0)
                    : const Offset(-1, 0),
                child: InkWell(
                  onTap: state.currentPage == 0 &&
                          state.currentQuranJuzu!.data!.ayahs!.first.juz! > 1
                      ? () {
                          quranJuzuCubit.previousPage(
                              state.currentQuranJuzu!.data!.ayahs!.first.juz!);
                        }
                      : null,
                  child: Container(
                    height: 35,
                    margin: const EdgeInsets.only(left: 5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(kDefaultBorderRadius),
                        color: theme.disabledColor),
                    child: Icon(
                      LucideIcons.chevronRight,
                      color: theme.cardColor,
                    ),
                  ),
                ),
              ),
              AnimatedSlide(
                duration: const Duration(milliseconds: 300),
                offset: state.currentPage == 0 &&
                        state.currentQuranJuzu!.data!.ayahs!.first.juz! > 1
                    ? const Offset(0, 0)
                    : const Offset(.6, 0),
                child: Container(
                  height: 35,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                      color: theme.disabledColor),
                  child: Text(
                    "صفحة  ${(state.currentQuranJuzu!.data!.ayahs!.first.page! + state.currentPage).toString().arabicNumber}",
                    style: theme.textTheme.titleMedium!
                        .copyWith(color: theme.cardColor, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Spacer(),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity:
                    (state.currentQuranJuzu?.data?.juzuPages.length ?? 0) - 1 ==
                                state.currentPage &&
                            state.currentQuranJuzu!.data!.ayahs!.first.juz! < 30
                        ? 1
                        : 0,
                child: InkWell(
                  onTap: () {
                    quranJuzuCubit.nextJuzu(
                        state.currentQuranJuzu!.data!.ayahs!.first.juz!);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(kDefaultBorderRadius),
                        color: theme.primaryColor),
                    child: Row(
                      children: [
                        Text(
                          "الجزء التالي",
                          style: theme.textTheme.titleMedium!.copyWith(
                            fontSize: 14,
                            color: theme.cardColor,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          LucideIcons.chevronLeft,
                          color: theme.cardColor,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
