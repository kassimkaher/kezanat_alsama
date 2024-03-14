import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/main_app/quran/sura/cubit/quran_sura_cubit.dart';
import 'package:ramadan/src/main_app/quran/sura/pages/quran_suar_view.dart';
import 'package:ramadan/src/main_app/quran/widgets/component.dart';
import 'package:ramadan/utils/utils.dart';

class QuranSuarView extends StatelessWidget {
  const QuranSuarView({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranSuraCubit, QuranSuraState>(
      builder: (context, state) {
        return state.dataStatus is StateLoading
            ? const Center(child: CircularProgressIndicator())
            : state.dataStatus is SateSucess
                ? ListView.separated(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.only(bottom: 100),
                    separatorBuilder: (c, i) => Divider(
                      indent: 60,
                      endIndent: 60,
                      height: 2,
                      color: theme.scaffoldBackgroundColor,
                    ),
                    itemCount: state.cachQuranModelForSearch?.length ?? 0,
                    itemBuilder: (c, i) => InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();

                        Navigator.push(
                            context,
                            to(SuraViewForSuar(
                              data: state.cachQuranModelForSearch![i].surahs,
                              index: i,
                              selectedAyah:
                                  state.cachQuranModelForSearch![i].ayahs ==
                                          null
                                      ? -1
                                      : state.cachQuranModelForSearch![i].surahs
                                          .ayaht
                                          .indexOf(state
                                              .cachQuranModelForSearch![i]
                                              .ayahs!),
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
                              number: state.cachQuranModelForSearch![i].surahs
                                  .surahInfo.number
                                  .toString(),
                              size: 40,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    state.cachQuranModelForSearch![i].surahs
                                        .surahInfo.name!,
                                    style: theme.textTheme.titleSmall,
                                  ),
                                  state.cachQuranModelForSearch![i].ayahs
                                              ?.text !=
                                          null
                                      ? Text(
                                          state.cachQuranModelForSearch![i]
                                                  .ayahs?.text ??
                                              "",
                                          style: theme.textTheme.bodyMedium!
                                              .copyWith(
                                                  color: theme
                                                      .colorScheme.secondary),
                                          maxLines: 1,
                                        )
                                      : Text(
                                          "${state.cachQuranModelForSearch![i].surahs.ayaht.length} آية  ",
                                          style: theme.textTheme.displaySmall,
                                        ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Icon(
                              LucideIcons.chevronLeft,
                              color: jbSecondary,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: Text("error loading quran"),
                  );
      },
    );
  }
}
