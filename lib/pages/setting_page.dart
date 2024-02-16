import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/alert/alert_desition.dart';
import 'package:ramadan/bussines_logic/Setting/settings_cubit.dart';
import 'package:ramadan/services/notification_service.dart';
import 'package:ramadan/bussines_logic/prayer/prayer_cubit.dart';
import 'package:ramadan/services/tasbeeh/entity/model/tasbeeh_model.dart';
import 'package:ramadan/services/tasbeeh/presentation/tasbeeh_page.dart';
import 'package:ramadan/src/admin/pages/admin_pannel.dart';

import 'package:ramadan/pages/cities_page.dart';
import 'package:ramadan/src/core/constant/const.dart';
import 'package:ramadan/src/core/widget/jb_button.dart';
import 'package:ramadan/src/main_app/widgets/custom_card.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = context.read<SettingCubit>();
    final controllerPrayer = context.read<PrayerCubit>();

    final size = MediaQuery.of(context).size;
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
                    Text("الوضع", style: theme.textTheme.titleSmall),
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
                    Text("الاشعارات", style: theme.textTheme.titleSmall),
                    const Spacer(),
                    Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultSpacing),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: theme.scaffoldBackgroundColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () => controller.setEnableNotification(true),
                            child: AnimatedContainer(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      kDefaultBorderRadius),
                                  color: (state
                                          .setting.setting!.enableNotification)
                                      ? theme.primaryColor
                                      : Colors.transparent),
                              child: Text(
                                "تفعيل",
                                style: theme.textTheme.titleMedium!.copyWith(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      kDefaultBorderRadius),
                                  color: !(state
                                          .setting.setting!.enableNotification)
                                      ? theme.primaryColor
                                      : Colors.transparent),
                              child: Text(
                                "إيقاف",
                                style: theme.textTheme.titleMedium!.copyWith(
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
                    const Icon(LucideIcons.bellRing),
                    const SizedBox(width: 10),
                    Text("اعادة ضبط الاشعارات",
                        style: theme.textTheme.titleSmall),
                    const Spacer(),
                    JBButton(
                      title: "اعادة",
                      backgroundColor: Colors.transparent,
                      color: theme.colorScheme.secondary,
                      onPressed: () {
                        controller.setNotification(
                            controllerPrayer.state.preyerTimes!);

                        showSchedualNotificationAthan(
                            title: "اختبار الاذان",
                            subtitle: "حان موعد اذان المغرب",
                            dateTime: DateTime.now().add(Duration(seconds: 5)),
                            id: 1);
                      },
                    ),
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
                    const Icon(LucideIcons.locate),
                    const SizedBox(width: 10),
                    Text(
                      state.setting.setting?.selectCity?.nameAr ?? "",
                      style: theme.textTheme.titleSmall,
                    ),
                    const Spacer(),
                    JBButton(
                      title: "تغيير",
                      backgroundColor: Colors.transparent,
                      color: theme.colorScheme.secondary,
                      onPressed: () {
                        KDAlert.showSheet(
                          context,
                          height: size.height * 0.935,
                          width: size.width,
                          title: "اختر المحافظة",
                          child: CityListView(
                            onSelect: () {
                              final controller = context.read<SettingCubit>();
                              final controllerPrayer =
                                  context.read<PrayerCubit>();

                              controllerPrayer.getPrayer(
                                  controller.state.setting.setting!.selectCity);
                              controller.setNotification(
                                  controllerPrayer.state.preyerTimes!);
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    to(
                      TasbeehPage(
                        tasbeehModel: TasbeehModel(
                          tasbeehList: [
                            TasbeehData(
                                title: "'تسبيح الزهراء عليها السلام'",
                                description:
                                    "تسبيح الزهراء، أو تسبيح فاطمة من الأذكار المشهورة عند الشيعة، وهو أن يقول المسبّح: الله أكبر (34) مرة، الحمد لله (33) مرة، سبحان الله (33) مرة.",
                                number: 34,
                                subtitle: "",
                                speak: "الله أكبر"),
                            TasbeehData(
                                title: "'تسبيح الزهراء عليها السلام'",
                                description:
                                    "تسبيح الزهراء، أو تسبيح فاطمة من الأذكار المشهورة عند الشيعة، وهو أن يقول المسبّح: الله أكبر (34) مرة، الحمد لله (33) مرة، سبحان الله (33) مرة.",
                                number: 33,
                                subtitle: "",
                                speak: "الحمد لله"),
                            TasbeehData(
                                title: "'تسبيح الزهراء عليها السلام'",
                                description:
                                    "تسبيح الزهراء، أو تسبيح فاطمة من الأذكار المشهورة عند الشيعة، وهو أن يقول المسبّح: الله أكبر (34) مرة، الحمد لله (33) مرة، سبحان الله (33) مرة.",
                                number: 33,
                                subtitle: "",
                                speak: "سبحان الله")
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: RCard(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding, vertical: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/beads.svg",
                        height: 25,
                        color: theme.iconTheme.color,
                      ),
                      const SizedBox(width: 10),
                      const Text("المسبحة"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              appMode == AppMode.admin
                  ? InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          to(
                            const AdminPageView(),
                          ),
                        );
                      },
                      child: RCard(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding, vertical: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              LucideIcons.database,
                              size: 25,
                              color: theme.iconTheme.color,
                            ),
                            const SizedBox(width: 10),
                            const Text("Admin"),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}
