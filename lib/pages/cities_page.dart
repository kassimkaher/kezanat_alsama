import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramadan/bussines_logic/Setting/settings_cubit.dart';
import 'package:ramadan/bussines_logic/dua/dua_cubit.dart';
import 'package:ramadan/bussines_logic/ramadan/ramadan_cubit.dart';
import 'package:ramadan/pages/main_page.dart';
import 'package:ramadan/utils/utils.dart';

class CitiesPage extends StatelessWidget {
  const CitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ramadanCubit = context.read<RamadanCubit>();
    final settingCubit = context.read<SettingCubit>();
    final duaController = context.read<DuaCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("اختر المخافظة"),
      ),
      body: CityListView(
        onSelect: () {
          ramadanCubit.getRamadan(
              settingCubit.state.setting.setting!.selectCity!.path!);
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
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        return ListView.builder(
            padding: const EdgeInsets.all(kDefaultPadding),
            itemCount: state.setting.cities?.city?.length,
            itemBuilder: (c, i) => InkWell(
                  onTap: () {
                    controller.setCityIndex(i);
                    onSelect();
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(state.setting.cities?.city?[i].name ?? ""),
                    ),
                  ),
                ));
      },
    );
  }
}
