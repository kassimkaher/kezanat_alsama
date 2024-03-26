import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ramadan/bussines_logic/Setting/cubit/setting_cubit.dart';
import 'package:ramadan/utils/color.dart';
import 'package:ramadan/utils/enums.dart';

class BottomBar extends StatelessWidget {
  const BottomBar(
      {super.key,
      required this.theme,
      required this.controller,
      required this.currentpageIndex});

  final ThemeData theme;
  final SettingCubit controller;
  final int currentpageIndex;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: theme.primaryColor,
      currentIndex: currentpageIndex,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      unselectedItemColor: theme.disabledColor,
      onTap: (a) => controller.changePage(NavPages.values[0], a),
      items: [
        customBottomAppbar(
          onTap: () => controller.changePage(NavPages.values[0], 2),
          theme: theme,
          isSelect: currentpageIndex == 0,
          svgIcon: "assets/svg/home.svg",
          title: "الرئيسية",
        ),
        customBottomAppbar(
          onTap: () => controller.changePage(NavPages.values[0], 0),
          theme: theme,
          isSelect: currentpageIndex == 1,
          svgIcon: "assets/svg/quran.svg",
          title: "القرآن الكريم",
        ),
        customBottomAppbar(
          onTap: () => controller.changePage(NavPages.values[0], 1),
          theme: theme,
          isSelect: currentpageIndex == 2,
          svgIcon: "assets/svg/dua.svg",
          title: "الادعية",
        ),

        customBottomAppbar(
          onTap: () => controller.changePage(NavPages.values[0], 3),
          theme: theme,
          isSelect: currentpageIndex == 3,
          svgIcon: "assets/svg/munajat.svg",
          title: "الاعمال",
        ),

        // InkWell(
        //   onTap: () =>
        //       controller.changePage(NavPages.values[0], 4),
        //   child: AnimatedContainer(
        //     duration: const Duration(milliseconds: 300),
        //     height: 45,
        //     width: 45,
        //     decoration: BoxDecoration(
        //       color: presenter.setting.currentpageIndex == 4
        //           ? theme.primaryColor
        //           : Colors.transparent,
        //       borderRadius: BorderRadius.circular(30),
        //     ),
        //     alignment: Alignment.center,
        //     child: SvgPicture.asset(
        //       "assets/svg/munajat.svg",
        //       height: presenter.setting.currentpageIndex == 4
        //           ? 26
        //           : 30,
        //       color: presenter.setting.currentpageIndex == 4
        //           ? theme.cardColor
        //           : jbUnselectColor,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class KZBarItem extends StatelessWidget {
  const KZBarItem(
      {super.key,
      required this.onTap,
      required this.svgIcon,
      required this.theme,
      required this.isSelect,
      required this.title});

  final Function() onTap;
  final ThemeData theme;
  final bool isSelect;
  final String svgIcon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
            decoration: BoxDecoration(
                color: isSelect
                    ? theme.primaryColor.withOpacity(0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16)),
            child: SvgPicture.asset(
              svgIcon,
              height: isSelect ? 25 : 25,
              color: isSelect ? theme.primaryColor : jbUnselectColor,
            ),
          ),
          Text(
            title,
            style: theme.textTheme.bodySmall!.copyWith(
                fontSize: 16,
                color: isSelect ? theme.primaryColor : jbUnselectColor,
                fontWeight: isSelect ? FontWeight.w500 : FontWeight.w300),
          )
        ],
      ),
    );
  }
}

BottomNavigationBarItem customBottomAppbar(
    {required Function() onTap,
    required String svgIcon,
    required ThemeData theme,
    required bool isSelect,
    required String title}) {
  return BottomNavigationBarItem(
    label: title,
    icon: SvgPicture.asset(
      svgIcon,
      height: 20,
      color: jbUnselectColor,
    ),
    activeIcon: Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: SvgPicture.asset(
        svgIcon,
        height: 20,
        color: theme.primaryColor,
      ),
    ),
  );

  // InkWell(
  //   onTap: () => onTap(),
  //   child: Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       AnimatedContainer(
  //         duration: const Duration(milliseconds: 300),
  //         padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
  //         decoration: BoxDecoration(
  //             color: isSelect
  //                 ? theme.primaryColor.withOpacity(0.2)
  //                 : Colors.transparent,
  //             borderRadius: BorderRadius.circular(16)),
  //         child: SvgPicture.asset(
  //           svgIcon,
  //           height: isSelect ? 25 : 25,
  //           color: isSelect ? theme.primaryColor : jbUnselectColor,
  //         ),
  //       ),
  //       Text(
  //         title,
  //         style: theme.textTheme.bodySmall!.copyWith(
  //             fontSize: 16,
  //             color: isSelect ? theme.primaryColor : jbUnselectColor,
  //             fontWeight: isSelect ? FontWeight.w500 : FontWeight.w300),
  //       )
  //     ],
  //   ),
  // );
}
