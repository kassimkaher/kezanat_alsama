import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/bussines_logic/Setting/cubit/setting_cubit.dart';
import 'package:ramadan/src/main_app/home/presentation/widgets/prayer_card.dart';

import 'package:ramadan/utils/utils.dart';

class PrayerTimesView extends StatefulWidget {
  const PrayerTimesView({
    super.key,
  });

  @override
  State<PrayerTimesView> createState() => _PrayerTimesViewState();
}

class _PrayerTimesViewState extends State<PrayerTimesView> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final SettingCubit settingCubit = context.read<SettingCubit>();
    return InkWell(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: BlocBuilder<PrayerCubit, PrayerState>(
          builder: (context, state) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: isExpanded ? 440 : 80,
                width: size.width,
                margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  border: Border.all(
                      color: isExpanded
                          ? theme.colorScheme.outline
                          : Colors.transparent),
                  gradient: LinearGradient(
                      colors: isExpanded
                          ? [theme.canvasColor, theme.scaffoldBackgroundColor]
                          : [
                              theme.colorScheme.tertiary,
                              theme.colorScheme.tertiaryContainer
                            ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: isExpanded ? 0 : null,
                        width: isExpanded ? 1 : null,
                        child: Row(
                          children: [
                            const Icon(
                              LucideIcons.moon,
                              color: Colors.white,
                              size: 25,
                            ),
                            const SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.nextTime?.title ?? "",
                                  style: theme.textTheme.titleMedium!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  state.nextTime?.timeText ?? "",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      height: 0.8,
                                      fontWeight: FontWeight.w500),
                                ),
                                // Row(
                                //   children: [
                                //     const Icon(
                                //       LucideIcons.mapPin,
                                //       color: Colors.white70,
                                //       size: 20,
                                //     ),
                                //     const SizedBox(width: 5),
                                //     Text(
                                //       city.nameAr ?? "",
                                //       style: theme.textTheme.displaySmall!
                                //           .copyWith(color: Colors.white70, fontSize: 16),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                            const Spacer(),
                            state.nextTime == null
                                ? const SizedBox()
                                : CircularProgresTimer(
                                    time: state.nextTime?.timeText ?? "",
                                    stayTime: state.nextTime!.staytimeText,
                                    value: 1 - state.nextTime!.progress,
                                    isKnow: state.nextTime!.isKnow,
                                  ),
                          ],
                        ),
                      ),
                      PrayerCard(
                          onPressed: () => setState(() {
                                isExpanded = false;
                              }),
                          theme: theme,
                          data: state.currentDay,
                          city:
                              settingCubit.state.setting!.selectCity!.nameAr ??
                                  ""),
                    ],
                  ),
                ),
              )),
    );
  }
}

class CircularProgresTimer extends StatelessWidget {
  const CircularProgresTimer(
      {super.key,
      required this.time,
      required this.value,
      required this.stayTime,
      required this.isKnow});
  final String time;
  final String stayTime;
  final double value;
  final bool isKnow;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      width: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: theme.colorScheme.onTertiary),
      child: isKnow
          ? const Text(
              "حان الموعد",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            )
          : Text(
              stayTime,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
    );
  }
}
