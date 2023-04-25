import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ramadan/model/quran_model.dart';
import 'package:ramadan/utils/color.dart';
import 'package:ramadan/utils/extention.dart';

class QuranCircular extends StatelessWidget {
  const QuranCircular({super.key, required this.progress});

  final double progress;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 70,
      height: 70,
      child: Stack(
        children: [
          SizedBox(
            width: 70,
            height: 70,
          ),
          Center(
            child: Image.asset(
              "assets/images/quran.png",
              width: 60,
              height: 60,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: 70,
            height: 70,
            child: CircularProgressIndicator(
              color: theme.colorScheme.secondary,
              value: progress,
            ),
          )
        ],
      ),
    );
  }
}

class NumberWidget extends StatelessWidget {
  const NumberWidget(
      {super.key, required this.theme, required this.number, this.size = 40});

  final ThemeData theme;
  final String number;
  final double size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          SvgPicture.asset(
            "assets/svg/star.svg",
            height: size,
            color: theme.primaryColor,
          ),
          Center(
            child: Text(
              number.toString().arabicNumber,
              style: theme.textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                  fontSize: number.length > 2 ? 10 : 12),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
