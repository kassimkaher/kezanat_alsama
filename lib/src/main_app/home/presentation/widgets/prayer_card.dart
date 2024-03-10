import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/bussines_logic/prayer/model/prayer_model.dart';
import 'package:ramadan/src/core/widget/jb_button_mix.dart';
import 'package:ramadan/src/main_app/home/presentation/widgets/today_prayer_times_dialog.dart';

import 'package:ramadan/utils/utils.dart';

class PrayerCard extends StatelessWidget {
  const PrayerCard(
      {super.key,
      required this.theme,
      this.data,
      required this.city,
      required this.onPressed});

  final ThemeData theme;
  final PrayerTimesEntity? data;
  final String city;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return data == null
        ? const SizedBox()
        : Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              Row(
                children: [
                  Text("مواقيت الصلاة", style: theme.textTheme.bodyLarge),
                  const Spacer(),
                  IconButton(
                      onPressed: onPressed, icon: const Icon(LucideIcons.x))
                ],
              ),
              const Divider(),
              ListTile(
                dense: true,
                horizontalTitleGap: 0,
                contentPadding: EdgeInsets.zero,
                leading: SizedBox(
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset("assets/svg/morning.svg")),
                title: " صلاة الصبح".toGradiant(
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
              data?.emsak == null
                  ? const SizedBox()
                  : ListTile(
                      dense: true,
                      horizontalTitleGap: 0,
                      contentPadding: EdgeInsets.zero,
                      leading: SizedBox(
                          height: 30,
                          width: 30,
                          child: SvgPicture.asset("assets/svg/morning.svg")),
                      title: "الامساك".toGradiant(
                          style: theme.textTheme.titleSmall!,
                          colors: [
                            theme.textTheme.titleLarge!.color!,
                            theme.textTheme.bodySmall!.color!
                          ]),
                      trailing:
                          "${data!.emsak!.minut!.toString().arabicNumber} : ${data!.emsak!.hour!.toString().arabicNumber} ص"
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
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset("assets/svg/sunrise.svg")),
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
                leading: SizedBox(
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset("assets/svg/aftermoon.svg")),
                title: "صلاة الظهر".toGradiant(
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
              // ListTile(
              //   dense: true,
              //   horizontalTitleGap: 0,
              //   contentPadding: EdgeInsets.zero,
              //   leading: SizedBox(
              //       height: 30,
              //       width: 30,
              //       child: SvgPicture.asset("assets/svg/sunset.svg")),
              //   title: "الغروب".toGradiant(
              //       style: theme.textTheme.titleSmall!,
              //       colors: [
              //         theme.textTheme.titleLarge!.color!,
              //         theme.textTheme.bodySmall!.color!
              //       ]),
              //   trailing:
              //       "${data!.sunset!.minut!.toString().arabicNumber} : ${(data!.sunset!.hour! > 12 ? data!.sunset!.hour! - 12 : data!.sunset!.hour!).toString().arabicNumber} م"
              //           .toGradiant(
              //               style: theme.textTheme.titleSmall!
              //                   .copyWith(letterSpacing: .4),
              //               colors: [
              //         theme.textTheme.titleLarge!.color!,
              //         theme.textTheme.bodySmall!.color!
              //       ]),
              // ),
              ListTile(
                dense: true,
                horizontalTitleGap: 0,
                contentPadding: EdgeInsets.zero,
                leading: SizedBox(
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset("assets/svg/mugrib.svg")),
                title: "صلاة المغرب".toGradiant(
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
                leading: SizedBox(
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset("assets/svg/half_night.svg")),
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
              Divider(
                color: theme.textTheme.bodyLarge!.color,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  JBButtonMix(
                    title: "عرض مواقيت الصلاة",
                    icon: const Icon(
                      LucideIcons.calendar,
                      size: 20,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    backgroundColor: theme.primaryColor.withOpacity(0.2),
                    color: theme.primaryColor,
                    onPressed: () {
                      showAdaptiveDialog(
                        context: context,
                        builder: (context) => const PrayerTimesTodayDialog(),
                      );
                      // showAdaptiveDialog(
                      //   context: context,
                      //   builder: (c) => ClipRRect(
                      //     borderRadius: BorderRadius.circular(16),
                      //     child: const CitiesPage(),
                      //   ),
                      // );
                    },
                  ),
                ],
              )
            ],
          );
  }
}
