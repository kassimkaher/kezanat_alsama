import 'package:lottie/lottie.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/bussines_logic/Setting/cubit/setting_cubit.dart';
import 'package:ramadan/pages/cities_page.dart';
import 'package:ramadan/src/admin/logic/calendar_cubit/calendar_cubit.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/core/widget/jb_button_mix.dart';
import 'package:ramadan/src/main_app/main_page.dart';
import 'package:ramadan/utils/utils.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SettingCubit settingCubit;
  late CalendarCubit calendarCubit;
  late PrayerCubit prayerCubit;

  @override
  void initState() {
    super.initState();

    settingCubit = context.read<SettingCubit>();
    prayerCubit = context.read<PrayerCubit>();
    calendarCubit = context.read<CalendarCubit>();
    calendarCubit.getCalendarEvent();
    settingCubit.getLocalSetting();
    //  if (state.setting.setting != null &&
    //     state.setting.setting!.selectCity != null) {
    //   ramadanCubit.getPrayer(state.setting.setting!.selectCity, calendarModel);
    //   ramadanCubit.listenTime(duaCubit);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<CalendarCubit, CalendarState>(
      listener: (context, state) {
        if (state.datastatus is SateSucess) {
          checkIfEnd(settingCubit.state.isEndEvent);
          prayerCubit.getPrayer(
              context.read<SettingCubit>().state.setting!.selectCity,
              state.calendarModel!);
        }
      },
      child: BlocBuilder<CalendarCubit, CalendarState>(
          builder: (context, calendarState) =>
              BlocBuilder<SettingCubit, SettingState>(
                builder: (context, state) {
                  return Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Container(
                        decoration: const BoxDecoration(
                          color: scaffoldColor,
                        ),
                        child: Stack(
                          children: [
                            SizedBox(width: size.width, height: size.height),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 70),
                                  child: Lottie.asset(
                                    "assets/lottie/logo.json",
                                    repeat: false,
                                    onLoaded: (a) => Future.delayed(
                                      const Duration(milliseconds: 1500),
                                    ).then(
                                      (value) {
                                        checkIfEnd(true);
                                      },
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerDocked,
                      floatingActionButton: switch (calendarState.datastatus) {
                        StateLoading() => const CircularProgressIndicator(),
                        StateError() => JBButtonMix(
                            icon: const Icon(LucideIcons.refreshCcw),
                            onPressed: () => calendarCubit.getCalendarEvent(),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            backgroundColor: Colors.red.shade600,
                            title: "خطأ بالاتصال  اعادة المحاولة"),
                        _ => const SizedBox(),
                      });
                },
              )),
    );
  }

  checkIfEnd(bool isAnimationEnd) {
    final dataStatus = context.read<CalendarCubit>().state.datastatus;
    // log("message=${dataStatus.toString()}----$isAnimationEnd==${DateTime.now().second}==${DateTime.now().millisecond}");
    if (dataStatus is SateSucess && isAnimationEnd) {
      Navigator.pushReplacement(
        context,
        to(
          settingCubit.state.setting?.city != null
              ? const MainPage()
              : const CitiesPage(),
        ),
      );
    }

    if (isAnimationEnd) {
      settingCubit.endAnimationEvent();
    }
  }
}
