import 'package:ramadan/services/tasbeeh/cubit/tasbeeh_cubit.dart';
import 'package:ramadan/services/tasbeeh/entity/model/tasbeeh_model.dart';
import 'package:ramadan/services/tasbeeh/presentation/tasbeeh_view.dart';
import 'package:ramadan/utils/utils.dart';

class TasbeehPage extends StatefulWidget {
  const TasbeehPage({super.key, required this.tasbeehModel});

  final TasbeehModel tasbeehModel;
  @override
  _TasbeehPageState createState() => _TasbeehPageState();
}

class _TasbeehPageState extends State<TasbeehPage> {
  late ScrollController scontroller;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          TasbeehCubit(tasbeehModel: widget.tasbeehModel),
      child: const TasbeehView(),
    );
  }
}
