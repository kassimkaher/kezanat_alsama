import 'package:ramadan/src/main_app/home/daily_work/page/daily_work_view.dart';
import 'package:ramadan/src/main_app/home/presentation/widgets/app_bar.dart';
import 'package:ramadan/src/main_app/home/presentation/widgets/prayer_time_view.dart';
import 'package:ramadan/src/main_app/slider/presentation/pages/home_slider.dart';
import 'package:ramadan/utils/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: const SafeArea(child: AppBarHome()),
      ),
      body:
          // (state.info.dayNumber == 18 && DateTime.now().hour > 17) ||
          //         (state.info.dayNumber > 18 &&
          //             state.info.dayNumber < 24)
          //     ? Column(children: [
          //         AlqadrCard(theme: theme),
          //         const SizedBox(height: kDefaultSpacing),
          //       ])
          //     : const SizedBox(),
          SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                      image: AssetImage("assets/images/sliders.png"),
                      opacity: 1,
                      fit: BoxFit.fitWidth)),
              child: Column(
                children: [
                  SizedBox(height: 24),
                  HomeSliderView(),
                  SizedBox(height: 24),
                ],
              ),
            ),
            SizedBox(height: kDefaultSpacing),
            PrayerTimesView(),
            SizedBox(height: kDefaultSpacing),
            DailyWorkView(),
            SizedBox(height: kDefaultSpacing),
          ],
        ),
      ),
    );
  }
}
