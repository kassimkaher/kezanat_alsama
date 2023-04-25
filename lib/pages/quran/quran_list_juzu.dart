import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/bussines_logic/Setting/settings_cubit.dart';
import 'package:ramadan/bussines_logic/quran/quran_cubit.dart';
import 'package:ramadan/model/quran_juzu_model.dart';
import 'package:ramadan/pages/quran/component.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:visibility_detector/visibility_detector.dart';

class QuranListJuzu extends StatelessWidget {
  const QuranListJuzu({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        return state.info.quranJuzuList.isEmpty
            ? const Center(
                child: Text("حدث خطأ"),
              )
            : ListView.separated(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.only(bottom: 100, top: 12),
                separatorBuilder: (c, i) => Divider(
                  height: 4,
                  color: theme.scaffoldBackgroundColor,
                ),
                itemCount: state.info.quranJuzuList.length,
                itemBuilder: (c, i) => InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();

                    Navigator.push(
                        context,
                        to(SuraViewForJuzu(
                          quranListJuzua: state.info.quranJuzuList[i],
                        )));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding, vertical: 12),
                    decoration: BoxDecoration(
                        color: theme.cardColor,
                        border: Border.all(color: theme.colorScheme.outline),
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
                              "الجزء ${juzuArray[i]}".toGradiant(
                                  style: theme.textTheme.titleMedium!,
                                  colors: [
                                    theme.textTheme.titleLarge!.color!,
                                    theme.textTheme.titleLarge!.color!
                                  ]),
                              const SizedBox(height: 5),
                              Wrap(
                                spacing: 5,
                                runSpacing: 5,
                                children: [
                                  Text(
                                    "${state.info.quranJuzuList[i].data!.ayahs!.first.surah!.name}",
                                    style: theme.textTheme.bodySmall!
                                        .copyWith(color: jbUnselectColor),
                                  ),
                                  Text(
                                    ",",
                                    style: theme.textTheme.displaySmall!
                                        .copyWith(),
                                  ),
                                  Text(
                                    " الآية ${state.info.quranJuzuList[i].data!.ayahs!.first.numberInSurah.toString().arabicNumber}",
                                    style: theme.textTheme.bodySmall!
                                        .copyWith(color: theme.disabledColor),
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
                        state.info.continuQuranModel != null &&
                                state.info.continuQuranModel!.juzuNumber == i
                            ? Icon(
                                LucideIcons.timer,
                                color: theme.colorScheme.secondary,
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}

class SuraViewForJuzu extends HookWidget {
  const SuraViewForJuzu({super.key, required this.quranListJuzua});
  final QuranJuzuModel quranListJuzua;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final query = MediaQuery.of(context);

    final quranController = context.read<QuranCubit>();
    if (quranController.state.info.currentQuranJuzu == null) {
      quranController.setCurrentJuzu(quranListJuzua);
    }
    if (quranController.state.info.continuQuranModel != null &&
        quranController.state.info.continuQuranModel!.juzuNumber ==
            (quranListJuzua.data!.ayahs!.first.juz! - 1)) {
      quranController
          .setPage(quranController.state.info.continuQuranModel!.pageNumber);
      try {
        Future.delayed(const Duration(milliseconds: 200)).then((value) =>
            Scrollable.ensureVisible(
                quranListJuzua
                    .data!
                    .juzuPages![quranController
                        .state.info.continuQuranModel!.pageNumber!]
                    .ayahs![quranController
                        .state.info.continuQuranModel!.ayaNumber!]
                    .key
                    .currentContext!,
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear));
      } catch (e) {}
    }
    return WillPopScope(
      onWillPop: () async {
        quranController.resetScrool();
        return true;
      },
      child: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: state.info.currentQuranJuzu == null
                ? const SizedBox()
                : Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding)
                            .copyWith(bottom: 10),
                    child: Row(
                      children: [
                        AnimatedSlide(
                          duration: const Duration(milliseconds: 300),
                          offset: state.info.currentPage == 0 &&
                                  state.info.currentQuranJuzu!.data!.ayahs!
                                          .first.juz! >
                                      1
                              ? const Offset(0, 0)
                              : const Offset(-1, 0),
                          child: InkWell(
                            onTap: state.info.currentPage == 0 &&
                                    state.info.currentQuranJuzu!.data!.ayahs!
                                            .first.juz! >
                                        1
                                ? () {
                                    quranController.previousPage(state
                                        .info
                                        .currentQuranJuzu!
                                        .data!
                                        .ayahs!
                                        .first
                                        .juz!);
                                  }
                                : null,
                            child: Container(
                              height: 35,
                              margin: const EdgeInsets.only(left: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      kDefaultBorderRadius),
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
                          offset: state.info.currentPage == 0 &&
                                  state.info.currentQuranJuzu!.data!.ayahs!
                                          .first.juz! >
                                      1
                              ? const Offset(0, 0)
                              : const Offset(.6, 0),
                          child: Container(
                            height: 35,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(kDefaultBorderRadius),
                                color: theme.disabledColor),
                            child: Text(
                              "صفحة  ${(state.info.currentQuranJuzu!.data!.ayahs!.first.page! + state.info.currentPage).toString().arabicNumber}",
                              style: theme.textTheme.titleMedium!.copyWith(
                                  color: theme.cardColor, fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const Spacer(),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: (state.info.currentQuranJuzu?.data?.juzuPages
                                                  ?.length ??
                                              0) -
                                          1 ==
                                      state.info.currentPage &&
                                  state.info.currentQuranJuzu!.data!.ayahs!
                                          .first.juz! <
                                      30
                              ? 1
                              : 0,
                          child: InkWell(
                            onTap: () {
                              quranController.nextJuzu(state.info
                                  .currentQuranJuzu!.data!.ayahs!.first.juz!);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      kDefaultBorderRadius),
                                  color: theme.primaryColor),
                              child: Row(
                                children: [
                                  Text(
                                    "الجزء التالي",
                                    style:
                                        theme.textTheme.titleMedium!.copyWith(
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
                  ),
            appBar: AppBar(
              flexibleSpace: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListTile(
                          title:
                              "الجزء ${juzuArray[(state.info.currentQuranJuzu?.data?.ayahs?.first.juz ?? 1) - 1]}"
                                  .toGradiant(
                            style: theme.textTheme.displayLarge!,
                            colors: [
                              theme.primaryColor,
                              theme.textTheme.titleLarge!.color!
                            ],
                          ),
                        ),
                      ),
                      Text(
                        state.info.currentAyaIndex != null &&
                                state.info.currentQuranJuzu != null &&
                                state.info.currentQuranJuzu!.data!
                                    .juzuPages![state.info.currentPage].ayahs!
                                    .asMap()
                                    .containsKey(state.info.currentAyaIndex)
                            ? state
                                .info
                                .currentQuranJuzu!
                                .data!
                                .juzuPages![state.info.currentPage]
                                .ayahs![state.info.currentAyaIndex!]
                                .surah!
                                .name!
                            : "",
                        style: theme.textTheme.displayLarge!
                            .copyWith(fontSize: 20, color: theme.disabledColor),
                      ),
                      IconButton(
                          onPressed: () {
                            quranController.resetScrool();
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            LucideIcons.x,
                            color: theme.textTheme.titleLarge!.color,
                          ))
                    ],
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
            ),
            body: PageView(
                controller: state.info.pageController,
                onPageChanged: (page) {
                  quranController.changePage(page);
                },
                children: state.info.currentQuranJuzu == null
                    ? []
                    : state.info.currentQuranJuzu!.data!.juzuPages!
                        .map(
                          (e) => SingleChildScrollView(
                            padding: const EdgeInsets.only(bottom: 50, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: e.ayahs!
                                  .asMap()
                                  .map(
                                    (i, aya) => MapEntry(
                                      i,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          aya.isNew && aya.numberInSurah == 1
                                              ? Column(
                                                  children: [
                                                    Container(
                                                        alignment: Alignment
                                                            .center,
                                                        width: double.infinity,
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            vertical: 10,
                                                            horizontal: 80),
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 1),
                                                        decoration:
                                                            BoxDecoration(
                                                          image: theme.brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? null
                                                              : const DecorationImage(
                                                                  image: AssetImage(
                                                                      "assets/images/sura_title.png"),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                        ),
                                                        child: (aya.surah?.name ?? "").toGradiant(
                                                            style: theme
                                                                .textTheme
                                                                .displayLarge!
                                                                .copyWith(
                                                                    fontSize:
                                                                        30,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                            colors: [
                                                              theme
                                                                  .primaryColor,
                                                              theme
                                                                  .disabledColor
                                                            ])),
                                                    const SizedBox(
                                                        height:
                                                            kDefaultPadding),
                                                    aya.numberInSurah == 1 &&
                                                            aya.surah
                                                                    ?.englishName !=
                                                                "Al-Faatiha" &&
                                                            aya.surah
                                                                    ?.englishName !=
                                                                "At-Tawba"
                                                        ? Text(
                                                            "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
                                                            style: theme
                                                                .textTheme
                                                                .displayLarge!
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                          )
                                                        : const SizedBox()
                                                  ],
                                                )
                                              : const SizedBox(),
                                          VisibilityDetector(
                                            key: aya.key,
                                            onVisibilityChanged: (a) {
                                              if (a.visibleFraction == 1) {
                                                quranController.setAyaIndex(i);
                                              }
                                            },
                                            child: ListTile(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          kDefaultBorderRadius)),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 6),
                                              dense: true,
                                              tileColor: aya.sajda != null
                                                  ? theme.primaryColor
                                                      .withOpacity(0.2)
                                                  : Colors.transparent,
                                              title: aya.sajda != null
                                                  ? Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal:
                                                              kDefaultPadding),
                                                      child: Text(
                                                        aya.sajda!.obligatory ==
                                                                true
                                                            ? "سجدة واجبة"
                                                            : "سجدة مستحبة",
                                                        style: theme.textTheme
                                                            .displaySmall,
                                                      ),
                                                    )
                                                  : null,
                                              subtitle: InkWell(
                                                onLongPress: () =>
                                                    quranController.setContinu(
                                                        suraName:
                                                            aya.surah!.name!,
                                                        juzuNumber:
                                                            aya.juz! - 1,
                                                        pageNumber: state
                                                            .info.currentPage,
                                                        ayaNumber: i,
                                                        number: state
                                                                .info
                                                                .currentQuranJuzu!
                                                                .data
                                                                ?.ayahs
                                                                ?.length ??
                                                            0),
                                                child: Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: RichText(
                                                      textAlign:
                                                          TextAlign.start,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: i == 0
                                                                ? aya.text
                                                                : aya.text!
                                                                    .replaceFirst(
                                                                        "بسم اللَّه الرحمن الرحيم",
                                                                        ""),
                                                            style: theme
                                                                .textTheme
                                                                .displayLarge!
                                                                .copyWith(
                                                                    height: 2),
                                                          ),
                                                          WidgetSpan(
                                                            alignment:
                                                                PlaceholderAlignment
                                                                    .middle,
                                                            child: Container(
                                                              margin: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
                                                              child: Wrap(
                                                                crossAxisAlignment:
                                                                    WrapCrossAlignment
                                                                        .center,
                                                                children: [
                                                                  NumberWidget(
                                                                    theme:
                                                                        theme,
                                                                    size: 30,
                                                                    number: aya
                                                                        .numberInSurah
                                                                        .toString(),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                    width: 5,
                                                                  ),
                                                                  state.info.continuQuranModel !=
                                                                              null &&
                                                                          (state.info.continuQuranModel!.juzuNumber ==
                                                                              (aya.juz! -
                                                                                  1)) &&
                                                                          state.info.continuQuranModel!.pageNumber ==
                                                                              state.info.currentPage &&
                                                                          (state.info.continuQuranModel!.ayaNumber!) == i
                                                                      ? const Icon(
                                                                          LucideIcons
                                                                              .bookmark,
                                                                          color:
                                                                              Colors.green,
                                                                        )
                                                                      : SizedBox(),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .values
                                  .toList(),
                            ),
                          ),
                        )
                        .toList()),
          );
        },
      ),
    );
  }
}
