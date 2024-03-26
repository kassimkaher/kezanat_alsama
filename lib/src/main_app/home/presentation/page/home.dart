import 'package:ramadan/src/main_app/alqadr/alqader_page.dart';
import 'package:ramadan/src/main_app/home/daily_work/page/daily_work_view.dart';
import 'package:ramadan/src/main_app/home/presentation/widgets/app_bar.dart';
import 'package:ramadan/src/main_app/home/presentation/widgets/prayer_time_view.dart';
import 'package:ramadan/src/main_app/slider/presentation/pages/home_slider.dart';
import 'package:ramadan/src/main_app/widgets/check_battery_optimization_button.dart';
import 'package:ramadan/utils/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: const SafeArea(child: AppBarHome()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                      image: AssetImage("assets/images/sliders.png"),
                      opacity: 1,
                      fit: BoxFit.fitWidth)),
              child: const Column(
                children: [
                  SizedBox(height: 24),
                  HomeSliderView(),
                  SizedBox(height: 24),
                ],
              ),
            ),
            const ChekBatteryOptimizeIsDisable(),
            const SizedBox(height: kDefaultSpacing),
            const PrayerTimesView(),
            const AlqadrCard(),
            const SizedBox(height: kDefaultSpacing),
            const DailyWorkView(),
            const SizedBox(height: kDefaultSpacing),
          ],
        ),
      ),
    );
  }
}
