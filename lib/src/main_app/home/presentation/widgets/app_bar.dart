import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/pages/setting_page.dart';
import 'package:ramadan/src/admin/logic/calendar_cubit/calendar_cubit.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/utils/utils.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: DateWidget()),
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: const Icon(
              LucideIcons.settings2,
              color: Colors.white,
            ),
            onPressed: () => Navigator.push(context, to(const SettingPage())),
          ),
        )
      ],
    );
  }
}

class DateWidget extends StatefulWidget {
  const DateWidget({super.key, this.size = 45});

  final double size;

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  late CalendarCubit calendarCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calendarCubit = context.read<CalendarCubit>();
    calendarCubit.getCalendar();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        return state.datastatus != DataStatus.success
            ? const SizedBox(
                height: 25,
              )
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.today?.hijreeDay?.toString().arabicNumber ?? "",
                      style: theme.textTheme.titleSmall!
                          .copyWith(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      "  ".arabicNumber,
                      style: theme.textTheme.titleMedium!.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      state.today?.hijreYear.toString().arabicNumber ?? "",
                      style: theme.textTheme.titleSmall!
                          .copyWith(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      state.today?.hijreeMonthName ?? "",
                      style: theme.textTheme.titleSmall!
                          .copyWith(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
