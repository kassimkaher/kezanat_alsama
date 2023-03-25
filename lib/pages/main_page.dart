import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ramadan/bussines_logic/Setting/settings_cubit.dart';
import 'package:ramadan/bussines_logic/ramadan/ramadan_cubit.dart';
import 'package:ramadan/pages/dua_page.dart';
import 'package:ramadan/pages/home/home.dart';
import 'package:ramadan/pages/quran_page.dart';
import 'package:ramadan/utils/paint/bottom_navigator.dart';
import 'package:ramadan/utils/utils.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = context.read<SettingCubit>();
    final controllerRamadan = context.read<RamadanCubit>();
    final query = MediaQuery.of(context);
    final pages = [
      const DuaPage(),
      const HomePage(),
      const QuranPage(),
    ];

    if (controllerRamadan.state is RamadanStateLoaded &&
        controllerRamadan.state.info.emsackModel != null &&
        !controller.state.setting.isSetNotification) {
      controllerRamadan.setNotification(
          controllerRamadan.state.info.emsackModel!, 0);
      controller.setIsNotification();
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: kDefaultDuration),
      child: BlocBuilder<SettingCubit, NavigationState>(
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
                  bottomNavigationBar: CustomPaint(
                      size: Size(query.size.width, 10),
                      painter: BottomSheetShape(theme.cardColor),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16, top: 25),
                        child: Row(
                          children: [
                            const SizedBox(width: 40),
                            InkWell(
                              onTap: () =>
                                  controller.changePage(NavPages.values[0], 0),
                              child: Wrap(
                                direction: Axis.vertical,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  _NavigationBarIcon(
                                      isSelect:
                                          presenter.setting.currentpageIndex ==
                                              0,
                                      iconName: 'dua'),
                                  Text(
                                    "dua".tr(),
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodySmall!.copyWith(
                                        fontSize: 12,
                                        color: presenter
                                                    .setting.currentpageIndex ==
                                                0
                                            ? jbPrimaryColor
                                            : jbUnselectColor),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () =>
                                  controller.changePage(NavPages.values[1], 1),
                              child: Transform.translate(
                                offset: Offset(0, -20),
                                child: BottomNavigationIcon(
                                  iconData: 'home',
                                  isSelect:
                                      presenter.setting.currentpageIndex == 1,
                                ),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () =>
                                  controller.changePage(NavPages.values[2], 2),
                              child: Wrap(
                                direction: Axis.vertical,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  _NavigationBarIcon(
                                      isSelect:
                                          presenter.setting.currentpageIndex ==
                                              2,
                                      iconName: 'quran'),
                                  Text("quran".tr(),
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.bodySmall!
                                          .copyWith(
                                              fontSize: 12,
                                              color: presenter.setting
                                                          .currentpageIndex ==
                                                      2
                                                  ? jbPrimaryColor
                                                  : jbUnselectColor)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 40),
                          ],
                        ),
                      )),
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
