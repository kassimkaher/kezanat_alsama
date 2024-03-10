import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/src/admin/logic/work_cubit/work_crud_cubit.dart';
import 'package:ramadan/src/admin/pages/relationships/add_relationships_page.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/core/enum/work_type.dart';
import 'package:ramadan/src/main_app/widgets/work_card.dart';
import 'package:ramadan/utils/utils.dart';

class RelationAdminView extends StatelessWidget {
  const RelationAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final dailyWorkCubit = context.read<WorkCrudCubit>();
    // final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("مناسبات"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(LucideIcons.plus),
        onPressed: () => showAdaptiveDialog(
            context: context,
            builder: (c) => BlocProvider.value(
                  value: dailyWorkCubit,
                  child: const AddRelationshipsPage(),
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
                const StateError() => const Text("Error"),
                _ => ListView.separated(
                    padding: const EdgeInsets.all(16),
                    // shrinkWrap: true,
                    separatorBuilder: (c, i) => const SizedBox(height: 0),
                    itemCount: state.workListModel?.data?.length ?? 0,
                    itemBuilder: (c, i) => state.workListModel!.data![i].type !=
                            WorkType.relationship
                        ? const SizedBox()
                        : WorkCard(
                            dailyWorkData: state.workListModel!.data![i],
                            whenDeleting: state.dataStatus is StateLoading &&
                                state.dataStatus.data ==
                                    state.workListModel!.data![i].id,
                            ondelete: () {
                              dailyWorkCubit.deletRelation(
                                  state.workListModel!.data![i].id!);
                            },
                            onTap: () => showAdaptiveDialog(
                                context: context,
                                builder: (c) => BlocProvider.value(
                                      value: dailyWorkCubit,
                                      child: AddRelationshipsPage(
                                        dailyWorkData:
                                            state.workListModel!.data![i],
                                      ),
                                    )),
                          ),
                  ),
              }),
    );
  }
}
