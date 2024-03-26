import 'package:ramadan/src/core/enum/work_type.dart';
import 'package:ramadan/src/main_app/other/cubit/document_cubit.dart';
import 'package:ramadan/src/main_app/other/munajat_page.dart';
import 'package:ramadan/src/main_app/other/widget/top_bar.dart';
import 'package:ramadan/src/main_app/other/zyarat_page.dart';
import 'package:ramadan/src/main_app/quran/sura/cubit/quran_sura_cubit.dart';
import 'package:ramadan/utils/utils.dart';

class OtherWorkPage extends StatelessWidget {
  const OtherWorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context);
    final focusNode = FocusNode();
    final quranController = context.read<QuranSuraCubit>();

    return BlocBuilder<DocumentCubit, DocumentState>(builder: (context, state) {
      return Scaffold(
          body: Column(
        children: [
          TopBarView(
            size: size,
            theme: theme,
            focusNode: focusNode,
            quranController: quranController,
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: state.workType == WorkType.zyara
                  ? const ZyaratPage()
                  : const MunajatPage(),
            ),
          )
        ],
      ));
    });
  }
}
