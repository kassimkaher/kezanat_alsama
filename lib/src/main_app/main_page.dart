import 'package:flutter_svg/flutter_svg.dart';
import 'package:ramadan/src/admin/logic/calendar_cubit/calendar_cubit.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/main_app/dua/dua_page.dart';
import 'package:ramadan/pages/munajat_page.dart';
import 'package:ramadan/src/main_app/home/daily_work/logic/daily_work_logic/daily_work_cubit.dart';
import 'package:ramadan/src/main_app/home/presentation/page/home.dart';
import 'package:ramadan/src/main_app/zyarat/zyarat_page.dart';
import 'package:ramadan/src/main_app/quran/quran_page.dart';
import 'package:ramadan/src/main_app/widgets/bottom_bar.dart';
import 'package:ramadan/utils/utils.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    context.read<CalendarCubit>().getCalendar();
    context.read<SliderCubit>().getSliders();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = context.read<SettingCubit>();
    final controllerPrayer = context.read<PrayerCubit>();
    final duaCupit = context.read<DuaCubit>();

    final pages = [
      const HomePage(),
      const QuranPage(),
      const DuaPage(),
      const ZyaratPage(),
      const MunajatPage()
    ];

    if (controllerPrayer.state.datastatus == DataStatus.ideal) {
      controllerPrayer.listenTime(
        duaCupit,
      );
    }
    if (controllerPrayer.state.datastatus == DataStatus.ideal &&
        controllerPrayer.state.preyerTimes != null &&
        controller.state.setting.setting?.isSetNotification !=
            DateTime.now().day) {
      controller.setNotification(controllerPrayer.state.preyerTimes!);
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: kDefaultDuration),

      //whait calendar loaded today info and then get dailwork
      child: BlocListener<CalendarCubit, CalendarState>(
        listener: (context, state) {
          if (state.datastatus == DataStatus.success) {
            context.read<DailyWorkCubit>().getTodayWork(state.today);
            context.read<QuranCubit>().getQuran();
          }
        },
        child: BlocBuilder<SettingCubit, SettingState>(
            builder: (context, presenter) => Container(
                  // decoration: BoxDecoration(
                  //   color: theme.scaffoldBackgroundColor,
                  //   image: theme.brightness == Brightness.dark
                  //       ? null
                  //       : DecorationImage(
                  //           image: AssetImage(
                  //             theme.brightness == Brightness.dark
                  //                 ? "assets/images/bac_dark.jpg"
                  //                 : "assets/images/bak.png",
                  //           ),
                  //           fit: BoxFit.cover,
                  //         ),
                  // ),
                  child: Scaffold(
                    backgroundColor: theme.brightness == Brightness.dark
                        ? theme.scaffoldBackgroundColor
                        : Colors.white,
                    appBar: PreferredSize(
                        preferredSize: const Size.fromHeight(0),
                        child: AppBar(excludeHeaderSemantics: true)),
                    extendBody: true,
                    key: _scaffoldKey,
                    bottomNavigationBar: BottomBar(
                      theme: theme,
                      controller: controller,
                      currentpageIndex: presenter.setting.currentpageIndex,
                    ),
                    body: IndexedStack(
                      index: presenter.setting.currentpageIndex,
                      children: pages,
                    ),
                  ),
                )),
      ),
    );
  }
}

class BottomNavigationIcon extends StatelessWidget {
  const BottomNavigationIcon({
    super.key,
    required this.iconData,
    required this.isSelect,
  });

  final bool isSelect;
  final String iconData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: isSelect ? theme.primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: isSelect
                ? null
                : [
                    BoxShadow(
                        blurRadius: 20,
                        offset: const Offset(0, 1),
                        color: jbUnselectColor.withOpacity(0.4),
                        blurStyle: BlurStyle.inner),
                    BoxShadow(
                        blurRadius: 20,
                        offset: const Offset(0, -1),
                        color: jbUnselectColor.withOpacity(0.2),
                        blurStyle: BlurStyle.outer)
                  ]),
        child: SvgPicture.asset(
          "assets/svg/$iconData.svg",
          height: 25,
          color: isSelect ? Colors.white : jbUnselectColor,
        ));
  }
}
