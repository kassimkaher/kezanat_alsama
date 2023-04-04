import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/bussines_logic/Setting/settings_cubit.dart';
import 'package:ramadan/bussines_logic/notification_service.dart';
import 'package:ramadan/bussines_logic/ramadan/ramadan_cubit.dart';
import 'package:ramadan/pages/home/emsal_view.dart';
import 'package:ramadan/utils/const.dart';
import 'package:ramadan/widget/jb_button.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = context.read<SettingCubit>();
    final controllerRamadan = context.read<RamadanCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("الاعدادات"),
      ),
      body: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.symmetric(
                vertical: kDefaultPadding, horizontal: 10),
            children: [
              RCard(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(LucideIcons.sunMoon),
                    const SizedBox(width: 10),
                    const Text("الوضع"),
                    const Spacer(),
                    Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: theme.scaffoldBackgroundColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () => controller.setDark(0),
                            child: AnimatedContainer(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      kDefaultBorderRadius),
                                  color:
                                      (state.setting.setting!.isDarkMode) == 0
                                          ? theme.primaryColor
                                          : Colors.transparent),
                              child: Text(
                                "تلقائي",
                                style: theme.textTheme.titleMedium!.copyWith(
                                    color:
                                        (state.setting.setting!.isDarkMode) == 0
                                            ? Colors.white
                                            : theme.disabledColor,
                                    fontSize:
                                        (state.setting.setting!.isDarkMode) == 0
                                            ? 16
                                            : 14),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => controller.setDark(2),
                            child: AnimatedContainer(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      kDefaultBorderRadius),
                                  color:
                                      (state.setting.setting!.isDarkMode) == 2
                                          ? theme.primaryColor
                                          : Colors.transparent),
                              child: Text(
                                "الداكن",
                                style: theme.textTheme.titleMedium!.copyWith(
                                    color:
                                        (state.setting.setting!.isDarkMode) == 2
                                            ? Colors.white
                                            : theme.disabledColor,
                                    fontSize:
                                        (state.setting.setting!.isDarkMode) == 2
                                            ? 16
                                            : 14),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => controller.setDark(1),
                            child: AnimatedContainer(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      kDefaultBorderRadius),
                                  color:
                                      (state.setting.setting!.isDarkMode) == 1
                                          ? theme.primaryColor
                                          : Colors.transparent),
                              child: Text(
                                "فاتح",
                                style: theme.textTheme.titleMedium!.copyWith(
                                    color:
                                        (state.setting.setting!.isDarkMode) == 1
                                            ? Colors.white
                                            : theme.disabledColor,
                                    fontSize:
                                        (state.setting.setting!.isDarkMode) == 1
                                            ? 16
                                            : 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              RCard(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(LucideIcons.bell),
                    const SizedBox(width: 10),
                    const Text("الاشعارات"),
                    const Spacer(),
                    Container(
                        height: 40,
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultSpacing),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: theme.scaffoldBackgroundColor),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () =>
                                    controller.setEnableNotification(true),
                                child: AnimatedContainer(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  duration: const Duration(milliseconds: 300),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          kDefaultBorderRadius),
                                      color: (state.setting.setting!
                                              .enableNotification)
                                          ? theme.primaryColor
                                          : Colors.transparent),
                                  child: Text(
                                    "تفعيل",
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(
                                            color: (state.setting.setting!
                                                    .enableNotification)
                                                ? Colors.white
                                                : theme.disabledColor,
                                            fontSize: (state.setting.setting!
                                                    .enableNotification)
                                                ? 16
                                                : 14),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () =>
                                    controller.setEnableNotification(false),
                                child: AnimatedContainer(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  duration: const Duration(milliseconds: 300),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          kDefaultBorderRadius),
                                      color: !(state.setting.setting!
                                              .enableNotification)
                                          ? theme.primaryColor
                                          : Colors.transparent),
                                  child: Text(
                                    "إيقاف",
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(
                                            color: !(state.setting.setting!
                                                    .enableNotification)
                                                ? Colors.white
                                                : theme.disabledColor,
                                            fontSize: !(state.setting.setting!
                                                    .enableNotification)
                                                ? 16
                                                : 14),
                                  ),
                                ),
                              ),
                            ]))
                  ],
                ),
              ),
              const SizedBox(height: 10),
              RCard(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(LucideIcons.bellRing),
                    const SizedBox(width: 10),
                    const Text("الاشعارات"),
                    const Spacer(),
                    JBButton(
                      title: "اعادة",
                      onPressed: () {
                        controller.setNotification(
                            controllerRamadan.state.info.emsackModel!);

                        showSchedualNotificationAthan(
                            title: "اختبار الاذان",
                            subtitle: "حان موعد اذان المغرب",
                            dateTime: DateTime.now().add(Duration(seconds: 5)),
                            id: 1);
                      },
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
