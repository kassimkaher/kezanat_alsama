import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/core/enum/work_type.dart';
import 'package:ramadan/src/main_app/dua/work_display_view.dart';
import 'package:ramadan/src/main_app/home/daily_work/logic/daily_work_logic/daily_work_cubit.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/daily_work_model.dart';
import 'package:ramadan/src/main_app/home/daily_work/widgets/tabs_view.dart';
import 'package:ramadan/src/main_app/quran/quran_list_suar.dart';
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
        Expanded(
          child: BlocBuilder<DailyWorkCubit, DailyWorkState>(
              builder: (context, state) => switch (state.datastatus) {
                    DataStatus.loading ||
                    DataStatus.ideal =>
                      ListView.separated(
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (c, i) => const WorkCardPlaceHolder(),
                          separatorBuilder: (c, i) => const SizedBox(height: 0),
                          itemCount: 4),
                    DataStatus.success => ListView(children: [
                        _getDailyWorkListView(state, theme, keyArray[0]),
                        _getThisMonthWorksListView(state, theme, keyArray[1]),
                        VisibilityDetector(
                            key: keyArray[2],
                            child: Column(
                              children: [],
                            ),
                            onVisibilityChanged: (_) {}),
                      ]),
                    _ => const Text("error")
                  }),
        ),
      ],
    );
  }

  Widget _getThisMonthWorksListView(
      DailyWorkState state, ThemeData theme, Key key) {
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
                      "اعمال هذا الشهر",
                      style: theme.textTheme.bodyLarge!
                          .copyWith(color: jbUnselectColor),
                    ),
                  ),
                  ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (c, i) => const SizedBox(height: 0),
                    itemCount: state.monthWorkModel?.data?.length ?? 0,
                    itemBuilder: (c, i) => WorkCard(
                      dailyWorkData: state.allDailyWorkModel!.data![i],
                      onTap: () => onTapWork(state.todayWorkModel!.data![i]),
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
                      style: theme.textTheme.bodyLarge!
                          .copyWith(color: jbUnselectColor),
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
                  .read<QuranCubit>()
                  .state
                  .info
                  .quranModel!
                  .data!
                  .surahs![dailyWorkData.sura!],
              index: dailyWorkData.sura!,
            ),
          ),
        );
        break;
      default:
    }
  }
}
