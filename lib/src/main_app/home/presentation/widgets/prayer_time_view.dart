import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/src/main_app/home/presentation/widgets/prayer_card.dart';

import 'package:ramadan/utils/utils.dart';

class PrayerTimesView extends StatelessWidget {
  const PrayerTimesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final SettingCubit settingCubit = context.read<SettingCubit>();
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          useSafeArea: true,
          context: context,
          builder: (c) => BlocBuilder<PrayerCubit, PrayerState>(
            builder: (context, state) {
              return Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: PrayerCard(
                    theme: theme,
                    data: state.currentDay,
                    city: settingCubit
                            .state.setting.setting!.selectCity!.nameAr ??
                        ""),
              );
            },
          ),
        );
      },
      child: Container(
        height: 70,
        width: size.width,
        margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: theme.primaryColor,
          gradient: LinearGradient(
              colors: [const Color(0xff4f6d7a), theme.primaryColor],
              begin: Alignment.topRight,
              end: Alignment.bottomCenter),
          borderRadius: BorderRadius.circular(20),
        ),
        child: BlocBuilder<PrayerCubit, PrayerState>(
          builder: (context, state) {
            return Row(
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
                          color: Colors.white, fontWeight: FontWeight.w400),
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
            );
          },
        ),
      ),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Color(0xff0C7E82)),
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
