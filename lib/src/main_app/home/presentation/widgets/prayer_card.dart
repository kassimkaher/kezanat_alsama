import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/alert/alert_desition.dart';
import 'package:ramadan/bussines_logic/prayer/model/prayer_model.dart';
import 'package:ramadan/src/core/widget/jb_button.dart';
import 'package:ramadan/src/main_app/widgets/custom_card.dart';
import 'package:ramadan/src/main_app/home/presentation/widgets/today_prayer_times_dialog.dart';
import 'package:ramadan/utils/extention.dart';
import 'package:ramadan/utils/utils.dart';

class PrayerCard extends StatelessWidget {
  const PrayerCard(
      {super.key, required this.theme, this.data, required this.city});

  final ThemeData theme;
  final PrayerTimesEntity? data;
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
              child: const PrayerTimesTodayDialog(),
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
