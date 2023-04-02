import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/alert/alert_desition.dart';
import 'package:ramadan/bussines_logic/Setting/settings_cubit.dart';
import 'package:ramadan/bussines_logic/ramadan/ramadan_cubit.dart';
import 'package:ramadan/model/emsak.dart';
import 'package:ramadan/pages/home/emsal_view.dart';
import 'package:ramadan/pages/home/text_display.dart';
import 'package:ramadan/pages/setting_page.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:ramadan/widget/timer_progres.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settingController = context.read<SettingCubit>();

    return BlocBuilder<RamadanCubit, RamadanState>(
      builder: (context, state) {
        return SafeArea(
          bottom: false,
          child: Container(
            decoration: const BoxDecoration(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 0, bottom: 100),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            DayView(number: state.info.dayNumber),
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                icon: Icon(
                                  LucideIcons.settings,
                                  color: theme.disabledColor,
                                ),
                                onPressed: () => Navigator.push(
                                    context, to(const SettingPage())),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(width: 20),
                        " رمضان".toGradiant(
                            style: theme.textTheme.displayMedium!.copyWith(
                                color: jbSecondary,
                                fontSize: 50,
                                fontWeight: FontWeight.bold),
                            colors: [
                              theme.colorScheme.onSecondary,
                              theme.colorScheme.secondary
                            ]),
                      ],
                    )),
                    const SizedBox(height: kDefaultSpacing),
                    HomeTopCard(
                        data: state.info,
                        city: settingController
                                .state.setting.setting!.selectCity?.name ??
                            ""),
                    const SizedBox(height: kDefaultSpacing),
                    EmsakyaCard(
                        theme: theme,
                        data: state.info.currentDay,
                        city: settingController
                                .state.setting.setting!.selectCity?.name ??
                            ""),
                    const SizedBox(height: kDefaultSpacing),
                    state.info.todayPrayer != null
                        ? ListTile(
                            title: Text(
                              "اعمال اليوم",
                              style: theme.textTheme.displaySmall!
                                  .copyWith(fontSize: 16),
                            ),
                            subtitle: SingleChildScrollView(
                              padding: const EdgeInsets.only(right: 0, top: 5),
                              scrollDirection: Axis.horizontal,
                              child: Wrap(
                                children: state.info.todayPrayer!.amaoOfToday!
                                    .asMap()
                                    .map(
                                      (i, e) => MapEntry(
                                        i,
                                        e.type != "SALA"
                                            ? InkWell(
                                                onTap: () => Navigator.push(
                                                  context,
                                                  to(
                                                    TextDisplay(
                                                      data: e,
                                                      index: i,
                                                    ),
                                                  ),
                                                ),
                                                child: Card(
                                                    child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 16,
                                                      vertical: 5),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/svg/dua.svg",
                                                        height: 20,
                                                        color: jbSecondary,
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Text(
                                                        e.title ?? "",
                                                        style: theme.textTheme
                                                            .titleSmall,
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                              )
                                            : const SizedBox(),
                                      ),
                                    )
                                    .values
                                    .toList(),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: kDefaultSpacing),
                    state.info.todayPrayer != null
                        ? ListTile(
                            subtitle: RCard(
                                padding: EdgeInsets.all(kDefaultSpacing),
                                child: Wrap(
                                    children:
                                        state.info.todayPrayer!.amaoOfToday!
                                            .asMap()
                                            .map((i, e) => MapEntry(
                                                i,
                                                e.type == "SALA"
                                                    ? Text(
                                                        e.text!,
                                                        style: theme.textTheme
                                                            .bodyMedium,
                                                      )
                                                    : const SizedBox()))
                                            .values
                                            .toList())),
                          )
                        : const SizedBox(),
                  ]),
            ),
          ),
        );
      },
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
  const RCard({super.key, required this.child, this.margin, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          color: theme.primaryColor == jbPrimaryColor
              ? Colors.white70
              : theme.cardColor,
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
          boxShadow: [
            BoxShadow(
                color: theme.primaryColor == jbPrimaryColor
                    ? theme.colorScheme.outline
                    : Colors.transparent,
                blurRadius: 10),
          ],
        ),
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: child,
        ),
      ),
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