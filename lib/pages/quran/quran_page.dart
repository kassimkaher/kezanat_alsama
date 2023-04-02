import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/bussines_logic/quran/quran_cubit.dart';
import 'package:ramadan/model/quran_model.dart';
import 'package:ramadan/pages/quran/component.dart';
import 'package:ramadan/pages/quran/quran_list_juzu.dart';
import 'package:ramadan/pages/quran/quran_list_suar.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:ramadan/widget/mu_text_input.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../bussines_logic/Setting/settings_cubit.dart';

class QuranPage extends HookWidget {
  const QuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isSearch = useState(false);
    final theme = Theme.of(context);
    final size = MediaQuery.of(context);
    final focusNode = FocusNode();
    final quranController = context.read<QuranCubit>();
    if (quranController.state is! QuranStateLoaded) {
      quranController.getQuran();
    }
    if (quranController.state is QuranStateLoaded) {
      quranController.getContinu();
    }
    return BlocBuilder<QuranCubit, QuranState>(builder: (context, state) {
      return Scaffold(
          body: state is QuranStateLoading
              ? const Center(child: CircularProgressIndicator())
              : state is QuranStateLoaded
                  ? Column(
                      children: [
                        Container(
                          // height: 100,
                          padding: EdgeInsets.only(
                              top: size.viewPadding.top,
                              left: kDefaultPadding,
                              right: kDefaultPadding,
                              bottom: kDefaultPadding),
                          decoration: BoxDecoration(
                            color: theme.cardColor,
                            border: Border(
                              bottom:
                                  BorderSide(color: theme.colorScheme.outline),
                            ),
                          ),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: isSearch.value
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: FDTextInput(
                                          focusNode: focusNode,
                                          label: "ابحث عن سورة",
                                          onSubmit: (a) =>
                                              quranController.search(a),
                                          onType: (value) =>
                                              quranController.search(value),
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            isSearch.value = false;
                                            quranController.resetQuran();
                                          },
                                          child: Text("إلغاء"))
                                    ],
                                  )
                                : Row(
                                    children: [
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          isSearch.value = true;
                                          FocusScope.of(context)
                                              .requestFocus(focusNode);
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
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color:
                                                theme.scaffoldBackgroundColor),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              onTap: () => quranController
                                                  .changeDisplayType(true),
                                              child: AnimatedContainer(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            kDefaultBorderRadius),
                                                    color: !state
                                                            .info.isSuraType
                                                        ? Colors.transparent
                                                        : theme.primaryColor),
                                                child: Text(
                                                  "سور",
                                                  style: theme
                                                      .textTheme.titleMedium!
                                                      .copyWith(
                                                          color: state.info
                                                                  .isSuraType
                                                              ? Colors.white
                                                              : jbUnselectColor,
                                                          fontSize: state.info
                                                                  .isSuraType
                                                              ? 18
                                                              : 14),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () => quranController
                                                  .changeDisplayType(
                                                      !state.info.isSuraType),
                                              child: AnimatedContainer(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            kDefaultBorderRadius),
                                                    color: state.info.isSuraType
                                                        ? Colors.transparent
                                                        : theme.primaryColor),
                                                child: Text(
                                                  "اجزاء",
                                                  style: theme
                                                      .textTheme.titleMedium!
                                                      .copyWith(
                                                          color: !state.info
                                                                  .isSuraType
                                                              ? Colors.white
                                                              : jbUnselectColor,
                                                          fontSize: !state.info
                                                                  .isSuraType
                                                              ? 18
                                                              : 14),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: state.info.continuQuranModel != null &&
                                  state.info.quranJuzuList.isNotEmpty
                              ? Column(
                                  children: [
                                    const SizedBox(height: kDefaultSpacing / 2),
                                    InkWell(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();

                                        Navigator.push(
                                          context,
                                          to(
                                            SuraViewForJuzu(
                                              quranListJuzua:
                                                  state.info.quranJuzuList[state
                                                      .info
                                                      .continuQuranModel!
                                                      .juzuNumber!],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              QuranCircular(
                                                  progress: state
                                                          .info
                                                          .continuQuranModel!
                                                          .pageNumber! /
                                                      state
                                                          .info
                                                          .quranJuzuList[state
                                                              .info
                                                              .continuQuranModel!
                                                              .juzuNumber!]
                                                          .data!
                                                          .juzuPages!
                                                          .length),
                                              "الجزء ${juzuArray[state.info.continuQuranModel!.juzuNumber!]}"
                                                  .toGradiant(
                                                      colors: [
                                                    theme.textTheme.titleLarge!
                                                        .color!,
                                                    theme.textTheme.bodySmall!
                                                        .color!
                                                  ],
                                                      style: theme.textTheme
                                                          .titleLarge!),
                                              Text(
                                                " لقد وصلت بالقراءة  الى ${state.info.quranJuzuList[state.info.continuQuranModel!.juzuNumber!].data!.juzuPages![state.info.continuQuranModel!.pageNumber!].ayahs![state.info.continuQuranModel!.ayaNumber!].surah!.name} آية ${state.info.quranJuzuList[state.info.continuQuranModel!.juzuNumber!].data!.juzuPages![state.info.continuQuranModel!.pageNumber!].ayahs![state.info.continuQuranModel!.ayaNumber!].numberInSurah.toString().farsiNumber}",
                                                style: theme
                                                    .textTheme.displaySmall,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: kDefaultSpacing),
                                  ],
                                )
                              : SizedBox(),
                        ),
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: state.info.isSuraType
                                ? QuranListSuar(theme: theme)
                                : QuranListJuzu(theme: theme),
                          ),
                        )
                      ],
                    )
                  : state is QuranStateFiald
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "حدث خطأ",
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              " dataProv.trans.error_ser_title",
                              style: Theme.of(context).textTheme.titleLarge,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              " dataProv.trans.error_ser_subtitle",
                              style: Theme.of(context).textTheme.titleLarge,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ));
    });
  }
}
