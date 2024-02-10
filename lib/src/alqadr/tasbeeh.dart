import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/model/alqadr_model.dart';
import 'package:ramadan/src/alqadr/cubit/alqadr_cubit.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:ramadan/src/core/widget/jb_button.dart';

class TasbeehPage extends StatelessWidget {
  const TasbeehPage({super.key, required this.data});

  final DataList data;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final query = MediaQuery.of(context);
    final alqadrCubit = context.read<AlqadrCubit>();

    return Scaffold(
      body: BlocBuilder<AlqadrCubit, AlqadrState>(
        builder: (context, state) {
          if (state.alqadrInfo.currentTasbeeh == null ||
              state.alqadrInfo.currentTasbeeh!.all == 0 ||
              state.alqadrInfo.currentTasbeeh!.all != data.index) {
            alqadrCubit.increesTasbeeh(data.index!, 0);
          }
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
                              alqadrCubit.increesTasbeeh(0, 0);
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
                          .copyWith(color: theme.cardColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        data.smallText ?? "",
                        style: theme.textTheme.titleSmall!.copyWith(
                            color: theme.cardColor,
                            fontWeight: FontWeight.w100),
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
                    // InkWell(
                    //   onTap: () {
                    //     AudioPlayer().play(AssetSource('sound/tick.MP3'));
                    //     alqadrCubit.increesTasbeeh(
                    //         data.index ?? 0,
                    //         (state.alqadrInfo.currentTasbeeh?.current ?? 0) +
                    //             1);
                    //   },
                    //   child: CircularWidget(
                    //     theme: theme,
                    //     value: (state.alqadrInfo.currentTasbeeh?.current ?? 0) /
                    //         (data.index ?? 0),
                    //     size: 270,
                    //     number: state.alqadrInfo.currentTasbeeh?.current ?? 0,
                    //   ),
                    // ),
                    const SizedBox(height: kDefaultPadding * 2),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        data.title ?? "",
                        style: theme.textTheme.titleSmall!
                            .copyWith(color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: JBButton(
                        title: "اعادة العداد",
                        onPressed: () => alqadrCubit.resetTasbeeh(),
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
  const CircularWidget({
    super.key,
    required this.theme,
    required this.size,
    required this.value,
    required this.number,
  });

  final ThemeData theme;

  final double value;
  final double size;
  final int number;

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
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  child: number.toString().arabicNumber.toGradiant(
                      style: theme.textTheme.displayMedium!
                          .copyWith(fontSize: 100),
                      colors: [
                        theme.primaryColor,
                        theme.colorScheme.onPrimary
                      ]),
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
