import 'package:ramadan/src/main_app/home/daily_work/logic/navigator_cubit/navigator_cubit.dart'
    as cu;
import 'package:ramadan/utils/utils.dart';

class WorkTaps extends StatefulWidget {
  const WorkTaps({super.key, required this.keys});
  final List<GlobalKey> keys;

  @override
  State<WorkTaps> createState() => _WorkTapsState();
}

class _WorkTapsState extends State<WorkTaps> {
  late cu.NavigatorCubit navigatorCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigatorCubit = cu.NavigatorCubit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    ;
    return BlocProvider.value(
      value: navigatorCubit,
      child: BlocConsumer<cu.NavigatorCubit, cu.NavigatorState>(
        bloc: navigatorCubit,
        listener: (c, s) {
          Scrollable.ensureVisible(widget.keys[s.selected].currentContext!,
              alignment: 0.4);
        },
        builder: (context, state) {
          return Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: theme.scaffoldBackgroundColor),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ["الاعمال اليومية", "اعمال الشهر", "مناسبات"]
                      .asMap()
                      .map((i, e) => MapEntry(
                            i,
                            InkWell(
                              onTap: () {
                                // dailyWorkCubit.getDailyWork();

                                navigatorCubit.changeSelected(i);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                height: 40,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: state.selected == i
                                        ? jbAccesntPrimaryColor
                                        : Colors.transparent),
                                child: Text(
                                  e,
                                  style: theme.textTheme.bodySmall!.copyWith(
                                      color: state.selected == i
                                          ? Colors.white
                                          : jbAccesntPrimaryColor,
                                      fontWeight: state.selected == i
                                          ? FontWeight.w600
                                          : FontWeight.w500),
                                ),
                              ),
                            ),
                          ))
                      .values
                      .toList()));
        },
      ),
    );
  }
}
