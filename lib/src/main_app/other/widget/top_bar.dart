import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/src/core/enum/work_type.dart';
import 'package:ramadan/src/main_app/other/cubit/document_cubit.dart';
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
    return BlocBuilder<DocumentCubit, DocumentState>(
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
              duration: const Duration(milliseconds: 300),
              child: isSearch.value
                  ? SearchTextView(focusNode: focusNode, isSearch: isSearch)
                  : OtherWorkTopBarPage(
                      focusNode: focusNode,
                      theme: theme,
                      isSearch: isSearch,
                    ),
            ),
          ),
        );
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
    final documentCubit = context.read<DocumentCubit>();
    return BlocBuilder<DocumentCubit, DocumentState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                isSearch.value = true;
              },
              icon: const Icon(
                LucideIcons.search,
                color: jbPrimaryColor,
              ),
            ),
            // Text(
            //   state.workType.name.tr(),
            //   style: theme.textTheme.titleLarge,
            // ),
            const Spacer(),
            Container(
              // margin: SizerUtil.deviceType == DeviceType.tablet
              //     ? const EdgeInsets.symmetric(horizontal: 24)
              //     : const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: theme.scaffoldBackgroundColor),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => documentCubit.changeWorkType(WorkType.zyara),
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
                          color: state.workType != WorkType.zyara
                              ? Colors.transparent
                              : theme.primaryColor),
                      child: Text(
                        WorkType.zyara.name.tr(),
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: state.workType == WorkType.zyara
                                ? Colors.white
                                : jbUnselectColor,
                            fontSize:
                                state.workType == WorkType.zyara ? 18 : 14),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => documentCubit.changeWorkType(WorkType.munajat),
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
                          color: state.workType != WorkType.munajat
                              ? Colors.transparent
                              : theme.primaryColor),
                      child: Text(
                        WorkType.munajat.name.tr(),
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: state.workType == WorkType.munajat
                                ? Colors.white
                                : jbUnselectColor,
                            fontSize:
                                state.workType == WorkType.munajat ? 18 : 14),
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
    final documentCubit = context.read<DocumentCubit>();
    return BlocBuilder<DocumentCubit, DocumentState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: FDTextInput(
                focusNode: focusNode,
                label: "البحث",
                onSubmit: (a) {
                  if (state.workType == WorkType.zyara) {
                    documentCubit.searchZyarat(a);
                  } else {
                    documentCubit.searchMunajat(a);
                  }

                  FocusScope.of(context).unfocus();
                },
                onType: (a) {
                  if (state.workType == WorkType.zyara) {
                    documentCubit.searchZyarat(a);
                  } else {
                    documentCubit.searchMunajat(a);
                  }
                },
              ),
            ),
            TextButton(
                onPressed: () {
                  isSearch.value = false;

                  documentCubit.clearSearch();
                },
                child: const Text("إلغاء"))
          ],
        );
      },
    );
  }
}
