import 'package:ramadan/src/main_app/home/daily_work/page/daily_work_view.dart';
import 'package:ramadan/src/main_app/home/presentation/widgets/app_bar.dart';
import 'package:ramadan/src/main_app/home/presentation/widgets/prayer_time_view.dart';
import 'package:ramadan/src/main_app/slider/presentation/pages/home_slider.dart';
import 'package:ramadan/utils/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 0, bottom: 100),
      children: [
        Container(
          padding: EdgeInsets.only(top: query.padding.top),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
              image: AssetImage(
                "assets/images/sliders.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: const Column(
            children: [
              SizedBox(height: 10),
              AppBarHome(),
              SizedBox(height: 12),
              HomeSliderView(),
              SizedBox(height: kDefaultSpacing),
            ],
          ),
        ),
        const SizedBox(height: 12),
        PrayerTimesView(),
        // (state.info.dayNumber == 18 && DateTime.now().hour > 17) ||
        //         (state.info.dayNumber > 18 &&
        //             state.info.dayNumber < 24)
        //     ? Column(children: [
        //         AlqadrCard(theme: theme),
        //         const SizedBox(height: kDefaultSpacing),
        //       ])
        //     : const SizedBox(),

        const SizedBox(height: kDefaultSpacing),

        const DailyWorkView(),
        const SizedBox(height: kDefaultSpacing),
      ],
    );
  }
}
