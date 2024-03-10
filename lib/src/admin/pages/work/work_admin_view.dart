import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/src/admin/logic/work_cubit/work_crud_cubit.dart';
import 'package:ramadan/src/admin/pages/work/add_work_page.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/core/enum/work_timing.dart';
import 'package:ramadan/src/core/enum/work_type.dart';
import 'package:ramadan/src/main_app/widgets/work_card.dart';

import 'package:ramadan/utils/utils.dart';

class WorkAdminView extends StatelessWidget {
  const WorkAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final workCrudCubit = context.read<WorkCrudCubit>();
    final theme = Theme.of(context);
    return DefaultTabController(
      length: WorkTiming.values.length + 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("الاعمال الدينية"),
          bottom: TabBar(
            labelColor: theme.primaryColor,
            isScrollable: true,
            onTap: (tab) {
              workCrudCubit.filterData(tab);
            },
            tabs: [
              Tab(
                text: "all".tr(),
              ),
              ...WorkTiming.values
                  .map(
                    (e) => Tab(
                      text: e.name.tr(),
                    ),
                  )
                  .toList()
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(LucideIcons.plus),
          onPressed: () => showAdaptiveDialog(
              context: context,
              builder: (c) => BlocProvider.value(
                    value: workCrudCubit,
                    child: const AddWorkPage(),
                  )),
        ),
        body: BlocBuilder<WorkCrudCubit, WorkCrudState>(
            builder: (context, state) => switch (state.dataStatus) {
                  StateLoading() ||
                  DataIdeal() when (state.worksData == null) =>
                    ListView.separated(
                        padding: const EdgeInsets.all(16),
                        shrinkWrap: true,
                        itemBuilder: (c, i) => const WorkCardPlaceHolder(),
                        separatorBuilder: (c, i) => const SizedBox(height: 0),
                        itemCount: 4),
                  const StateError() => Text("Error"),
                  _ => ListView.separated(
                      padding: const EdgeInsets.all(16),
                      // shrinkWrap: true,
                      separatorBuilder: (c, i) => const SizedBox(height: 0),
                      itemCount: state.workListModel?.data?.length ?? 0,
                      itemBuilder: (c, i) => state
                                  .workListModel!.data![i].type ==
                              WorkType.relationship
                          ? const SizedBox()
                          : WorkCard(
                              dailyWorkData: state.workListModel!.data![i],
                              whenDeleting: state.dataStatus is StateLoading &&
                                  state.dataStatus.data ==
                                      state.workListModel!.data![i].id,
                              ondelete: () {
                                workCrudCubit.deletWork(
                                    state.workListModel!.data![i].id!);
                              },
                              onTap: () => showAdaptiveDialog(
                                  context: context,
                                  builder: (c) => BlocProvider.value(
                                        value: workCrudCubit,
                                        child: AddWorkPage(
                                          dailyWorkData:
                                              state.workListModel!.data![i],
                                        ),
                                      )),
                            ),
                    ),
                }),
      ),
    );
  }
}
