import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/bussines_logic/ramadan/ramadan_cubit.dart';
import 'package:ramadan/model/emsak.dart';
import 'package:ramadan/pages/home/home.dart';
import 'package:ramadan/utils/utils.dart';

class EmsackCalendarList extends HookWidget {
  const EmsackCalendarList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final select = useState<DaysPrayerTimes?>(null);
    final theme = Theme.of(context);
    return BlocBuilder<RamadanCubit, RamadanState>(
      builder: (context, state) {
        return state is RamadanStateLoaded
            ? SingleChildScrollView(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  children: state.info.emsackModel!.days!
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
                                Container(
                                  height: 50,
                                  child: Row(
                                    children: [
                                      const SizedBox(width: kDefaultSpacing),
                                      Icon(
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
  final DaysPrayerTimes data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          height: 0,
        ),
        ListTile(
          dense: true,
          title: "الامساك".toGradiant(colors: [
            theme.textTheme.titleLarge!.color!,
            theme.textTheme.bodySmall!.color!
          ], style: theme.textTheme.titleSmall!),
          trailing:
              "${data.emsak!.minut!.toString().farsiNumber} : ${data.emsak!.hour!.toString().farsiNumber} ص"
                  .toGradiant(colors: [
            theme.textTheme.titleLarge!.color!,
            theme.textTheme.bodySmall!.color!
          ], style: theme.textTheme.titleMedium!),
        ),
        ListTile(
          dense: true,
          title: "الفجر".toGradiant(colors: [
            theme.textTheme.titleLarge!.color!,
            theme.textTheme.bodySmall!.color!
          ], style: theme.textTheme.titleSmall!),
          trailing:
              "${data.morningPrayer!.minut!.toString().farsiNumber} : ${data.morningPrayer!.hour!.toString().farsiNumber} ص"
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
              "${data.morningSun!.minut!.toString().farsiNumber} : ${data.morningSun!.hour!.toString().farsiNumber} ص"
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
              "${data.sunPrayer!.minut!.toString().farsiNumber} : ${data.sunPrayer!.hour!.toString().farsiNumber} م"
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
              "${data.nightPrayer!.minut!.toString().farsiNumber} : ${(data.nightPrayer!.hour! > 12 ? data.nightPrayer!.hour! - 12 : data.nightPrayer!.hour!).toString().farsiNumber} م"
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
              "${data.nightHalf!.minut!.toString().farsiNumber} : ${(data.nightHalf!.hour! > 12 ? data.nightHalf!.hour! - 12 : data.nightHalf!.hour!).toString().farsiNumber} م"
                  .toGradiant(colors: [
            theme.textTheme.titleLarge!.color!,
            theme.textTheme.bodySmall!.color!
          ], style: theme.textTheme.titleMedium!),
        ),
      ],
    );
  }
}
