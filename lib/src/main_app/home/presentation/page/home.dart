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

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 0),
        child: Column(
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
              height: 300,
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
            const PrayerTimesView(),
            // (state.info.dayNumber == 18 && DateTime.now().hour > 17) ||
            //         (state.info.dayNumber > 18 &&
            //             state.info.dayNumber < 24)
            //     ? Column(children: [
            //         AlqadrCard(theme: theme),
            //         const SizedBox(height: kDefaultSpacing),
            //       ])
            //     : const SizedBox(),

            const SizedBox(height: kDefaultSpacing),

            const Expanded(child: DailyWorkView()),
            const SizedBox(height: kDefaultSpacing),
          ],
        ),
      ),
    );
  }
}
