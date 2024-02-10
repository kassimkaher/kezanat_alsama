import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ramadan/src/main_app/quran/component.dart';
import 'package:ramadan/src/main_app/quran/quran_list_juzu.dart';
import 'package:ramadan/src/main_app/quran/quran_list_suar.dart';
import 'package:ramadan/src/main_app/quran/widgets/top_bar.dart';
import 'package:ramadan/utils/utils.dart';

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

    return BlocBuilder<QuranCubit, QuranState>(builder: (context, state) {
      if (state is QuranStateLoaded && state.info.continuQuranModel == null) {
        quranController.getContinu();
      }
      return Scaffold(
          body: state is QuranStateLoading
              ? const Center(child: CircularProgressIndicator())
              : state is QuranStateLoaded
                  ? Column(
                      children: [
                        TopBarView(
                            size: size,
                            theme: theme,
                            isSearch: isSearch,
                            focusNode: focusNode,
                            quranController: quranController),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: state.info.continuQuranModel != null &&
                                  state.info.quranJuzuList.isNotEmpty
                              ? Column(
                                  children: [
                                    const SizedBox(height: kDefaultSpacing / 2),
                                    InkWell(
                                      onTap: () {
                                        FocusScope.of(context).unfocus;
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
                                                " لقد وصلت بالقراءة  الى ${getLastAyaNumberReaded(state)}",
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

  String? getLastAyaNumberReaded(QuranStateLoaded state) {
    final juzu = state.info.quranJuzuList
        .elementAtOrNull(state.info.continuQuranModel!.juzuNumber!);
    if (juzu == null) {
      return "";
    }

    final page = juzu.data!.juzuPages!
        .elementAtOrNull(state.info.continuQuranModel!.pageNumber!);
    if (page == null || page.ayahs == null) {
      return "";
    }
    final aya =
        page.ayahs!.elementAtOrNull(state.info.continuQuranModel!.ayaNumber!);
    if (aya == null) {
      return "";
    }

    return "${aya.surah?.name} آية ${aya.numberInSurah.toString().arabicNumber}";
  }
}
