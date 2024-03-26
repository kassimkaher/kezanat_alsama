import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/core/enum/work_type.dart';
import 'package:ramadan/src/main_app/dua/work_display_view.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/daily_work_model.dart';
import 'package:ramadan/src/main_app/other/cubit/document_cubit.dart';
import 'package:ramadan/src/main_app/widgets/work_card.dart';
import 'package:ramadan/utils/utils.dart';

class DuaPage extends StatelessWidget {
  const DuaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final duaController = context.read<DocumentCubit>();
    if (duaController.state.dataStatus is! SateSucess) {
      duaController.getWorksDocumentModel();
    }
    return BlocBuilder<DocumentCubit, DocumentState>(builder: (context, state) {
      return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: "الادعية".toGradiant(
              colors: [
                theme.textTheme.titleLarge!.color!,
                theme.textTheme.bodySmall!.color!
              ],
              style: theme.textTheme.titleLarge!,
            ),
          ),
          body: state.dataStatus is StateLoading
              ? const Center(child: CircularProgressIndicator())
              : state.dataStatus is SateSucess
                  ? Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                itemCount: state.zyaratData?.dua?.length ?? 0,
                                itemBuilder: (c, i) => WorkCard(
                                      dailyWorkData: DailyWorkData(
                                          title:
                                              state.zyaratData?.dua?[i].title!,
                                          type: WorkType.dua),
                                      onTap: () => Navigator.push(
                                        context,
                                        to(
                                          WorkDisplayText(
                                            data: state.zyaratData!.dua![i],
                                          ),
                                        ),
                                      ),
                                    ))),
                      ],
                    )
                  : state is StateError
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
