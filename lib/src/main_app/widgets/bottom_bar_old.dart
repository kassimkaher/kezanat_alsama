import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ramadan/bussines_logic/Setting/cubit/setting_cubit.dart';
import 'package:ramadan/utils/color.dart';
import 'package:ramadan/utils/enums.dart';
import 'package:ramadan/src/core/widget/blure_background.dart';

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
    return SafeArea(
      child: BlureWidget(
        margin: const EdgeInsets.all(16).copyWith(bottom: 0),
        height: 90,
        borderRadius: 30,
        child: Container(
          height: 90,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(30),
            // borderRadius: const BorderRadius.only(
            //     topLeft: Radius.circular(5),
            //     topRight: Radius.circular(5),
            //     bottomLeft: Radius.circular(50),
            //     bottomRight: Radius.circular(50)),
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
              KZBarItem(
                  onTap: () => controller.changePage(NavPages.values[0], 2),
                  theme: theme,
                  isSelect: currentpageIndex == 2,
                  svgIcon: "assets/svg/home.svg",
                  title: "الرئيسية",
                  index: 2),
              KZBarItem(
                  onTap: () => controller.changePage(NavPages.values[0], 0),
                  theme: theme,
                  isSelect: currentpageIndex == 0,
                  svgIcon: "assets/svg/quran.svg",
                  title: "القرآن الكريم",
                  index: 0),
              KZBarItem(
                  onTap: () => controller.changePage(NavPages.values[0], 1),
                  theme: theme,
                  isSelect: currentpageIndex == 1,
                  svgIcon: "assets/svg/dua.svg",
                  title: "الادعية",
                  index: 1),
              KZBarItem(
                  onTap: () => controller.changePage(NavPages.values[0], 3),
                  theme: theme,
                  isSelect: currentpageIndex == 3,
                  svgIcon: "assets/svg/zyara.svg",
                  title: "الزيارات",
                  index: 3),
            ],
          ),
        ),
      ),
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
      required this.title,
      required this.index});

  final Function() onTap;
  final ThemeData theme;
  final bool isSelect;
  final String svgIcon;
  final String title;
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onTap(),
        child: Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border:
                  isSelect ? Border.all(color: Colors.black12, width: 2) : null,
              gradient: LinearGradient(
                  colors: index == 2
                      ? [theme.primaryColor, theme.primaryColor.withAlpha(0)]
                      : index == 0
                          ? [
                              const Color(0xff87909F),
                              const Color(0xff2F325D).withAlpha(200)
                            ]
                          : index == 1
                              ? [
                                  theme.colorScheme.secondary,
                                  theme.colorScheme.secondary.withAlpha(0)
                                ]
                              : [
                                  jbUnselectColor,
                                  jbUnselectColor.withAlpha(10)
                                ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft)),
          child: SvgPicture.asset(
            svgIcon,
            height: isSelect ? 25 : 25,
            color: Colors.white,
          ),
        ));
  }
}
