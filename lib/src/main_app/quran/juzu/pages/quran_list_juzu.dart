import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/main_app/quran/juzu/cubit/quran_juzu_cubit.dart';
import 'package:ramadan/src/main_app/quran/juzu/pages/quran_view_pages.dart';
import 'package:ramadan/utils/utils.dart';

class QuranListJuzu extends StatelessWidget {
  const QuranListJuzu({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranJuzuCubit, QuranJuzuState>(
      builder: (context, state) {
        return state.dataStatus is StateLoading
            ? const Center(child: CircularProgressIndicator())
            : state.dataStatus is SateSucess
                ? ListView.separated(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.only(bottom: 100, top: 12),
                    separatorBuilder: (c, i) => Divider(
                      height: 4,
                      color: theme.scaffoldBackgroundColor,
                    ),
                    itemCount: state.quranjuzuSearch?.length ?? 0,
                    itemBuilder: (c, i) => InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();

                        Navigator.push(
                            context,
                            to(SuraViewForJuzu(
                              quranListJuzua: state.quranjuzuSearch![i],
                            )));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding, vertical: 12),
                        decoration: BoxDecoration(
                            color: theme.cardColor,
                            border:
                                Border.all(color: theme.colorScheme.outline),
                            borderRadius:
                                BorderRadius.circular(kDefaultBorderRadius)),
                        child: Row(
                          //  crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/quran3.svg",
                              width: 35,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "الجزء ${juzuArray[state.quranjuzuSearch![i].juzuModel.data!.number! - 1]}"
                                      .toGradiant(
                                          style: theme.textTheme.titleMedium!,
                                          colors: [
                                        theme.textTheme.titleLarge!.color!,
                                        theme.textTheme.titleLarge!.color!
                                      ]),
                                  const SizedBox(height: 5),
                                  state.quranjuzuSearch![i].ayahs != null
                                      ? Text(
                                          state.quranjuzuSearch![i].ayahs
                                                  ?.text ??
                                              "",
                                          style: theme.textTheme.bodyMedium!
                                              .copyWith(
                                                  color: theme
                                                      .colorScheme.secondary),
                                          maxLines: 1,
                                        )
                                      : Wrap(
                                          spacing: 5,
                                          runSpacing: 5,
                                          children: [
                                            Text(
                                              "${state.quranjuzuSearch![i].juzuModel.data!.ayahs!.first.surah!.name}",
                                              style: theme.textTheme.bodySmall!
                                                  .copyWith(
                                                      color: jbUnselectColor),
                                            ),
                                            Text(
                                              ",",
                                              style: theme
                                                  .textTheme.displaySmall!
                                                  .copyWith(),
                                            ),
                                            Text(
                                              " الآية ${state.quranjuzuSearch![i].juzuModel.data!.ayahs!.first.numberInSurah.toString().arabicNumber}",
                                              style: theme.textTheme.bodySmall!
                                                  .copyWith(
                                                      color:
                                                          theme.disabledColor),
                                            ),
                                          ],
                                        )
                                ],
                              ),
                            ),
                            // const Icon(
                            //   LucideIcons.chevronLeft,
                            //   color: jbSecondary,
                            // ),
                            state.continuQuranModel != null &&
                                    state.continuQuranModel!.juzuNumber == i
                                ? Icon(
                                    LucideIcons.timer,
                                    color: theme.colorScheme.secondary,
                                  )
                                : const SizedBox()
                          ],
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: Text("error loading quran parts"),
                  );
      },
    );
  }
}
