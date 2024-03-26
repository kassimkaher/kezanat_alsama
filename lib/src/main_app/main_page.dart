import 'package:flutter_svg/flutter_svg.dart';
import 'package:ramadan/bussines_logic/Setting/cubit/setting_cubit.dart';
import 'package:ramadan/src/admin/logic/calendar_cubit/calendar_cubit.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/main_app/dua/dua_page.dart';
import 'package:ramadan/src/main_app/home/daily_work/logic/daily_work_logic/daily_work_cubit.dart';
import 'package:ramadan/src/main_app/home/presentation/page/home.dart';
import 'package:ramadan/src/main_app/other/cubit/document_cubit.dart';
import 'package:ramadan/src/main_app/other/other_page.dart';
import 'package:ramadan/src/main_app/quran/juzu/cubit/quran_juzu_cubit.dart';
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

    context.read<SliderCubit>().getSliders();
    context
        .read<DailyWorkCubit>()
        .getTodayWorkFromRemote(context.read<CalendarCubit>().state.today);

    context.read<QuranJuzuCubit>().getQuranJuzuData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = context.read<SettingCubit>();
    final controllerPrayer = context.read<PrayerCubit>();

    final pages = [
      const HomePage(),
      const QuranPage(),
      const DuaPage(),
      const OtherWorkPage(),
    ];

    if (controllerPrayer.state.datastatus is DataIdeal) {
      context.read<DocumentCubit>().getWorksDocumentModel();
      controllerPrayer
          .prayerSchedular(context.read<CalendarCubit>().state.today!);
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: kDefaultDuration),

      //whait calendar loaded today info and then get dailwork
      child: BlocListener<CalendarCubit, CalendarState>(
        listener: (context, state) {
          if (state.datastatus == const SateSucess()) {}
        },
        child: BlocBuilder<SettingCubit, SettingState>(
          builder: (context, presenter) => Scaffold(
            backgroundColor: Colors.transparent,
            key: _scaffoldKey,
            bottomNavigationBar: BottomBar(
              theme: theme,
              controller: controller,
              currentpageIndex: presenter.currentpageIndex,
            ),
            body: Container(
              decoration: BoxDecoration(
                color: theme.canvasColor,
                image: DecorationImage(
                    image: AssetImage(context.read<SettingCubit>().isDarkMode()
                        ? "assets/images/bk.png"
                        : "assets/images/bk_light.png"),
                    fit: BoxFit.fitHeight),
              ),
              child: IndexedStack(
                index: presenter.currentpageIndex,
                children: pages,
              ),
            ),
          ),
        ),
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
          color: isSelect ? Colors.white : theme.disabledColor,
        ));
  }
}
