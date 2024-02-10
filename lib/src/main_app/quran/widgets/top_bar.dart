import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/src/main_app/quran/bussines_logic/quran_cubit.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:ramadan/src/core/widget/mu_text_input.dart';

class TopBarView extends StatelessWidget {
  const TopBarView({
    super.key,
    required this.size,
    required this.theme,
    required this.isSearch,
    required this.focusNode,
    required this.quranController,
  });

  final MediaQueryData size;
  final ThemeData theme;
  final ValueNotifier<bool> isSearch;
  final FocusNode focusNode;
  final QuranCubit quranController;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
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
        child: isSearch.value
            ? SearchTextView(
                focusNode: focusNode,
                quranController: quranController,
                isSearch: isSearch)
            : QuranTopBarPage(
                isSearch: isSearch,
                focusNode: focusNode,
                theme: theme,
                quranController: quranController),
      ),
    );
  }
}

class QuranTopBarPage extends StatelessWidget {
  const QuranTopBarPage({
    super.key,
    required this.isSearch,
    required this.focusNode,
    required this.theme,
    required this.quranController,
  });

  final ValueNotifier<bool> isSearch;
  final FocusNode focusNode;
  final ThemeData theme;
  final QuranCubit quranController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        return Row(
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                isSearch.value = true;

                Future.delayed(Duration(seconds: 1)).then(
                    (value) => FocusScope.of(context).requestFocus(focusNode));
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
                    onTap: () => quranController.changeDisplayType(true),
                    child: AnimatedContainer(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(kDefaultBorderRadius),
                          color: !state.info.isSuraType
                              ? Colors.transparent
                              : theme.primaryColor),
                      child: Text(
                        "سور",
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: state.info.isSuraType
                                ? Colors.white
                                : jbUnselectColor,
                            fontSize: state.info.isSuraType ? 18 : 14),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => quranController
                        .changeDisplayType(!state.info.isSuraType),
                    child: AnimatedContainer(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(kDefaultBorderRadius),
                          color: state.info.isSuraType
                              ? Colors.transparent
                              : theme.primaryColor),
                      child: Text(
                        "اجزاء",
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: !state.info.isSuraType
                                ? Colors.white
                                : jbUnselectColor,
                            fontSize: !state.info.isSuraType ? 18 : 14),
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
    required this.quranController,
    required this.isSearch,
  });

  final FocusNode focusNode;
  final QuranCubit quranController;
  final ValueNotifier<bool> isSearch;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FDTextInput(
            focusNode: focusNode,
            label: "ابحث عن سورة",
            onSubmit: (a) {
              quranController.search(a);
              FocusScope.of(context).unfocus();
            },
            onType: (value) => quranController.search(value),
          ),
        ),
        TextButton(
            onPressed: () {
              isSearch.value = false;
              quranController.resetQuran();
            },
            child: const Text("إلغاء"))
      ],
    );
  }
}
