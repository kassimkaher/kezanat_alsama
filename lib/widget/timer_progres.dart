import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/alert/alert_desition.dart';
import 'package:ramadan/bussines_logic/prayer/prayer_cubit.dart';
import 'package:ramadan/model/setting_model.dart';
import 'package:ramadan/pages/cities_page.dart';
import 'package:ramadan/utils/utils.dart';

import '../bussines_logic/Setting/settings_cubit.dart';

class HomeTopCard extends StatelessWidget {
  const HomeTopCard({super.key, required this.data, required this.city});

  final PrayerInfo data;
  final CityDetails city;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        // KDAlert.showSheet(context,
        //     height: size.height * 0.935,
        //     width: size.width,
        //     title: "اختر المحافظة",
        //     child: Column(
        //       children: [
        //         Text(
        //           "FAJR =${getTimeText(fajrTime)}===REAL==3:10",
        //           style: theme.textTheme.titleMedium,
        //         ),
        //         Text(
        //           "Sunris =${calc.sunriseTime.time.inHours}:${calc.sunriseTime.time.inMinutes % 60}===REAL==4:53",
        //           style: theme.textTheme.titleLarge,
        //         ),
        //         Text(
        //           "DuhUr =${getTimeText(duhurPrayer)}===REAL==12:04",
        //           style: theme.textTheme.titleMedium,
        //         ),
        //         Text(
        //           "Mugrib =${getTimeText(durationToTime(calc.sunsetTime.time))}===REAL==7:14",
        //           style: theme.textTheme.titleLarge,
        //         ),
        //         Divider(),
        //         Text(
        //           "Mugrib prayer=${getTimeText(mugrib)}===REAL==7:32",
        //           style: theme.textTheme.titleLarge,
        //         ),
        //         Text(
        //           "Esha =${getTimeText(esha)}===REAL==8:30",
        //           style: theme.textTheme.titleMedium,
        //         ),
        //         Divider(),
        //         Text(
        //           "Midinte =${getTimeText(midnight)}===REAL==11:12",
        //           style: theme.textTheme.titleMedium,
        //         ),
        //       ],
        //     ));
        // return;
        KDAlert.showSheet(
          context,
          height: size.height * 0.935,
          width: size.width,
          title: "اختر المحافظة",
          child: CityListView(
            onSelect: () {
              final controller = context.read<SettingCubit>();
              final controllerPrayer = context.read<PrayerCubit>();

              controllerPrayer
                  .getPrayer(controller.state.setting.setting!.selectCity);
              controller
                  .setNotification(controllerPrayer.state.info.preyerTimes!);
              Navigator.pop(context);
            },
          ),
        );
      },
      child: Container(
        height: 160,
        width: size.width,
        margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Stack(
          children: [
            data.nextTime == null
                ? const SizedBox()
                : SizedBox(
                    width: size.width,
                    height: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                      child: Image.asset(
                        "assets/images/${data.nextTime!.image}",
                        fit: BoxFit.cover,
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
                      data.nextTime?.title ?? "",
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
                          city.nameAr ?? "",
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
            data.nextTime == null
                ? const SizedBox()
                : CircularProgresTimer(
                    time: data.nextTime?.timeText ?? "",
                    stayTime: data.nextTime!.staytimeText,
                    value: 1 - data.nextTime!.progress,
                    isKnow: data.nextTime!.isKnow,
                  ),
          ],
        ),
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
    return Positioned(
      left: 20,
      top: 20,
      bottom: 20,
      child: Container(
        height: double.infinity,
        child: AspectRatio(
          aspectRatio: 1,
          child: Stack(
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
      ),
    );
  }
}
