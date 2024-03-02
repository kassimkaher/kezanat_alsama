import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/src/main_app/dua/work_display_view.dart';
import 'package:ramadan/src/main_app/widgets/custom_card.dart';
import 'package:ramadan/model/alqadr_model.dart';
import 'package:ramadan/src/alqadr/salat_day.dart';
import 'package:ramadan/src/alqadr/salat_page.dart';
import 'package:ramadan/pages/read_sheet.dart';
import 'package:ramadan/src/main_app/quran/quran_list_suar.dart';
import 'package:ramadan/utils/utils.dart';

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
    final zyaratCubit = context.read<DuaCubit>();
    final quranCubit = context.read<QuranCubit>();
    final alqadrCubit = context.read<AlqadrCubit>();
    final theme = Theme.of(context);
    final query = MediaQuery.of(context);
    const leftPadding = kDefaultPadding;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
        ),
      ),
      body: Container(
        width: double.infinity,
        height: query.size.height,
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          // image: theme.brightness == Brightness.dark
          //     ? null
          //     : DecorationImage(
          //         image: AssetImage(
          //           theme.brightness == Brightness.dark
          //               ? "assets/images/bac_dark.jpg"
          //               : "assets/images/bak.png",
          //         ),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: BlocBuilder<AlqadrCubit, AlqadrState>(
          builder: (context, state) {
            if (state is AlqadrStateInitial) {
              alqadrCubit.getData();
              alqadrCubit.getSala();
            }

            return state is! AlqadrStateMain
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: kDefaultSpacing),
                      Text("جاري التحميل")
                    ],
                  )
                : SafeArea(
                    bottom: false,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            height:
                                state.alqadrInfo.cardIndex != -1 ? 150 : 200,
                            alignment: Alignment.center,
                            child: LottieBuilder.asset(
                              "assets/lottie/quran3.json",
                              alignment: Alignment.topCenter,
                              options: LottieOptions(enableMergePaths: true),
                            ),
                          ),
                          RCard(
                            width: 300,
                            borderRadius: 20,
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding, vertical: 6),
                            margin: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            background: alqadrColor,
                            child: Row(
                              children: [
                                Text(
                                  "اعمال الليلة",
                                  style: theme.textTheme.titleLarge!
                                      .copyWith(color: cardColor),
                                ),
                                const Spacer(),
                                Stack(
                                  children: [
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
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
                                                color: state.alqadrInfo
                                                            .selectDay ==
                                                        0
                                                    ? Colors.transparent
                                                    : Colors.white24,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: AnimatedDefaultTextStyle(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              style:
                                                  theme.textTheme.titleMedium!,
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
                                                color: state.alqadrInfo
                                                            .selectDay ==
                                                        1
                                                    ? Colors.transparent
                                                    : Colors.white24,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: AnimatedDefaultTextStyle(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              style:
                                                  theme.textTheme.titleMedium!,
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
                                                  state.alqadrInfo.selectDay ==
                                                          2
                                                      ? Colors.transparent
                                                      : Colors.white24,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: AnimatedDefaultTextStyle(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              style:
                                                  theme.textTheme.titleMedium!,
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
                          const SizedBox(height: kDefaultPadding),
                          InkWell(
                            onTap: () {
                              showModal(
                                context: context,
                                topSpace: query.size.height * 0.45,
                                horizontalMargin: kDefaultPadding,
                                builder: (c, s) => ReadSheet(
                                  animation: state.alqadrInfo.selectDayDetails!
                                      .other?.dataList?.first.image,
                                  title: state.alqadrInfo.selectDayDetails!
                                          .other!.title ??
                                      "",
                                  content: state.alqadrInfo.selectDayDetails!
                                          .other!.desc ??
                                      "",
                                  desc: "",
                                ),
                              );
                            },
                            child: RCard(
                              borderRadius: 20,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kDefaultPadding),
                              margin: const EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding)
                                  .copyWith(left: leftPadding),
                              child: Column(
                                children: [
                                  ListTile(
                                    dense: true,
                                    horizontalTitleGap: 0,
                                    contentPadding: EdgeInsets.zero,
                                    leading: SvgPicture.asset(
                                      "assets/svg/${state.alqadrInfo.selectDayDetails!.other!.dataList!.first.image}.svg",
                                      color: alqadrAccesntColor,
                                      height: 30,
                                    ),
                                    title: Text(
                                      state.alqadrInfo.selectDayDetails!.other!
                                              .title ??
                                          "",
                                      style: theme.textTheme.titleMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          //dua
                          InkWell(
                            onTap: () => alqadrCubit.setCardExpand(
                                state.alqadrInfo.cardIndex == 1 ? -1 : 1),
                            child: RCard(
                              borderRadius: 20,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kDefaultPadding),
                              margin: const EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding)
                                  .copyWith(left: leftPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    dense: true,
                                    horizontalTitleGap: 0,
                                    contentPadding: EdgeInsets.zero,
                                    leading: SvgPicture.asset(
                                      "assets/svg/${state.alqadrInfo.selectDayDetails!.duaData!.dataList!.first.image}.svg",
                                      color: alqadrAccesntColor,
                                      height: 30,
                                    ),
                                    title: Text(
                                      state.alqadrInfo.selectDayDetails!
                                              .duaData!.title ??
                                          "",
                                      style: theme.textTheme.titleMedium,
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 150),
                                    height: state.alqadrInfo.cardIndex == 1
                                        ? (58 *
                                                state
                                                    .alqadrInfo
                                                    .selectDayDetails!
                                                    .duaData!
                                                    .dataList!
                                                    .length)
                                            .toDouble()
                                        : 0,
                                    child: Stack(children: [
                                      for (var e in state.alqadrInfo
                                          .selectDayDetails!.duaData!.dataList!)
                                        DuaCard(
                                          query: query,
                                          zyaratCubit: zyaratCubit,
                                          theme: theme,
                                          index: state
                                              .alqadrInfo
                                              .selectDayDetails!
                                              .duaData!
                                              .dataList!
                                              .indexWhere(
                                                  (a) => a.title == e.title),
                                          data: e,
                                        ),
                                    ]),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          //salat
                          InkWell(
                            onTap: () => alqadrCubit.setCardExpand(
                                state.alqadrInfo.cardIndex == 2 ? -1 : 2),
                            child: RCard(
                              borderRadius: 20,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kDefaultPadding),
                              margin: const EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding)
                                  .copyWith(left: leftPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    dense: true,
                                    horizontalTitleGap: 0,
                                    contentPadding: EdgeInsets.zero,
                                    leading: SvgPicture.asset(
                                      "assets/svg/${state.alqadrInfo.selectDayDetails!.salatData!.dataList!.first.image}.svg",
                                      color: alqadrAccesntColor,
                                      height: 30,
                                    ),
                                    title: Text(
                                      state.alqadrInfo.selectDayDetails!
                                              .salatData!.title ??
                                          "",
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    subtitle: Text(
                                      state.alqadrInfo.selectDayDetails!
                                              .salatData!.desc ??
                                          "",
                                      style: theme.textTheme.displaySmall,
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 150),
                                    height: state.alqadrInfo.cardIndex == 2
                                        ? (58 *
                                                state
                                                    .alqadrInfo
                                                    .selectDayDetails!
                                                    .salatData!
                                                    .dataList!
                                                    .length)
                                            .toDouble()
                                        : 0,
                                    child: Stack(
                                      children: state
                                          .alqadrInfo
                                          .selectDayDetails!
                                          .salatData!
                                          .dataList!
                                          .asMap()
                                          .map(
                                            (i, e) => MapEntry(
                                              i,
                                              Positioned(
                                                left: 0,
                                                right: 0,
                                                top: i * 56,
                                                child: InkWell(
                                                  onTap: () {
                                                    if (e.index == 100) {
                                                      Navigator.push(
                                                        context,
                                                        to(
                                                          SalatPage(data: e),
                                                        ),
                                                      );
                                                    } else if (e.index == 6) {
                                                      Navigator.push(
                                                        context,
                                                        to(
                                                          SalatDayPage(data: e),
                                                        ),
                                                      );
                                                    } else {
                                                      showModal(
                                                        context: context,
                                                        topSpace:
                                                            query.size.height *
                                                                0.45,
                                                        horizontalMargin:
                                                            kDefaultPadding,
                                                        builder: (c, s) =>
                                                            ReadSheet(
                                                          animation: e.image,
                                                          title: e.title ?? "",
                                                          content: e.bigText ??
                                                              e.smallText ??
                                                              "",
                                                          desc: "",
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 48,
                                                    alignment:
                                                        Alignment.centerRight,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal:
                                                          kDefaultSpacing,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: theme
                                                            .scaffoldBackgroundColor),
                                                    child: Text(
                                                      e.title ?? "",
                                                      style: theme.textTheme
                                                          .titleMedium,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                          .values
                                          .toList(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          //quran
                          state.alqadrInfo.selectDayDetails!.quranSuarData!
                                      .length! <
                                  1
                              ? const SizedBox()
                              : Column(children: [
                                  InkWell(
                                    onTap: () => alqadrCubit.setCardExpand(
                                        state.alqadrInfo.cardIndex == 3
                                            ? -1
                                            : 3),
                                    child: RCard(
                                      borderRadius: 20,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kDefaultPadding),
                                      margin: const EdgeInsets.symmetric(
                                              horizontal: kDefaultPadding)
                                          .copyWith(left: leftPadding),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            dense: true,
                                            horizontalTitleGap: 0,
                                            contentPadding: EdgeInsets.zero,
                                            leading: SvgPicture.asset(
                                              "assets/svg/${state.alqadrInfo.selectDayDetails!.quranSuarData!.dataList!.first.image}.svg",
                                              color: alqadrAccesntColor,
                                              height: 30,
                                            ),
                                            title: Text(
                                              state.alqadrInfo.selectDayDetails!
                                                      .quranSuarData!.title ??
                                                  "",
                                              style:
                                                  theme.textTheme.titleMedium,
                                            ),
                                          ),
                                          AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 150),
                                            height: state
                                                        .alqadrInfo.cardIndex ==
                                                    3
                                                ? (58 *
                                                        state
                                                            .alqadrInfo
                                                            .selectDayDetails!
                                                            .quranSuarData!
                                                            .dataList!
                                                            .length)
                                                    .toDouble()
                                                : 0,
                                            child: Stack(
                                              children:
                                                  state
                                                      .alqadrInfo
                                                      .selectDayDetails!
                                                      .quranSuarData!
                                                      .dataList!
                                                      .asMap()
                                                      .map(
                                                        (i, e) => MapEntry(
                                                          i,
                                                          Positioned(
                                                            left: 0,
                                                            right: 0,
                                                            top: i * 56,
                                                            child: InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  to(
                                                                    SuraViewForSuar(
                                                                      data: quranCubit
                                                                          .state
                                                                          .info
                                                                          .quranModel!
                                                                          .data!
                                                                          .surahs![e.index!],
                                                                      index: e
                                                                          .index!,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child: Container(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                height: 48,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  horizontal:
                                                                      kDefaultSpacing,
                                                                ),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    color: theme
                                                                        .scaffoldBackgroundColor),
                                                                child: Text(
                                                                  e.title ?? "",
                                                                  style: theme
                                                                      .textTheme
                                                                      .titleMedium,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .values
                                                      .toList(),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ]),

                          // zyarat
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                to(
                                  WorkDisplayText(
                                    data: zyaratCubit
                                            .state.info.zyaratData!.zyaratList![
                                        state
                                            .alqadrInfo
                                            .selectDayDetails!
                                            .zyaratData!
                                            .dataList!
                                            .first
                                            .index!],
                                  ),
                                ),
                              );
                            },
                            child: RCard(
                              borderRadius: 20,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kDefaultPadding),
                              margin: const EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding)
                                  .copyWith(left: leftPadding),
                              child: Column(
                                children: [
                                  ListTile(
                                    dense: true,
                                    horizontalTitleGap: 0,
                                    contentPadding: EdgeInsets.zero,
                                    leading: SvgPicture.asset(
                                      "assets/svg/${state.alqadrInfo.selectDayDetails!.zyaratData!.dataList!.first.image}.svg",
                                      color: alqadrAccesntColor,
                                      height: 30,
                                    ),
                                    title: Text(
                                      state.alqadrInfo.selectDayDetails!
                                              .zyaratData!.title ??
                                          "",
                                      style: theme.textTheme.titleMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          //tasbeh
                          state.alqadrInfo.selectDayDetails!.taspehData!
                                      .length! <
                                  1
                              ? const SizedBox()
                              : Column(children: [
                                  InkWell(
                                    onTap: () => alqadrCubit.setCardExpand(
                                        state.alqadrInfo.cardIndex == 4
                                            ? -1
                                            : 4),
                                    child: RCard(
                                      borderRadius: 20,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kDefaultPadding),
                                      margin: const EdgeInsets.symmetric(
                                              horizontal: kDefaultPadding)
                                          .copyWith(left: leftPadding),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            dense: true,
                                            horizontalTitleGap: 0,
                                            contentPadding: EdgeInsets.zero,
                                            leading: SvgPicture.asset(
                                              "assets/svg/${state.alqadrInfo.selectDayDetails!.taspehData!.dataList!.first.image}.svg",
                                              color: alqadrAccesntColor,
                                              height: 30,
                                            ),
                                            title: Text(
                                              state.alqadrInfo.selectDayDetails!
                                                      .taspehData!.title ??
                                                  "",
                                              style:
                                                  theme.textTheme.titleMedium,
                                            ),
                                            subtitle: Text(
                                              state.alqadrInfo.selectDayDetails!
                                                      .taspehData!.desc ??
                                                  "",
                                              style: theme
                                                  .textTheme.displaySmall!
                                                  .copyWith(
                                                      fontSize: 14,
                                                      color:
                                                          theme.disabledColor),
                                            ),
                                          ),
                                          AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 150),
                                            height: state
                                                        .alqadrInfo.cardIndex ==
                                                    4
                                                ? (58 *
                                                        state
                                                            .alqadrInfo
                                                            .selectDayDetails!
                                                            .taspehData!
                                                            .dataList!
                                                            .length)
                                                    .toDouble()
                                                : 0,
                                            child: Stack(
                                              children: state
                                                  .alqadrInfo
                                                  .selectDayDetails!
                                                  .taspehData!
                                                  .dataList!
                                                  .asMap()
                                                  .map(
                                                    (i, e) => MapEntry(
                                                      i,
                                                      Container(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        height: 48,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal:
                                                              kDefaultSpacing,
                                                        ),
                                                        margin: EdgeInsets.only(
                                                            top: i * 56),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            color: theme
                                                                .scaffoldBackgroundColor),
                                                        child: InkWell(
                                                          onTap: () {
                                                            // Navigator.push(
                                                            //   context,
                                                            //   to(
                                                            //     TasbeehPage(
                                                            //         data: e),
                                                            //   ),
                                                            // );
                                                          },
                                                          child: Text(
                                                            e.title ?? "",
                                                            style: theme
                                                                .textTheme
                                                                .titleMedium,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                  .values
                                                  .toList(),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ]),
                          InkWell(
                            onTap: () {
                              showModal(
                                context: context,
                                topSpace: query.size.height * 0.1,
                                horizontalMargin: kDefaultPadding,
                                builder: (c, s) => ReadSheet(
                                  animation: state.alqadrInfo.selectDayDetails!
                                      .quranAmal?.dataList?.first.image,
                                  title: state.alqadrInfo.selectDayDetails!
                                          .quranAmal!.title ??
                                      "",
                                  content: state.alqadrInfo.selectDayDetails!
                                      .quranAmal!.dataList!
                                      .map((e) =>
                                          e.bigText ??
                                          e.smallText ??
                                          "" + "\n------------------\n")
                                      .toString(),
                                  desc: "",
                                ),
                              );
                            },
                            child: RCard(
                              borderRadius: 20,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kDefaultPadding),
                              margin: const EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding)
                                  .copyWith(left: leftPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    dense: true,
                                    horizontalTitleGap: 0,
                                    contentPadding: EdgeInsets.zero,
                                    leading: SvgPicture.asset(
                                      "assets/svg/${state.alqadrInfo.selectDayDetails!.quranAmal!.dataList!.first.image}.svg",
                                      color: alqadrAccesntColor,
                                      height: 30,
                                    ),
                                    title: Text(
                                      state.alqadrInfo.selectDayDetails!
                                              .quranAmal!.title ??
                                          "",
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    subtitle: Text(
                                      state.alqadrInfo.selectDayDetails!
                                              .quranAmal!.desc ??
                                          "",
                                      style: theme.textTheme.displaySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}

class DuaCard extends StatelessWidget {
  const DuaCard(
      {super.key,
      required this.query,
      required this.zyaratCubit,
      required this.theme,
      required this.data,
      required this.index});

  final MediaQueryData query;
  final DuaCubit zyaratCubit;
  final ThemeData theme;
  final int index;
  final DataList data;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: index * 56,
      left: 0,
      right: 0,
      child: InkWell(
        onTap: () {
          if (data.index == null) {
            showModal(
              context: context,
              topSpace: query.size.height * 0.12,
              horizontalMargin: 0,
              builder: (c, s) => ReadSheet(
                animation: data.image,
                title: data.title ?? "",
                content: data.smallText ?? data.bigText ?? "",
                desc: data.desc,
              ),
            );
          } else {
            Navigator.push(
              context,
              to(
                WorkDisplayText(
                  data:
                      zyaratCubit.state.info.documentEntity!.dua![data.index!],
                ),
              ),
            );
          }
        },
        child: Container(
          alignment: Alignment.centerRight,
          height: 48,
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultSpacing,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: theme.scaffoldBackgroundColor),
          child: Text(
            data.title ?? "",
            style: theme.textTheme.titleMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
