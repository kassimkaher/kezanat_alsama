import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/alert/alert_desition.dart';
import 'package:ramadan/bussines_logic/Setting/settings_cubit.dart';
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

class EmsakyaCard extends StatelessWidget {
  const EmsakyaCard(
      {super.key, required this.theme, this.data, required this.city});

  final ThemeData theme;
  final DaysPrayerTimes? data;
  final String city;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return data == null
        ? const SizedBox()
        : InkWell(
            onTap: () => KDAlert.showSheet(
              context,
              height: size.height * 0.935,
              width: size.width,
              title: "الامساكية",
              child: const EmsackCalendarList(),
            ),
            child: RCard(
              margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                children: [
                  ListTile(
                    dense: true,
                    horizontalTitleGap: 0,
                    contentPadding: EdgeInsets.zero,
                    leading: SizedBox(
                      height: 20,
                      width: 20,
                      child: SvgPicture.asset(
                        "assets/svg/emsak.svg",
                        width: 20,
                        color: theme.primaryColor,
                      ),
                    ),
                    title: "الامساك".toGradiant(
                        style: theme.textTheme.titleSmall!,
                        colors: [
                          theme.textTheme.titleLarge!.color!,
                          theme.textTheme.bodySmall!.color!
                        ]),
                    trailing:
                        "${data!.emsak!.minut!.toString().farsiNumber} : ${data!.emsak!.hour!.toString().farsiNumber} ص"
                            .toGradiant(
                                style: theme.textTheme.titleSmall!
                                    .copyWith(letterSpacing: .4),
                                colors: [
                          theme.textTheme.titleLarge!.color!,
                          theme.textTheme.bodySmall!.color!
                        ]),
                  ),
                  ListTile(
                    dense: true,
                    horizontalTitleGap: 0,
                    contentPadding: EdgeInsets.zero,
                    leading: SizedBox(
                      height: 20,
                      width: 20,
                      child: SvgPicture.asset(
                        "assets/svg/fajer.svg",
                        width: 20,
                        color: theme.primaryColor,
                      ),
                    ),
                    title: "الفجر".toGradiant(
                        style: theme.textTheme.titleSmall!,
                        colors: [
                          theme.textTheme.titleLarge!.color!,
                          theme.textTheme.bodySmall!.color!
                        ]),
                    trailing:
                        "${data!.morningPrayer!.minut!.toString().farsiNumber} : ${data!.morningPrayer!.hour!.toString().farsiNumber} ص"
                            .toGradiant(
                                style: theme.textTheme.titleSmall!
                                    .copyWith(letterSpacing: .4),
                                colors: [
                          theme.textTheme.titleLarge!.color!,
                          theme.textTheme.bodySmall!.color!
                        ]),
                  ),
                  ListTile(
                    dense: true,
                    horizontalTitleGap: 0,
                    contentPadding: EdgeInsets.zero,
                    leading: SizedBox(
                      height: 20,
                      width: 20,
                      child: SvgPicture.asset(
                        "assets/svg/night.svg",
                        width: 20,
                        color: theme.primaryColor,
                      ),
                    ),
                    title: "المغرب".toGradiant(
                        style: theme.textTheme.titleSmall!,
                        colors: [
                          theme.textTheme.titleLarge!.color!,
                          theme.textTheme.bodySmall!.color!
                        ]),
                    trailing:
                        "${data!.nightPrayer!.minut!.toString().farsiNumber} : ${(data!.nightPrayer!.hour! > 12 ? data!.nightPrayer!.hour! - 12 : data!.nightPrayer!.hour!).toString().farsiNumber} م"
                            .toGradiant(
                                style: theme.textTheme.titleSmall!
                                    .copyWith(letterSpacing: .4),
                                colors: [
                          theme.textTheme.titleLarge!.color!,
                          theme.textTheme.bodySmall!.color!
                        ]),
                  ),
                ],
              ),
            ),
          );
  }
}

class RCard extends StatelessWidget {
  const RCard(
      {super.key,
      required this.child,
      this.margin,
      this.padding,
      this.background,
      this.height,
      this.width});

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? background;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: height,
      width: width,
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: background ??
            (theme.primaryColor == jbPrimaryColor
                ? cardColor
                : theme.cardColor),
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 4),
              color: theme.primaryColor == jbPrimaryColor
                  ? theme.colorScheme.outline
                  : Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 4),
        ],
      ),
      child: child,
    );
  }
}

class ForYouCard extends StatelessWidget {
  const ForYouCard({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultSpacing),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
          border: Border.all(color: jbUnselectColor.withOpacity(0.2))),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 0,
        dense: true,
        leading: SvgPicture.asset(
          "assets/svg/dua.svg",
          width: 25,
          color: Colors.black,
        ),
        title: title.toGradiant(
            style: theme.textTheme.titleMedium!.copyWith(fontSize: 16),
            colors: [Colors.black, Colors.black]),
      ),
    );
  }
}

class DayView extends StatelessWidget {
  const DayView({super.key, required this.number, this.size = 45});

  final int number;
  final double size;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SettingCubit>();
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: size,
            maxWidth: size,
            minHeight: size,
            minWidth: size,
          ),
          child: Transform.rotate(
            angle: 18.1,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: theme.primaryColor,
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 8),
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 15),
                  ]),
              child: Transform.rotate(
                angle: -18.1,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    number.toString().farsiNumber,
                    style: theme.textTheme.displayLarge!.copyWith(
                        color: Colors.white,
                        fontSize: size - 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
