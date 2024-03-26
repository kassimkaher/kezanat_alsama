import 'package:ramadan/services/tasbeeh/entity/model/tasbeeh_model.dart';
import 'package:ramadan/services/tasbeeh/presentation/tasbeeh_page.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/core/enum/work_type.dart';
import 'package:ramadan/src/main_app/dua/work_display_view.dart';
import 'package:ramadan/src/main_app/home/daily_work/logic/daily_work_logic/daily_work_cubit.dart';
import 'package:ramadan/src/main_app/home/daily_work/logic/navigator_cubit/navigator_cubit.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/daily_work_model.dart';
import 'package:ramadan/src/main_app/home/daily_work/widgets/tabs_view.dart';
import 'package:ramadan/src/main_app/quran/sura/cubit/quran_sura_cubit.dart';
import 'package:ramadan/src/main_app/quran/sura/pages/quran_suar_view.dart';
import 'package:ramadan/src/main_app/widgets/relationship_card.dart';
import 'package:ramadan/src/main_app/widgets/work_card.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:sizer/sizer.dart';
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
                  const SateSucess() =>
                    BlocBuilder<NavigatorCubit, NavigatorCubitState>(
                      builder: (context, navigatorstate) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: switch (navigatorstate.selected) {
                            0 => _getDailyWorkListView(
                                state.todayWorkModel, theme, keyArray[0]),
                            1 => Column(
                                children: [
                                  _getWorksNightListView(
                                      state.nightWorks, theme),
                                  _getWorksAfterNightListView(
                                      state.afterNightWorks, theme)
                                ],
                              ),
                            _ => _getTRelationOfTodayDayListView(
                                state, theme, keyArray[1]),
                          },
                        );
                      },
                    ),

                  // Column(children: [

                  //     _getTRelationOfTodayDayListView(
                  //         state, theme, keyArray[1]),
                  //     _getThisMonthWorksListView(state, theme, keyArray[2]),
                  //   ]),
                  _ => const Text("error")
                }),
      ],
    );
  }

  Widget _getDailyWorkListView(
      DailyWorkModel? todayWorkModel, ThemeData theme, Key key) {
    return VisibilityDetector(
        key: key,
        child: todayWorkModel == null || todayWorkModel.data!.isEmpty
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
                  SizerUtil.deviceType == DeviceType.tablet
                      ? GridView.builder(
                          padding: EdgeInsets.all(16),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: todayWorkModel.data?.length ?? 0,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 5 / 1,
                                  crossAxisSpacing: 10),
                          itemBuilder: (c, i) => WorkCard(
                            dailyWorkData: todayWorkModel.data![i],
                            onTap: () => onTapWork(todayWorkModel.data![i]),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (c, i) => const SizedBox(height: 0),
                          itemCount: todayWorkModel.data?.length ?? 0,
                          itemBuilder: (c, i) => WorkCard(
                            dailyWorkData: todayWorkModel.data![i],
                            onTap: () => onTapWork(todayWorkModel.data![i]),
                          ),
                        ),
                ],
              ),
        onVisibilityChanged: (_) {});
  }

  Widget _getWorksNightListView(
    DailyWorkModel? nightWorks,
    ThemeData theme,
  ) {
    return nightWorks == null || nightWorks.data!.isEmpty
        ? const SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "اعمال الليلة",
                  style: theme.textTheme.bodyLarge!,
                ),
              ),
              ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (c, i) => const SizedBox(height: 0),
                itemCount: nightWorks.data?.length ?? 0,
                itemBuilder: (c, i) => WorkCard(
                  dailyWorkData: nightWorks.data![i],
                  onTap: () => onTapWork(nightWorks.data![i]),
                ),
              ),
            ],
          );
  }

  Widget _getWorksAfterNightListView(DailyWorkModel? work, ThemeData theme) {
    return work == null || work.data!.isEmpty
        ? const SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "اعمال السحر",
                  style: theme.textTheme.bodyLarge!,
                ),
              ),
              ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (c, i) => const SizedBox(height: 0),
                itemCount: work.data?.length ?? 0,
                itemBuilder: (c, i) => WorkCard(
                  dailyWorkData: work.data![i],
                  onTap: () => onTapWork(work.data![i]),
                ),
              ),
            ],
          );
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
