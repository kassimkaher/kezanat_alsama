import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/src/admin/pages/work/add_work_page.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/main_app/home/daily_work/logic/daily_work_logic/daily_work_cubit.dart';
import 'package:ramadan/src/main_app/widgets/work_card.dart';
import 'package:ramadan/utils/utils.dart';

class AllDailyWorkView extends StatelessWidget {
  const AllDailyWorkView({super.key});

  @override
  Widget build(BuildContext context) {
    final dailyWorkCubit = context.read<DailyWorkCubit>();
    // final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(LucideIcons.plus),
        onPressed: () => showAdaptiveDialog(
            context: context, builder: (c) => const AddWorkPage()),
      ),
      body: BlocBuilder<DailyWorkCubit, DailyWorkState>(
          builder: (context, state) => switch (state.datastatus) {
                DataStatus.loading || DataStatus.ideal => ListView.separated(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    itemBuilder: (c, i) => const WorkCardPlaceHolder(),
                    separatorBuilder: (c, i) => const SizedBox(height: 0),
                    itemCount: 4),
                DataStatus.success => ListView.separated(
                    padding: const EdgeInsets.all(16),
                    // shrinkWrap: true,
                    separatorBuilder: (c, i) => const SizedBox(height: 0),
                    itemCount: state.allDailyWorkModel?.data?.length ?? 0,
                    itemBuilder: (c, i) => WorkCard(
                      dailyWorkData: state.allDailyWorkModel!.data![i],
                      ondelete: () {
                        dailyWorkCubit
                            .deletWork(state.allDailyWorkModel!.data![i].id!);
                      },
                    ),
                  ),
                _ => Text("error")
              }),
    );
  }
}
