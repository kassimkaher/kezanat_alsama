import 'package:ramadan/src/admin/logic/work_cubit/work_crud_cubit.dart';
import 'package:ramadan/src/admin/pages/work/work_admin_view.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/utils/injector.dart';
import 'package:ramadan/utils/utils.dart';

class WorkAdminPage extends StatefulWidget {
  const WorkAdminPage({super.key});

  @override
  State<WorkAdminPage> createState() => _WorkAdminPageState();
}

class _WorkAdminPageState extends State<WorkAdminPage> {
  late WorkCrudCubit workCrudCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    workCrudCubit = getIt<WorkCrudCubit>();

    if (workCrudCubit.state.dataStatus != const SateSucess()) {
      workCrudCubit.getWorkData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: workCrudCubit,
      child: const WorkAdminView(),
    );
  }
}
