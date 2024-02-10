import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/bussines_logic/prayer/prayer_cubit.dart';
import 'package:ramadan/bussines_logic/prayer/model/prayer_model.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/utils/utils.dart';

class PrayerTimesTodayDialog extends HookWidget {
  const PrayerTimesTodayDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final select = useState<PrayerTimesEntity?>(null);
    final theme = Theme.of(context);
    return BlocBuilder<PrayerCubit, PrayerState>(
      builder: (context, state) {
        return state.datastatus == DataStatus.success
            ? SingleChildScrollView(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  children: state.preyerTimes!.days!
                      .map(
                        (data) => Card(
                          margin: const EdgeInsets.symmetric(vertical: 3),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            height: select.value == data ? 350 : 50,
                            child: ListView(
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: Row(
                                    children: [
                                      const SizedBox(width: kDefaultSpacing),
                                      const Icon(
                                        LucideIcons.calendar,
                                        size: 20,
                                        color: jbSecondary,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "${dayName[data.dayname! - 1]}  ",
                                        style: theme.textTheme.titleSmall,
                                      ),
                                      const Spacer(),
                                      Text(
                                        "${data.day}/ ${data.month}",
                                        style: theme.textTheme.displaySmall,
                                      ),
                                      IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () => select.value == data
                                              ? select.value = null
                                              : select.value = data,
                                          icon: Icon(select.value == data
                                              ? LucideIcons.chevronUp
                                              : LucideIcons.chevronDown))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height: 300,
                                    child: TimesCard(theme: theme, data: data))
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              )
            : const SizedBox();
      },
    );
  }
}

class TimesCard extends StatelessWidget {
  const TimesCard({super.key, required this.theme, required this.data});

  final ThemeData theme;
  final PrayerTimesEntity data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          height: 0,
        ),
        // ListTile(
        //   dense: true,
        //   title: "الامساك".toGradiant(colors: [
        //     theme.textTheme.titleLarge!.color!,
        //     theme.textTheme.bodySmall!.color!
        //   ], style: theme.textTheme.titleSmall!),
        //   trailing:
        //       "${data.emsak!.minut!.toString().arabicNumber} : ${data.emsak!.hour!.toString().arabicNumber} ص"
        //           .toGradiant(colors: [
        //     theme.textTheme.titleLarge!.color!,
        //     theme.textTheme.bodySmall!.color!
        //   ], style: theme.textTheme.titleMedium!),
        // ),
        ListTile(
          dense: true,
          title: "الصبح".toGradiant(colors: [
            theme.textTheme.titleLarge!.color!,
            theme.textTheme.bodySmall!.color!
          ], style: theme.textTheme.titleSmall!),
          trailing:
              "${data.fajer!.minut!.toString().arabicNumber} : ${data.fajer!.hour!.toString().arabicNumber} ص"
                  .toGradiant(colors: [
            theme.textTheme.titleLarge!.color!,
            theme.textTheme.bodySmall!.color!
          ], style: theme.textTheme.titleMedium!),
        ),
        ListTile(
          dense: true,
          title: "الشروق".toGradiant(colors: [
            theme.textTheme.titleLarge!.color!,
            theme.textTheme.bodySmall!.color!
          ], style: theme.textTheme.titleSmall!),
          trailing:
              "${data.sunrise!.minut!.toString().arabicNumber} : ${data.sunrise!.hour!.toString().arabicNumber} ص"
                  .toGradiant(colors: [
            theme.textTheme.titleLarge!.color!,
            theme.textTheme.bodySmall!.color!
          ], style: theme.textTheme.titleMedium!),
        ),
        ListTile(
          dense: true,
          title: "الظهر".toGradiant(colors: [
            theme.textTheme.titleLarge!.color!,
            theme.textTheme.bodySmall!.color!
          ], style: theme.textTheme.titleSmall!),
          trailing:
              "${data.duhur!.minut!.toString().arabicNumber} : ${data.duhur!.hour!.toString().arabicNumber} م"
                  .toGradiant(colors: [
            theme.textTheme.titleLarge!.color!,
            theme.textTheme.bodySmall!.color!
          ], style: theme.textTheme.titleMedium!),
        ),
        ListTile(
          dense: true,
          title: "المغرب".toGradiant(colors: [
            theme.textTheme.titleLarge!.color!,
            theme.textTheme.bodySmall!.color!
          ], style: theme.textTheme.titleSmall!),
          trailing:
              "${data.magrib!.minut!.toString().arabicNumber} : ${(data.magrib!.hour! > 12 ? data.magrib!.hour! - 12 : data.magrib!.hour!).toString().arabicNumber} م"
                  .toGradiant(colors: [
            theme.textTheme.titleLarge!.color!,
            theme.textTheme.bodySmall!.color!
          ], style: theme.textTheme.titleMedium!),
        ),
        ListTile(
          dense: true,
          title: "منتصف الليل".toGradiant(colors: [
            theme.textTheme.titleLarge!.color!,
            theme.textTheme.bodySmall!.color!
          ], style: theme.textTheme.titleSmall!),
          trailing:
              "${data.middileNight!.minut!.toString().arabicNumber} : ${(data.middileNight!.hour! > 12 ? data.middileNight!.hour! - 12 : data.middileNight!.hour!).toString().arabicNumber} م"
                  .toGradiant(colors: [
            theme.textTheme.titleLarge!.color!,
            theme.textTheme.bodySmall!.color!
          ], style: theme.textTheme.titleMedium!),
        ),
      ],
    );
  }
}
