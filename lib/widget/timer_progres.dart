import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/bussines_logic/ramadan/ramadan_cubit.dart';
import 'package:ramadan/utils/utils.dart';

class HomeTopCard extends StatelessWidget {
  const HomeTopCard({
    super.key,
    required this.data,
  });

  final RamadanInfo data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Container(
      height: 160,
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Stack(
        children: [
          SizedBox(
            width: size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kDefaultBorderRadius),
              child: Image.asset(
                "assets/images/${data.nextTime!.image}",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.nextTime!.title,
                    style: theme.textTheme.titleLarge!
                        .copyWith(color: Colors.white, fontSize: 24),
                  ),
                  Row(
                    children: [
                      Icon(
                        LucideIcons.mapPin,
                        color: theme.textTheme.displaySmall!.color,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "بغداد",
                        style: theme.textTheme.displaySmall!
                            .copyWith(color: Colors.white70, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
          CircularProgresTimer(
            time: data.nextTime!.timeText,
            stayTime: data.nextTime!.staytimeText,
            value: 1 - data.nextTime!.progress,
            isKnow: data.nextTime!.isKnow,
          ),
        ],
      ),
    );
  }
}

class CircularProgresTimer extends StatelessWidget {
  const CircularProgresTimer(
      {super.key,
      required this.time,
      required this.value,
      required this.stayTime,
      required this.isKnow});
  final String time;
  final String stayTime;
  final double value;
  final bool isKnow;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 100,
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Stack(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: isKnow ? jbSecondary : Colors.black26,
                  borderRadius: BorderRadius.circular(100)),
            ),
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: CircularProgressIndicator(
                color: Colors.white,
                value: value,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: isKnow
                  ? Text(
                      "حان الموعد",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          stayTime,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          time,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              height: 0.8,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
