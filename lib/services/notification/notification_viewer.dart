import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/services/notification/model/model.dart';
import 'package:ramadan/src/core/widget/jb_button_icon.dart';
import 'package:ramadan/src/main_app/main_page.dart';
import 'package:ramadan/utils/utils.dart';

class NotificationViewer extends StatelessWidget {
  const NotificationViewer({super.key, this.notificationModel});
  final NotificationModel? notificationModel;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  "assets/images/${notificationModel?.type?.name ?? "emsak"}_n.JPG"),
              //"assets/images/${notificationModel?.type?.name ?? "emsak"}_n.JPG"
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              const SizedBox(
                width: double.infinity,
                height: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: JBIconButton(
                  icon: LucideIcons.x,
                  color: Colors.white,
                  backgroundColor: theme.primaryColor,
                  onPressed: () {
                    if (navigatorKey.currentState?.canPop() ?? false) {
                      navigatorKey.currentState?.pop();
                      return;
                    }
                    navigatorKey.currentState!
                        .pushReplacement(to(const MainPage()));
                  },
                ),
              ),

              // Padding(
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 46, vertical: 16),
              //     child: switch (
              //             notificationModel?.type ?? NotificationType.other) {
              //       NotificationType.emsak => "اشرب الماء و عجل",
              //       NotificationType.fajer => "الله اكبر",
              //       NotificationType.duhur => "حان الان موعد اذان الفجر",
              //       NotificationType.mugrib => "حان الان موعد اذان الفجر",
              //       _ => "حدث مشكلة في التطبيق عاود التشغيل"
              //     }
              //         .toGradiant(
              //             style: theme.textTheme.displayLarge!
              //                 .copyWith(fontSize: 42),
              //             colors: [
              //           theme.scaffoldBackgroundColor,
              //           theme.primaryColor
              //         ])
              // [
              //   theme.scaffoldBackgroundColor,
              //   Colors.amber.shade700
              // ]

              //  Text(
              //   switch (notificationModel?.type ?? NotificationType.other) {
              //     NotificationType.emsak => "اشرب الماء و عجل",
              //     NotificationType.fajer => "الله اكبر",
              //     NotificationType.duhur => "حان الان موعد اذان الفجر",
              //     NotificationType.mugrib => "حان الان موعد اذان الفجر",
              //     _ => "حدث مشكلة في التطبيق عاود التشغيل"
              //   },
              //   style: theme.textTheme.titleLarge!.copyWith(
              //       color: switch (
              //           notificationModel?.type ?? NotificationType.other) {
              //         NotificationType.emsak => Colors.white,
              //         NotificationType.fajer => Colors.white,
              //         NotificationType.duhur => Colors.black,
              //         NotificationType.mugrib => Colors.white,
              //         _ => null
              //       },
              //       fontSize: 36),
              // ),
              //   ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 46, vertical: 16),
                    child: Text(
                      switch (
                          notificationModel?.type ?? NotificationType.other) {
                        NotificationType.emsak => "حان الان موعد الامساك",
                        NotificationType.fajer => "حان الان موعد اذان الفجر",
                        NotificationType.duhur => "حان الان موعد اذان الفجر",
                        NotificationType.mugrib => "حان الان موعد اذان الفجر",
                        _ => "حدث مشكلة في التطبيق عاود التشغيل"
                      },
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
