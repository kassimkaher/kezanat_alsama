import 'package:ramadan/services/tasbeeh/entity/model/tasbeeh_model.dart';
import 'package:ramadan/services/tasbeeh/presentation/tasbeeh_page.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/core/enum/work_type.dart';
import 'package:ramadan/src/main_app/dua/work_display_view.dart';
import 'package:ramadan/src/main_app/home/daily_work/logic/daily_work_logic/daily_work_cubit.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/daily_work_model.dart';
import 'package:ramadan/src/main_app/home/daily_work/widgets/tabs_view.dart';
import 'package:ramadan/src/main_app/quran/sura/cubit/quran_sura_cubit.dart';
import 'package:ramadan/src/main_app/quran/sura/pages/quran_suar_view.dart';
import 'package:ramadan/src/main_app/widgets/relationship_card.dart';
import 'package:ramadan/src/main_app/widgets/work_card.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:visibility_detector/visibility_detector.dart';

class DailyWorkView extends StatelessWidget {
  const DailyWorkView({super.key});

  @override
  Widget build(BuildContext context) {
    // final dailyWorkCubit = context.read<DailyWorkCubit>();
    final theme = Theme.of(context);

    final keyArray = [GlobalKey(), GlobalKey(), GlobalKey()];
    return Column(
      children: [
        WorkTaps(
          keys: keyArray,
        ),
        BlocBuilder<DailyWorkCubit, DailyWorkState>(
            builder: (context, state) => switch (state.datastatus) {
                  StateLoading() || DataIdeal() => Column(
                      children: [1, 2, 3, 4, 5]
                          .map((e) => const WorkCardPlaceHolder())
                          .toList(),
                    ),
                  const SateSucess() => Column(children: [
                      _getDailyWorkListView(state, theme, keyArray[0]),
                      _getTRelationOfTodayDayListView(
                          state, theme, keyArray[1]),
                      _getThisMonthWorksListView(state, theme, keyArray[2]),
                    ]),
                  _ => const Text("error")
                }),
      ],
    );
  }

  Widget _getThisMonthWorksListView(
      DailyWorkState state, ThemeData theme, Key key) {
    return VisibilityDetector(
        key: key,
        child: state.monthWorkModel == null ||
                state.monthWorkModel!.data!.isEmpty
            ? const SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "اعمال هذا الشهر",
                      style: theme.textTheme.bodyLarge!,
                    ),
                  ),
                  ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (c, i) => const SizedBox(height: 0),
                    itemCount: state.monthWorkModel?.data?.length ?? 0,
                    itemBuilder: (c, i) => WorkCard(
                      dailyWorkData: state.monthWorkModel!.data![i],
                      onTap: () => onTapWork(state.monthWorkModel!.data![i]),
                    ),
                  ),
                ],
              ),
        onVisibilityChanged: (a) {});
  }

  Widget _getDailyWorkListView(DailyWorkState state, ThemeData theme, Key key) {
    return VisibilityDetector(
        key: key,
        child: state.todayWorkModel == null ||
                state.todayWorkModel!.data!.isEmpty
            ? const SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "اعمال اليوم",
                      style: theme.textTheme.bodyLarge!,
                    ),
                  ),
                  ListView.separated(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (c, i) => const SizedBox(height: 0),
                    itemCount: state.todayWorkModel?.data?.length ?? 0,
                    itemBuilder: (c, i) => WorkCard(
                      dailyWorkData: state.todayWorkModel!.data![i],
                      onTap: () => onTapWork(state.todayWorkModel!.data![i]),
                    ),
                  ),
                ],
              ),
        onVisibilityChanged: (_) {});
  }

  Widget _getTRelationOfTodayDayListView(
      DailyWorkState state, ThemeData theme, Key key) {
    return VisibilityDetector(
        key: key,
        child: state.relationShipData == null ||
                state.relationShipData!.data!.isEmpty
            ? const SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "مناسبة اليوم",
                      style: theme.textTheme.bodyLarge!,
                    ),
                  ),
                  ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (c, i) => const SizedBox(height: 0),
                    itemCount: state.relationShipData?.data?.length ?? 0,
                    itemBuilder: (c, i) => RelationshibsCard(
                      dailyWorkData: state.relationShipData!.data![i],
                    ),
                  ),
                ],
              ),
        onVisibilityChanged: (a) {});
  }

  onTapWork(DailyWorkData dailyWorkData) {
    switch (dailyWorkData.type) {
      case WorkType.dua:
      case WorkType.salat:
      case WorkType.zyara:
        navigatorKey.currentState!.push(
          to(
            WorkDisplayText(
              data: dailyWorkData.toDuaEntity(),
            ),
          ),
        );

        break;
      case WorkType.quran:
        navigatorKey.currentState!.push(
          to(
            SuraViewForSuar(
              data: navigatorKey.currentContext!
                  .read<QuranSuraCubit>()
                  .state
                  .quranModel![dailyWorkData.sura!],
              index: dailyWorkData.sura!,
            ),
          ),
        );
        break;
      case WorkType.tasbeeh:
        navigatorKey.currentState!.push(
          to(
            TasbeehPage(
              tasbeehModel: TasbeehModel(
                tasbeehList: [
                  TasbeehData(
                      title: dailyWorkData.title ?? "",
                      description: dailyWorkData.description ?? "",
                      subtitle: dailyWorkData.description ?? "",
                      number: int.tryParse(dailyWorkData.text ?? "0") ?? 0,
                      speak: dailyWorkData.description ?? "")
                ],
              ),
            ),
          ),
        );

        break;
      default:
    }
  }
}
