import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/src/main_app/home/daily_work/logic/navigator_cubit/navigator_cubit.dart';
import 'package:ramadan/src/main_app/home/daily_work/page/work_of_month.dart';
import 'package:ramadan/utils/utils.dart';

class WorkTaps extends StatefulWidget {
  const WorkTaps({super.key, required this.keys});
  final List<GlobalKey> keys;

  @override
  State<WorkTaps> createState() => _WorkTapsState();
}

class _WorkTapsState extends State<WorkTaps> {
  late NavigatorCubit navigatorCubit;
  @override
  void initState() {
    super.initState();
    navigatorCubit = context.read<NavigatorCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<NavigatorCubit, NavigatorCubitState>(
      bloc: navigatorCubit,
      listener: (c, s) {
        // Scrollable.ensureVisible(widget.keys[s.selected].currentContext!,
        //     alignment: 0.4);
      },
      builder: (context, state) {
        return Container(
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: theme.canvasColor,
            border: Border.all(color: theme.colorScheme.outline),
            // boxShadow: [
            //   BoxShadow(
            //     color: theme.disabledColor,
            //     blurRadius: 1,
            //     spreadRadius: -1,
            //     blurStyle: BlurStyle.inner,
            //   )
            // ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...[
                "الاعمال اليومية",
                "اعمال الليلة",
                "مناسبات",
              ]
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
                            padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                      : theme.primaryColorDark,
                                  fontWeight: state.selected == i
                                      ? FontWeight.w600
                                      : FontWeight.w500),
                            ),
                          ),
                        ),
                      ))
                  .values
                  .toList(),
              IconButton(
                  onPressed: () => showAdaptiveDialog(
                      context: context,
                      builder: (context) => const WorkOfMonthView()),
                  icon: const Icon(LucideIcons.list))
            ],
          ),
        );
      },
    );
  }
}
