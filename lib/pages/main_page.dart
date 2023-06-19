import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ramadan/bussines_logic/Setting/settings_cubit.dart';
import 'package:ramadan/bussines_logic/dua/dua_cubit.dart';
import 'package:ramadan/bussines_logic/prayer/prayer_cubit.dart';
import 'package:ramadan/pages/dua_page.dart';
import 'package:ramadan/pages/home/home.dart';
import 'package:ramadan/pages/munajat_page.dart';
import 'package:ramadan/pages/quran/quran_page.dart';
import 'package:ramadan/pages/zyarat_page.dart';
import 'package:ramadan/utils/utils.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = context.read<SettingCubit>();
    final controllerPrayer = context.read<PrayerCubit>();
    final duaCupit = context.read<DuaCubit>();

    final pages = [
      const QuranPage(),
      const DuaPage(),
      const HomePage(),
      const ZyaratPage(),
      const MunajatPage()
    ];

    if (controllerPrayer.state is PrayerStateInital) {
      controllerPrayer.listenTime(
        duaCupit,
      );
    }
    if (controllerPrayer.state is PrayerStateLoaded &&
        controllerPrayer.state.info.preyerTimes != null &&
        controller.state.setting.setting?.isSetNotification !=
            DateTime.now().day) {
      controller.setNotification(controllerPrayer.state.info.preyerTimes!);
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: kDefaultDuration),
      child: BlocBuilder<SettingCubit, SettingState>(
          builder: (context, presenter) => Container(
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  image: theme.brightness == Brightness.dark
                      ? null
                      : DecorationImage(
                          image: AssetImage(
                            theme.brightness == Brightness.dark
                                ? "assets/images/bac_dark.jpg"
                                : "assets/images/bak.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                ),
                child: Scaffold(
                  extendBody: true,
                  backgroundColor: Colors.transparent,
                  key: _scaffoldKey,
                  bottomNavigationBar: Container(
                    height: 90,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 16)
                        .copyWith(bottom: 12),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 0),
                            color: theme.brightness == Brightness.dark
                                ? Colors.black12
                                : Colors.grey.withOpacity(0.3),
                            blurRadius: 10)
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () =>
                              controller.changePage(NavPages.values[0], 0),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: presenter.setting.currentpageIndex == 0
                                  ? theme.primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              "assets/svg/quran.svg",
                              height: presenter.setting.currentpageIndex == 0
                                  ? 26
                                  : 30,
                              color: presenter.setting.currentpageIndex == 0
                                  ? theme.cardColor
                                  : jbUnselectColor,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () =>
                              controller.changePage(NavPages.values[0], 1),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: presenter.setting.currentpageIndex == 1
                                  ? theme.primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              "assets/svg/dua.svg",
                              height: presenter.setting.currentpageIndex == 1
                                  ? 26
                                  : 30,
                              color: presenter.setting.currentpageIndex == 1
                                  ? theme.cardColor
                                  : jbUnselectColor,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () =>
                              controller.changePage(NavPages.values[0], 2),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: presenter.setting.currentpageIndex == 2
                                  ? theme.primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              "assets/svg/home.svg",
                              height: presenter.setting.currentpageIndex == 2
                                  ? 26
                                  : 30,
                              color: presenter.setting.currentpageIndex == 2
                                  ? theme.cardColor
                                  : jbUnselectColor,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () =>
                              controller.changePage(NavPages.values[0], 3),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: presenter.setting.currentpageIndex == 3
                                  ? theme.primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              "assets/svg/zyara.svg",
                              height: presenter.setting.currentpageIndex == 3
                                  ? 20
                                  : 22,
                              color: presenter.setting.currentpageIndex == 3
                                  ? theme.cardColor
                                  : jbUnselectColor,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () =>
                              controller.changePage(NavPages.values[0], 4),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: presenter.setting.currentpageIndex == 4
                                  ? theme.primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              "assets/svg/munajat.svg",
                              height: presenter.setting.currentpageIndex == 4
                                  ? 26
                                  : 30,
                              color: presenter.setting.currentpageIndex == 4
                                  ? theme.cardColor
                                  : jbUnselectColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  body: IndexedStack(
                    index: presenter.setting.currentpageIndex,
                    children: pages,
                  ),
                ),
              )),
    );
  }
}

class BottomNavigationIcon extends StatelessWidget {
  const BottomNavigationIcon({
    super.key,
    required this.iconData,
    required this.isSelect,
  });

  final bool isSelect;
  final String iconData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: isSelect ? theme.primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: isSelect
                ? null
                : [
                    BoxShadow(
                        blurRadius: 20,
                        offset: const Offset(0, 1),
                        color: jbUnselectColor.withOpacity(0.4),
                        blurStyle: BlurStyle.inner),
                    BoxShadow(
                        blurRadius: 20,
                        offset: const Offset(0, -1),
                        color: jbUnselectColor.withOpacity(0.2),
                        blurStyle: BlurStyle.outer)
                  ]),
        child: SvgPicture.asset(
          "assets/svg/$iconData.svg",
          height: 25,
          color: isSelect ? Colors.white : jbUnselectColor,
        ));
  }
}

class _NavigationBarIcon extends StatelessWidget {
  const _NavigationBarIcon({
    Key? key,
    required this.isSelect,
    required this.iconName,
  }) : super(key: key);

  final bool isSelect;

  final String iconName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: SvgPicture.asset(
        // currentPage == page && theme.brightness == Brightness.light?
        // ? "assets/svg/${iconName}_dual.svg"

        "assets/svg/$iconName.svg",
        color: isSelect ? (theme.primaryColor) : theme.disabledColor,
        width: 24,
      ),
    );
  }
}
