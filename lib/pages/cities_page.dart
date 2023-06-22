import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramadan/bussines_logic/Setting/settings_cubit.dart';
import 'package:ramadan/bussines_logic/dua/dua_cubit.dart';
import 'package:ramadan/bussines_logic/prayer/prayer_cubit.dart';
import 'package:ramadan/pages/main_page.dart';
import 'package:ramadan/utils/utils.dart';

class CitiesPage extends StatelessWidget {
  const CitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ramadanCubit = context.read<PrayerCubit>();

    final duaController = context.read<DuaCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("اختر المخافظة"),
      ),
      body: CityListView(
        onSelect: () {
          ramadanCubit.getPrayer(
              context.read<SettingCubit>().state.setting.setting!.selectCity);
          ramadanCubit.listenTime(duaController);

          Navigator.pushReplacement(
            context,
            to(
              MainPage(),
            ),
          );
        },
      ),
    );
  }
}

class CityListView extends StatelessWidget {
  const CityListView({super.key, required this.onSelect});
  final Function() onSelect;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SettingCubit>();
    final theme = Theme.of(context);
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        return ListView.builder(
            padding: const EdgeInsets.all(kDefaultPadding),
            itemCount: state.setting.cities?.provinces?.length,
            itemBuilder: (c, i) => InkWell(
                  onTap: () {
                    controller.setCityIndex(i);
                    onSelect();
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        state.setting.cities?.provinces?[i].nameAr ?? "",
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
