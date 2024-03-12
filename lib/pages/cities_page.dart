import 'package:ramadan/bussines_logic/Setting/cubit/setting_cubit.dart';
import 'package:ramadan/model/city.dart';
import 'package:ramadan/src/admin/logic/calendar_cubit/calendar_cubit.dart';
import 'package:ramadan/src/main_app/main_page.dart';
import 'package:ramadan/src/main_app/widgets/adaptive_dialog_appbar.dart';
import 'package:ramadan/utils/utils.dart';

class CitiesPage extends StatelessWidget {
  const CitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AdaptivAppBar(title: "اختر المخافظة"),
            Expanded(
              child: CityListView(
                onSelect: (province) {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                    return;
                  }
                  context.read<PrayerCubit>().getPrayer(
                      province.toCityDetailsModel(),
                      context.read<CalendarCubit>().state.calendarModel!);
                  Navigator.pushReplacement(
                    context,
                    to(
                      const MainPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CityListView extends StatelessWidget {
  const CityListView({super.key, required this.onSelect});
  final Function(ProvinceData provinceData) onSelect;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SettingCubit>();
    final theme = Theme.of(context);
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        return ListView.builder(
            padding: const EdgeInsets.all(kDefaultPadding),
            itemCount: state.cities?.provinces?.length,
            itemBuilder: (c, i) => InkWell(
                  onTap: () {
                    controller.setCityIndex(i);
                    onSelect(state.cities!.provinces![i]);
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        state.cities?.provinces?[i].nameAr ?? "",
                        style:
                            theme.textTheme.titleLarge!.copyWith(fontSize: 18),
                      ),
                    ),
                  ),
                ));
      },
    );
  }
}
