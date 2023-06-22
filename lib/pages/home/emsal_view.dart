import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/alert/alert_desition.dart';
import 'package:ramadan/bussines_logic/prayer/prayer_cubit.dart';
import 'package:ramadan/model/prayer_model.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:ramadan/widget/jb_button.dart';

class EmsackCalendarList extends HookWidget {
  const EmsackCalendarList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final select = useState<DaysPrayerTimes?>(null);
    final theme = Theme.of(context);
    return BlocBuilder<PrayerCubit, PrayerState>(
      builder: (context, state) {
        return state is PrayerStateLoaded
            ? SingleChildScrollView(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  children: state.info.preyerTimes!.days!
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
  final DaysPrayerTimes data;
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

class PrayerCard extends StatelessWidget {
  const PrayerCard(
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
              title: "اوقات الصلاة",
              child: const EmsackCalendarList(),
            ),
            child: RCard(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  Text("اوقات الصلاة ", style: theme.textTheme.bodyLarge),
                  const Divider(),
                  ListTile(
                    dense: true,
                    horizontalTitleGap: 0,
                    contentPadding: EdgeInsets.zero,
                    leading: const SizedBox(
                      height: 20,
                      width: 20,
                      child: Icon(LucideIcons.moon),
                    ),
                    title: " الصبح".toGradiant(
                        style: theme.textTheme.titleSmall!,
                        colors: [
                          theme.textTheme.titleLarge!.color!,
                          theme.textTheme.bodySmall!.color!
                        ]),
                    trailing:
                        "${data!.fajer!.minut!.toString().arabicNumber} : ${data!.fajer!.hour!.toString().arabicNumber} ص"
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
                    leading: const SizedBox(
                      height: 20,
                      width: 20,
                      child: Icon(
                        LucideIcons.sunrise,
                        color: Colors.amberAccent,
                      ),
                    ),
                    title: "الشروق".toGradiant(
                        style: theme.textTheme.titleSmall!,
                        colors: [
                          theme.textTheme.titleLarge!.color!,
                          theme.textTheme.bodySmall!.color!
                        ]),
                    trailing:
                        "${data!.sunrise!.minut!.toString().arabicNumber} : ${data!.sunrise!.hour!.toString().arabicNumber} ص"
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
                    leading: const SizedBox(
                      height: 20,
                      width: 20,
                      child: Icon(
                        LucideIcons.sun,
                        color: Colors.amber,
                      ),
                    ),
                    title: "الظهر".toGradiant(
                        style: theme.textTheme.titleSmall!,
                        colors: [
                          theme.textTheme.titleLarge!.color!,
                          theme.textTheme.bodySmall!.color!
                        ]),
                    trailing:
                        "${data!.duhur!.minut!.toString().arabicNumber} : ${data!.duhur!.hour!.toString().arabicNumber} ${data!.duhur!.hour! > 11 ? "م" : "ص"}"
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
                    leading: const SizedBox(
                      height: 20,
                      width: 20,
                      child: Icon(LucideIcons.sunset),
                    ),
                    title: "الغروب".toGradiant(
                        style: theme.textTheme.titleSmall!,
                        colors: [
                          theme.textTheme.titleLarge!.color!,
                          theme.textTheme.bodySmall!.color!
                        ]),
                    trailing:
                        "${data!.sunset!.minut!.toString().arabicNumber} : ${(data!.sunset!.hour! > 12 ? data!.sunset!.hour! - 12 : data!.sunset!.hour!).toString().arabicNumber} م"
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
                    leading: const SizedBox(
                      height: 20,
                      width: 20,
                      child: Icon(
                        LucideIcons.sunMoon,
                        color: Colors.blueGrey,
                      ),
                    ),
                    title: "المغرب".toGradiant(
                        style: theme.textTheme.titleSmall!,
                        colors: [
                          theme.textTheme.titleLarge!.color!,
                          theme.textTheme.bodySmall!.color!
                        ]),
                    trailing:
                        "${data!.magrib!.minut!.toString().arabicNumber} : ${(data!.magrib!.hour! > 12 ? data!.magrib!.hour! - 12 : data!.magrib!.hour!).toString().arabicNumber} م"
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
                    leading: const SizedBox(
                      height: 20,
                      width: 20,
                      child: Icon(
                        LucideIcons.moon,
                        color: Colors.black87,
                      ),
                    ),
                    title: "منتصف الليل".toGradiant(
                        style: theme.textTheme.titleSmall!,
                        colors: [
                          theme.textTheme.titleLarge!.color!,
                          theme.textTheme.bodySmall!.color!
                        ]),
                    trailing:
                        "${data!.middileNight!.minut!.toString().arabicNumber} : ${(data!.middileNight!.hour! - 12).toString().arabicNumber} م"
                            .toGradiant(
                                style: theme.textTheme.titleSmall!
                                    .copyWith(letterSpacing: .4),
                                colors: [
                          theme.textTheme.titleLarge!.color!,
                          theme.textTheme.bodySmall!.color!
                        ]),
                  ),
                  const Divider(),
                  JBButton(
                    title: "عودة",
                    backgroundColor: theme.primaryColor,
                    onPressed: () => Navigator.pop(context),
                  )
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
      this.width,
      this.borderRadius});

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? background;
  final double? height;
  final double? width;
  final double? borderRadius;
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
        borderRadius:
            BorderRadius.circular(borderRadius ?? kDefaultBorderRadius),
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
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding:
          const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 5),
      decoration: BoxDecoration(
        // color: theme.primaryColor,
        // gradient: LinearGradient(colors: [
        //   theme.textTheme.titleLarge!.color!,
        //   theme.cardColor,
        // ], transform: const GradientRotation(0.8)),
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "1444".arabicNumber,
            style: theme.textTheme.titleLarge!.copyWith(
                color: theme.colorScheme.secondary,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          Text(
            " / ".arabicNumber,
            style: theme.textTheme.titleLarge!.copyWith(
              fontSize: 30,
            ),
          ),
          // Text(
          //   true ? "٣".arabicNumber : number.toString().arabicNumber,
          //   style: theme.textTheme.titleLarge!.copyWith(
          //     fontSize: 30,
          //   ),
          // ),
          Text(
            " ٣ شوال ",
            style: theme.textTheme.titleLarge!.copyWith(
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}
