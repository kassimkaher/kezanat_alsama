import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/src/main_app/quran/cubit/quran_search_cubit.dart';
import 'package:ramadan/src/main_app/quran/juzu/cubit/quran_juzu_cubit.dart';
import 'package:ramadan/src/main_app/quran/sura/cubit/quran_sura_cubit.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:ramadan/src/core/widget/mu_text_input.dart';

class TopBarView extends StatelessWidget {
  const TopBarView({
    super.key,
    required this.size,
    required this.theme,
    required this.focusNode,
    required this.quranController,
  });

  final MediaQueryData size;
  final ThemeData theme;

  final FocusNode focusNode;
  final QuranSuraCubit quranController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranSearchCubit, QuranSearchState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(
              top: size.viewPadding.top,
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: kDefaultPadding),
          decoration: BoxDecoration(
            color: theme.cardColor,
            border: Border(
              bottom: BorderSide(color: theme.colorScheme.outline),
            ),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: state.isSearch
                ? SearchTextView(focusNode: focusNode, isSearch: state.isSearch)
                : QuranTopBarPage(
                    focusNode: focusNode,
                    theme: theme,
                  ),
          ),
        );
      },
    );
  }
}

class QuranTopBarPage extends StatelessWidget {
  const QuranTopBarPage({
    super.key,
    required this.focusNode,
    required this.theme,
  });

  final FocusNode focusNode;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final quranSearchCubit = context.read<QuranSearchCubit>();
    return BlocBuilder<QuranSearchCubit, QuranSearchState>(
      builder: (context, state) {
        return Row(
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                quranSearchCubit.changeIsSearch(true);

                // Future.delayed(const Duration(seconds: 1)).then(
                //     (value) => FocusScope.of(context).requestFocus(focusNode));
              },
              icon: const Icon(
                LucideIcons.search,
                color: jbPrimaryColor,
              ),
            ),
            Text(
              "القرآن الكريم",
              style: theme.textTheme.titleLarge,
            ),
            const Spacer(),
            Container(
              height: 40,
              width: 120,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: theme.scaffoldBackgroundColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () =>
                        quranSearchCubit.changeDisplayType(SearchType.sura),
                    child: AnimatedContainer(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(kDefaultBorderRadius),
                          color: state.searchType != SearchType.sura
                              ? Colors.transparent
                              : theme.primaryColor),
                      child: Text(
                        "سور",
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: state.searchType == SearchType.sura
                                ? Colors.white
                                : jbUnselectColor,
                            fontSize:
                                state.searchType == SearchType.sura ? 18 : 14),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () =>
                        quranSearchCubit.changeDisplayType(SearchType.juzu),
                    child: AnimatedContainer(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(kDefaultBorderRadius),
                          color: state.searchType != SearchType.juzu
                              ? Colors.transparent
                              : theme.primaryColor),
                      child: Text(
                        "اجزاء",
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: state.searchType == SearchType.juzu
                                ? Colors.white
                                : jbUnselectColor,
                            fontSize:
                                state.searchType == SearchType.juzu ? 18 : 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class SearchTextView extends StatelessWidget {
  const SearchTextView({
    super.key,
    required this.focusNode,
    required this.isSearch,
  });

  final FocusNode focusNode;

  final bool isSearch;

  @override
  Widget build(BuildContext context) {
    final quranSearchCubit = context.read<QuranSearchCubit>();
    final quranJuzuCubit = context.read<QuranJuzuCubit>();
    final quranSuraCubit = context.read<QuranSuraCubit>();
    return BlocBuilder<QuranSearchCubit, QuranSearchState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: FDTextInput(
                focusNode: focusNode,
                label: "ابحث عن سورة",
                onSubmit: (a) {
                  if (state.searchType == SearchType.juzu) {
                    quranJuzuCubit.searchInJuzu(a);
                  } else {
                    quranSuraCubit.searchInSura(a);
                  }

                  FocusScope.of(context).unfocus();
                },
                onType: (a) {
                  if (state.searchType == SearchType.juzu) {
                    quranJuzuCubit.searchInJuzu(a);
                  } else {
                    quranSuraCubit.searchInSura(a);
                  }
                },
              ),
            ),
            TextButton(
                onPressed: () {
                  quranSearchCubit.changeIsSearch(false);
                  quranSuraCubit.fillCache();
                  quranJuzuCubit.fillCache();
                },
                child: const Text("إلغاء"))
          ],
        );
      },
    );
  }
}
