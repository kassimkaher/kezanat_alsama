import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/src/main_app/home/presentation/widgets/prayer_card.dart';

import 'package:ramadan/utils/utils.dart';

class PrayerTimesView extends StatelessWidget {
  const PrayerTimesView({super.key, required this.data, required this.city});

  final PrayerState data;
  final CityDetails city;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            useSafeArea: true,
            context: context,
            builder: (c) => BlocBuilder<PrayerCubit, PrayerState>(
                  builder: (context, state) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      child: PrayerCard(
                          onPressed: () {},
                          theme: theme,
                          data: state.currentDay,
                          city: city.nameAr ?? ""),
                    );
                  },
                ));
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
