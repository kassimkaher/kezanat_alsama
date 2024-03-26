import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/src/main_app/quran/cubit/quran_search_cubit.dart';
import 'package:ramadan/src/main_app/quran/juzu/cubit/quran_juzu_cubit.dart';
import 'package:ramadan/src/main_app/quran/sura/cubit/quran_sura_cubit.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:ramadan/src/core/widget/mu_text_input.dart';
import 'package:sizer/sizer.dart';

class TopBarView extends HookWidget {
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
    final isSearch = useState(false);
    return BlocBuilder<QuranSearchCubit, QuranSearchState>(
      builder: (context, state) {
        return SafeArea(
            child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: theme.cardColor,
            border: Border(
              bottom: BorderSide(color: theme.colorScheme.outline),
            ),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: isSearch.value
                ? SearchTextView(focusNode: focusNode, isSearch: isSearch)
                : OtherWorkTopBarPage(
                    focusNode: focusNode,
                    theme: theme,
                    isSearch: isSearch,
                  ),
          ),
        ));
      },
    );
  }
}

class OtherWorkTopBarPage extends StatelessWidget {
  const OtherWorkTopBarPage(
      {super.key,
      required this.focusNode,
      required this.theme,
      required this.isSearch});

  final FocusNode focusNode;
  final ThemeData theme;
  final ValueNotifier<bool> isSearch;

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
                isSearch.value = true;
                // Future.delayed(const Duration(seconds: 1)).then(
                //     (value) => FocusScope.of(context).requestFocus(focusNode));
              },
              icon: const Icon(
                LucideIcons.search,
                color: jbPrimaryColor,
              ),
            ),
            // Text(
            //   "القرآن الكريم",
            //   style: theme.textTheme.titleLarge,
            // ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: theme.scaffoldBackgroundColor),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () =>
                        quranSearchCubit.changeDisplayType(SearchType.sura),
                    child: AnimatedContainer(
                      padding: SizerUtil.deviceType == DeviceType.tablet
                          ? const EdgeInsets.symmetric(
                              horizontal: 44, vertical: 4)
                          : const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 4),
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(kDefaultBorderRadius),
                          color: state.searchType != SearchType.sura
                              ? Colors.transparent
                              : theme.primaryColor),
                      child: Text(
                        "السور",
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
                      padding: SizerUtil.deviceType == DeviceType.tablet
                          ? const EdgeInsets.symmetric(
                              horizontal: 44, vertical: 4)
                          : const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 4),
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(kDefaultBorderRadius),
                          color: state.searchType != SearchType.juzu
                              ? Colors.transparent
                              : theme.primaryColor),
                      child: Text(
                        "الاجزاء",
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
            const Spacer(),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: const Icon(
                LucideIcons.search,
                color: Colors.transparent,
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

  final ValueNotifier<bool> isSearch;

  @override
  Widget build(BuildContext context) {
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
                  isSearch.value = false;
                  isSearch.value = false;
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
