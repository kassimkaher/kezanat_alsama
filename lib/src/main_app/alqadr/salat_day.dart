import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/src/main_app/alqadr/data/alqadr_model.dart';
import 'package:ramadan/src/main_app/alqadr/cubit/alqadr_cubit.dart';
import 'package:ramadan/src/main_app/alqadr/salat_page.dart';
import 'package:ramadan/src/main_app/widgets/custom_card.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:ramadan/src/core/widget/jb_button.dart';

class SalatDayPage extends StatelessWidget {
  const SalatDayPage({super.key, required this.data});

  final DataList data;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final query = MediaQuery.of(context);
    final alqadrCubit = context.read<AlqadrCubit>();
    return Scaffold(
      body: BlocBuilder<AlqadrCubit, AlqadrState>(
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                height: query.size.height,
                width: query.size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                  gradient: const LinearGradient(
                      colors: [alqadrAccesntColor, alqadrColor],
                      stops: [0, 0.8],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft),
                ),
                child: LottieBuilder.asset("assets/lottie/back.json"),
              ),
              AppBarWidget(query: query, theme: theme, data: data),
              Container(
                height: query.size.height,
                width: query.size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        alqadrCubit.setSalaConter();
                        alqadrCubit.setSalaDay();
                      },
                      child: CircularWidget(
                          theme: theme,
                          title: prayerArray[((state.alqadrInfo
                                      .salatDayCountinus?.salaNumber) ??
                                  0) +
                              1],
                          value: state.alqadrInfo.salatDayCountinus == null ||
                                  (state.alqadrInfo.salatDayCountinus!
                                              .salaNumber ==
                                          0 &&
                                      state.alqadrInfo.salatDayCountinus!.day ==
                                          0)
                              ? 0
                              : ((state.alqadrInfo.salatDayCountinus!.day *
                                          17) +
                                      state.alqadrInfo.salatDayCountinus!
                                          .salaNumber) /
                                  102,
                          size: 200,
                          fontSize: 18),
                    ),
                    const SizedBox(height: kDefaultPadding),
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: RCard(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultSpacing),
                        child: Row(
                          children: [
                            Text(
                              "عدد الايام المكتملة",
                              style: theme.textTheme.titleMedium,
                            ),
                            const Spacer(),
                            Container(
                                width: 50,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: alqadrAccesntColor),
                                child: Text(
                                  (state.alqadrInfo.salatDayCountinus?.day ?? 0)
                                      .toString()
                                      .arabicNumber,
                                  style: theme.textTheme.titleLarge!
                                      .copyWith(color: theme.cardColor),
                                ))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: kDefaultPadding),
                    Stack(
                      children: [
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: state.alqadrInfo.salatDayCountinus?.day == 6
                              ? 0
                              : 1,
                          child: RCard(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultSpacing,
                                vertical: kDefaultSpacing),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "صلاة الصباح",
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    const Spacer(),
                                    (state.alqadrInfo.salatDayCountinus
                                                    ?.salaNumber ??
                                                0) >
                                            0
                                        ? Icon(LucideIcons.checkCircle,
                                            color: theme.primaryColor)
                                        : Icon(LucideIcons.circle,
                                            color: theme.disabledColor)
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    Text(
                                      "صلاة الظهر",
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    const Spacer(),
                                    (state.alqadrInfo.salatDayCountinus
                                                    ?.salaNumber ??
                                                0) >
                                            1
                                        ? Icon(LucideIcons.checkCircle,
                                            color: theme.primaryColor)
                                        : Icon(LucideIcons.circle,
                                            color: theme.disabledColor)
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    Text(
                                      "صلاة العصر",
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    const Spacer(),
                                    (state.alqadrInfo.salatDayCountinus
                                                    ?.salaNumber ??
                                                0) >
                                            2
                                        ? Icon(LucideIcons.checkCircle,
                                            color: theme.primaryColor)
                                        : Icon(LucideIcons.circle,
                                            color: theme.disabledColor)
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    Text(
                                      "صلاة المغرب",
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    const Spacer(),
                                    (state.alqadrInfo.salatDayCountinus
                                                    ?.salaNumber ??
                                                0) >
                                            3
                                        ? Icon(LucideIcons.checkCircle,
                                            color: theme.primaryColor)
                                        : Icon(LucideIcons.circle,
                                            color: theme.disabledColor)
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    Text(
                                      "صلاة العشاء",
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    const Spacer(),
                                    (state.alqadrInfo.salatDayCountinus
                                                    ?.salaNumber ??
                                                0) >
                                            4
                                        ? Icon(LucideIcons.checkCircle,
                                            color: theme.primaryColor)
                                        : Icon(LucideIcons.circle,
                                            color: theme.disabledColor)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity:
                                state.alqadrInfo.salatDayCountinus?.day == 6
                                    ? 1
                                    : 0,
                            child:
                                "اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ"
                                    .toGradiant(
                                        style: theme.textTheme.titleMedium!
                                            .copyWith(fontSize: 24),
                                        colors: [cardColor, cardColor],
                                        textAlign: TextAlign.center),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: kDefaultPadding * 2),
                    SizedBox(
                      height: 48,
                      child: JBButton(
                        title: "اعادة العداد",
                        onPressed: () => alqadrCubit.resetSalatDay(),
                        backgroundColor: theme.primaryColor,

                        /// color: theme.textTheme.titleLarge!.color!,
                      ),
                    ),
                    const SizedBox(height: kDefaultPadding * 2),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    required this.query,
    required this.theme,
    required this.data,
  });

  final MediaQueryData query;
  final ThemeData theme;
  final DataList data;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          SizedBox(
            height: query.viewPadding.top,
          ),
          Row(
            children: [
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    LucideIcons.x,
                    color: theme.cardColor,
                  ))
            ],
          ),
          Text(
            data.title ?? "",
            style: theme.textTheme.titleLarge!.copyWith(color: cardColor),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Text(
              data.smallText ?? "",
              style: theme.textTheme.titleSmall!
                  .copyWith(color: cardColor, fontWeight: FontWeight.w100),
            ),
          ),
        ],
      ),
    );
  }
}
