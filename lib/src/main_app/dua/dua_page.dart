import 'package:ramadan/src/core/enum/work_type.dart';
import 'package:ramadan/src/main_app/dua/work_display_view.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/daily_work_model.dart';
import 'package:ramadan/src/main_app/widgets/work_card.dart';
import 'package:ramadan/utils/utils.dart';

class DuaPage extends StatelessWidget {
  const DuaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final duaController = context.read<DuaCubit>();
    if (duaController.state is! DuaStateLoaded) {
      duaController.getMufatehALgynan();
    }
    return BlocBuilder<DuaCubit, DuaState>(builder: (context, state) {
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
          body: state is DuaStateLoading
              ? const Center(child: CircularProgressIndicator())
              : state is DuaStateLoaded
                  ? Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                itemCount:
                                    state.info.documentEntity?.dua?.length ?? 0,
                                itemBuilder: (c, i) => WorkCard(
                                      dailyWorkData: DailyWorkData(
                                          title: state.info.documentEntity!
                                              .dua![i].title!,
                                          type: WorkType.dua),
                                      onTap: () => Navigator.push(
                                        context,
                                        to(
                                          WorkDisplayText(
                                            data: state
                                                .info.documentEntity!.dua![i],
                                          ),
                                        ),
                                      ),
                                    ))),
                      ],
                    )
                  : state is DuaStateFiald
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
