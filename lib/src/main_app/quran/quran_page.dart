import 'package:ramadan/src/main_app/quran/cubit/quran_search_cubit.dart';
import 'package:ramadan/src/main_app/quran/juzu/pages/quran_list_juzu.dart';
import 'package:ramadan/src/main_app/quran/sura/cubit/quran_sura_cubit.dart';
import 'package:ramadan/src/main_app/quran/sura/pages/quran_sura_list.dart';
import 'package:ramadan/src/main_app/quran/widgets/juzu_continuos_widget.dart';
import 'package:ramadan/src/main_app/quran/widgets/top_bar.dart';
import 'package:ramadan/utils/utils.dart';

class QuranPage extends StatelessWidget {
  const QuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context);
    final focusNode = FocusNode();
    final quranController = context.read<QuranSuraCubit>();

    return BlocBuilder<QuranSearchCubit, QuranSearchState>(
        builder: (context, state) {
      return Scaffold(
          body: Column(
        children: [
          TopBarView(
            size: size,
            theme: theme,
            focusNode: focusNode,
            quranController: quranController,
          ),
          const ContinousJuzuReadingWidget(),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: state.searchType == SearchType.sura
                  ? QuranSuarView(theme: theme)
                  : QuranListJuzu(theme: theme),
            ),
          )
        ],
      ));
    });
  }
}
