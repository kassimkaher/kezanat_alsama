import 'package:ramadan/model/quran_juzu_model.dart';
import 'package:ramadan/model/quran_model.dart';
import 'package:ramadan/src/main_app/quran/juzu/cubit/quran_juzu_cubit.dart';
import 'package:ramadan/src/main_app/quran/juzu/pages/quran_view_pages.dart';
import 'package:ramadan/src/main_app/quran/widgets/component.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:collection/collection.dart';

class ContinousJuzuReadingWidget extends StatelessWidget {
  const ContinousJuzuReadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<QuranJuzuCubit, QuranJuzuState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child:
              state.continuQuranModel != null && state.quranJuzuList.isNotEmpty
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
                                  quranListJuzua: state.quranjuzuSearch![
                                      state.continuQuranModel!.juzuNumber!],
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
                                    progress: state.continuQuranModel!
                                        .pageNumber(state
                                            .quranJuzuList[state
                                                .continuQuranModel!.juzuNumber!]
                                            .data!
                                            .juzuPages),
                                  ),
                                  "الجزء ${juzuArray[state.continuQuranModel!.juzuNumber!]}"
                                      .toGradiant(colors: [
                                    theme.textTheme.titleLarge!.color!,
                                    theme.textTheme.bodySmall!.color!
                                  ], style: theme.textTheme.titleLarge!),
                                  Text(
                                    " لقد وصلت بالقراءة  الى ${getLastAyaNumberReaded(state.quranJuzuList[state.continuQuranModel!.juzuNumber!].data!.ayahs!, state.continuQuranModel)}",
                                    style: theme.textTheme.displaySmall,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: kDefaultSpacing),
                      ],
                    )
                  : const SizedBox(),
        );
      },
    );
  }

  String? getLastAyaNumberReaded(
      List<AyahsJuzu>? ayaht, ContinuQuranModel? continuQuranModel) {
    if (continuQuranModel == null || ayaht == null || ayaht.isEmpty) {
      return "";
    }
    final aya = ayaht.firstWhereOrNull(
        (element) => element.number == continuQuranModel.ayaNumber!);
    if (aya == null) {
      return "";
    }
    return "${aya.surah?.name} آية ${aya.numberInSurah.toString().arabicNumber}";
  }
}
