import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/bussines_logic/Setting/settings_cubit.dart';
import 'package:ramadan/bussines_logic/prayer/prayer_cubit.dart';
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

    return BlocBuilder<PrayerCubit, PrayerState>(
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
                    Row(
                      children: [
                        Expanded(child: DayView(number: state.info.dayNumber)),
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
                    HomeTopCard(
                        data: state.info,
                        city: settingController
                            .state.setting.setting!.selectCity!),
                    const SizedBox(height: kDefaultSpacing),
                    // (state.info.dayNumber == 18 && DateTime.now().hour > 17) ||
                    //         (state.info.dayNumber > 18 &&
                    //             state.info.dayNumber < 24)
                    //     ? Column(children: [
                    //         AlqadrCard(theme: theme),
                    //         const SizedBox(height: kDefaultSpacing),
                    //       ])
                    //     : const SizedBox(),

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
                              padding: const EdgeInsets.all(kDefaultSpacing),
                              child: Wrap(
                                children: state.info.todayPrayer!.amaoOfToday!
                                    .asMap()
                                    .map(
                                      (i, e) => MapEntry(
                                        i,
                                        e.type == "SALA"
                                            ? Text(
                                                e.text!,
                                                style:
                                                    theme.textTheme.bodyMedium,
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
                  ]),
            ),
          ),
        );
      },
    );
  }
}
