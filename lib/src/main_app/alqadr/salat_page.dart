import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/src/main_app/alqadr/data/alqadr_model.dart';
import 'package:ramadan/src/main_app/alqadr/cubit/alqadr_cubit.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:ramadan/src/core/widget/jb_button.dart';

class SalatPage extends StatelessWidget {
  const SalatPage({super.key, required this.data});

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
              Align(
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
                      style: theme.textTheme.titleLarge!
                          .copyWith(color: cardColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        data.smallText ?? "",
                        style: theme.textTheme.titleSmall!.copyWith(
                            color: cardColor, fontWeight: FontWeight.w100),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: query.size.height,
                width: query.size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    const SizedBox(height: kDefaultPadding * 4),
                    InkWell(
                      onTap: () {
                        alqadrCubit.setSalaConter();
                      },
                      child: CircularWidget(
                        theme: theme,
                        title:
                            "صلاة رقم ${(state.alqadrInfo.salatCounterContinus?.salaNumber ?? 0).toString().arabicNumber}",
                        value: (state.alqadrInfo.salatCounterContinus
                                    ?.salaNumber ??
                                0) /
                            50,
                        size: 300,
                      ),
                    ),
                    const SizedBox(height: kDefaultPadding * 2),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "عدد الركع المتممة ${((state.alqadrInfo.salatCounterContinus?.salaNumber ?? 0) * 2).toString().arabicNumber} ركعة تبقى ${(((50 - (state.alqadrInfo.salatCounterContinus?.salaNumber ?? 0))) * 2).toString().arabicNumber}  ركعة",
                        style: theme.textTheme.titleSmall!
                            .copyWith(color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity:
                            state.alqadrInfo.salatCounterContinus?.salaNumber ==
                                    50
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
                    ),
                    const Spacer(),
                    Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: JBButton(
                        title: "اعادة العداد",
                        onPressed: () => alqadrCubit.resetSalatCounter(),
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

class CircularWidget extends StatelessWidget {
  const CircularWidget(
      {super.key,
      required this.theme,
      required this.size,
      required this.value,
      required this.title,
      this.fontSize});

  final ThemeData theme;
  final String title;
  final double value;
  final double size;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: size,
        width: size,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: size - 10,
                width: size - 10,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(180),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 4),
                        color: theme.primaryColor == jbPrimaryColor
                            ? theme.colorScheme.outline
                            : Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 4),
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: LottieBuilder.asset("assets/lottie/prayer.json"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: title.toGradiant(
                          style: theme.textTheme.titleMedium!
                              .copyWith(fontSize: fontSize ?? 26),
                          colors: [
                            theme.primaryColor,
                            theme.colorScheme.onPrimary
                          ]),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: size,
                width: size,
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                  value: value,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
