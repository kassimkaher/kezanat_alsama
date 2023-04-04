import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/alert/alert_desition.dart';
import 'package:ramadan/bussines_logic/Setting/settings_cubit.dart';
import 'package:ramadan/bussines_logic/alqadr/alqadr_cubit.dart';
import 'package:ramadan/pages/home/emsal_view.dart';
import 'package:ramadan/pages/read_sheet.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:ramadan/widget/jb_button.dart';

class AlqadrCard extends StatelessWidget {
  const AlqadrCard({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        to(
          const AlqaderPage(),
        ),
      ),
      child: Container(
        height: 62,
        margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          image: const DecorationImage(
            image: AssetImage(
              "assets/images/alqader.png",
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: alqadrColor),
              child: SvgPicture.asset(
                "assets/svg/quran3.svg",
                height: 25,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              " اعمال ليالي القدر",
              style: theme.textTheme.titleMedium!.copyWith(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

class AlqaderPage extends StatelessWidget {
  const AlqaderPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final settingCubit = context.read<SettingCubit>();
    final alqadrCubit = context.read<AlqadrCubit>();
    final theme = Theme.of(context);
    final query = MediaQuery.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   title: const Text("اعمال ليالي القدر"),
      //   centerTitle: true,
      // ),
      body: Container(
        width: double.infinity,
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
        child: BlocBuilder<AlqadrCubit, AlqadrState>(
          builder: (context, state) {
            if (state is AlqadrStateInitial) {
              alqadrCubit.getData();
            }

            return state is! AlqadrStateMain
                ? const CircularProgressIndicator()
                : SafeArea(
                    bottom: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding),
                          child: Row(
                            children: [
                              Text(
                                "الاعمال العامة لليالي القدر",
                                style: theme.textTheme.titleMedium,
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(LucideIcons.x))
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: 180,
                        //   child: PageView.builder(
                        //     padEnds: false,
                        //     controller: PageController(
                        //       viewportFraction: 0.9,
                        //       initialPage: 0,
                        //     ),
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount:
                        //         state.alqadrInfo.alqadrModel?.dayAll?.length,
                        //     itemBuilder: (c, i) => Container(
                        //       margin: const EdgeInsets.all(10),
                        //       padding: const EdgeInsets.all(10),
                        //       decoration: BoxDecoration(
                        //         color: theme.cardColor,
                        //         borderRadius:
                        //             BorderRadius.circular(kDefaultBorderRadius),
                        //         boxShadow: [
                        //           BoxShadow(
                        //               offset: const Offset(0, 4),
                        //               color:
                        //                   theme.primaryColor == jbPrimaryColor
                        //                       ? theme.colorScheme.outline
                        //                       : Colors.black.withOpacity(0.1),
                        //               spreadRadius: 0,
                        //               blurRadius: 4),
                        //         ],
                        //       ),
                        //       child: Row(
                        //         children: [
                        //           LottieBuilder.asset(
                        //             "assets/lottie/${state.alqadrInfo.alqadrModel?.dayAll?[i].image}.json",
                        //             alignment: Alignment.topCenter,
                        //             height: 70,
                        //           ),
                        //           Expanded(
                        //             child: ListTile(
                        //               title: Text(
                        //                 state.alqadrInfo.alqadrModel?.dayAll?[i]
                        //                         .title ??
                        //                     "",
                        //                 style: theme.textTheme.titleMedium,
                        //               ),
                        //               subtitle: Text(
                        //                 state.alqadrInfo.alqadrModel?.dayAll?[i]
                        //                         .smallText ??
                        //                     state.alqadrInfo.alqadrModel
                        //                         ?.dayAll?[i].bigText ??
                        //                     "",
                        //                 style: theme.textTheme.bodyMedium!
                        //                     .copyWith(
                        //                         color: theme.disabledColor),
                        //                 maxLines: 3,
                        //               ),
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        RCard(
                          width: 300,
                          //  height: 45,

                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding, vertical: 10),
                          margin: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding),
                          background: theme.disabledColor,
                          child: Row(
                            children: [
                              Text(
                                "اعمال الليلة",
                                style: theme.textTheme.titleLarge!
                                    .copyWith(color: theme.cardColor),
                              ),
                              const Spacer(),
                              Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    height: 40,
                                    width: 40,
                                    margin: EdgeInsets.only(
                                        right: (state.alqadrInfo.selectDay *
                                                40 +
                                            kDefaultSpacing *
                                                state.alqadrInfo.selectDay)),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: theme.cardColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      "",
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () => alqadrCubit.setDay(0),
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color:
                                                  state.alqadrInfo.selectDay ==
                                                          0
                                                      ? Colors.transparent
                                                      : Colors.white24,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: AnimatedDefaultTextStyle(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            style: theme.textTheme.titleMedium!,
                                            child: const Text("١٩"),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: kDefaultSpacing),
                                      InkWell(
                                        onTap: () => alqadrCubit.setDay(1),
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color:
                                                  state.alqadrInfo.selectDay ==
                                                          1
                                                      ? Colors.transparent
                                                      : Colors.white24,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: AnimatedDefaultTextStyle(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            style: theme.textTheme.titleMedium!,
                                            child: const Text("٢١"),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: kDefaultSpacing),
                                      InkWell(
                                        onTap: () => alqadrCubit.setDay(2),
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color:
                                                state.alqadrInfo.selectDay == 2
                                                    ? Colors.transparent
                                                    : Colors.white24,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: AnimatedDefaultTextStyle(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            style: theme.textTheme.titleMedium!,
                                            child: const Text("٢٣"),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),

                        // Expanded(
                        //   child: ListView.separated(
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: kDefaultPadding,
                        //         vertical: kDefaultSpacing),
                        //     itemCount:
                        //         state.alqadrInfo.selectDayDetails?.length ?? 0,
                        //     separatorBuilder: (q, a) => const SizedBox(
                        //       height: 6,
                        //     ),
                        //     itemBuilder: (c, i) => InkWell(
                        //       onTap: () {
                        //         print(state
                        //             .alqadrInfo.selectDayDetails![i].type!);
                        //         if ((!state.alqadrInfo.selectDayDetails![i]
                        //                 .isBigText!) &&
                        //             state.alqadrInfo.selectDayDetails![i]
                        //                     .type ==
                        //                 "DUA") {
                        //           print("kmnk");
                        //           alqadrCubit.setCardExpand(i);
                        //         }

                        //         if ((state.alqadrInfo.selectDayDetails![i]
                        //                 .isBigText!) &&
                        //             state.alqadrInfo.selectDayDetails![i]
                        //                     .type ==
                        //                 "DUA") {
                        //           showModal(
                        //             context: context,
                        //             topSpace: query.size.height * 0.3,
                        //             builder: (c, s) => ReadSheet(
                        //               title: state.alqadrInfo
                        //                       .selectDayDetails?[i].title ??
                        //                   "",
                        //               content: state.alqadrInfo
                        //                       .selectDayDetails![i].bigText ??
                        //                   state.alqadrInfo.selectDayDetails![i]
                        //                       .smallText ??
                        //                   "",
                        //               desc: state
                        //                   .alqadrInfo.selectDayDetails![i].desc,
                        //             ),
                        //           );
                        //         }
                        //       },
                        //       child: RCard(
                        //           width: 250,
                        //           padding: const EdgeInsets.symmetric(
                        //               horizontal: kDefaultPadding),
                        //           child: Column(
                        //             children: [
                        //               ListTile(
                        //                 dense: true,
                        //                 horizontalTitleGap: 0,
                        //                 contentPadding: EdgeInsets.zero,
                        //                 leading: SvgPicture.asset(
                        //                   "assets/svg/${state.alqadrInfo.selectDayDetails![i].image}.svg",
                        //                   color: alqadrAccesntColor,
                        //                   height: 30,
                        //                 ),
                        //                 title: Text(
                        //                   state.alqadrInfo.selectDayDetails![i]
                        //                           .title ??
                        //                       "",
                        //                   style: theme.textTheme.titleMedium,
                        //                 ),
                        //               ),
                        //               (!state.alqadrInfo.selectDayDetails![i]
                        //                       .isBigText!)
                        //                   ? AnimatedContainer(
                        //                       duration: const Duration(
                        //                           milliseconds: 300),
                        //                       height:
                        //                           state.alqadrInfo.cardIndex ==
                        //                                   i
                        //                               ? 100
                        //                               : 0,
                        //                       child: Text(state
                        //                               .alqadrInfo
                        //                               .selectDayDetails![i]
                        //                               .smallText ??
                        //                           state
                        //                               .alqadrInfo
                        //                               .selectDayDetails![i]
                        //                               .bigText ??
                        //                           ""),
                        //                     )
                        //                   : const SizedBox()
                        //             ],
                        //           )),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
