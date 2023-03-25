import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ramadan/bussines_logic/Setting/settings_cubit.dart';
import 'package:ramadan/bussines_logic/dua/dua_cubit.dart';
import 'package:ramadan/bussines_logic/ramadan/ramadan_cubit.dart';
import 'package:ramadan/pages/main_page.dart';
import 'package:ramadan/utils/utils.dart';

class SplashPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isBegin = useState(false);
    final theme = Theme.of(context);
    final controller = context.read<SettingCubit>();
    final controller1 = context.read<RamadanCubit>();
    final duaCupit = context.read<DuaCubit>();
    controller.getIsSetNotification();
    if (controller1.state is RamadanStateInital) {
      controller1.listenTime(duaCupit);
    }
    if (!isBegin.value) {
      Future.delayed(const Duration(milliseconds: 10))
          .then((value) => isBegin.value = true);
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          color: scaffoldColor,
          image: DecorationImage(
            image: AssetImage("assets/images/bak.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            SizedBox(width: size.width, height: size.height),
            AnimatedPositioned(
              duration: const Duration(milliseconds: kSplashDuration),
              right: isBegin.value ? -80 : -300,
              top: isBegin.value ? -80 : -150,
              child: Transform.rotate(
                angle: 0.2,
                child: SizedBox(
                  child: Image.asset(
                    "assets/images/splash.png",
                    fit: BoxFit.contain,
                    height: 300,
                    alignment: Alignment.topRight,
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: kSplashDuration),
              left: isBegin.value ? -100 : -300,
              bottom: isBegin.value ? -100 : -400,
              child: Transform.scale(
                scale: 1,
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: Image.asset(
                    "assets/images/splash.png",
                    fit: BoxFit.contain,
                    alignment: Alignment.topRight,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: AnimatedScale(
                  onEnd: () {
                    Future.delayed(const Duration(milliseconds: 1000)).then(
                        (value) =>
                            Navigator.pushReplacement(context, to(MainPage())));
                  },
                  duration: const Duration(milliseconds: kSplashDuration),
                  scale: isBegin.value ? 1 : 0.4,
                  child: SizedBox(
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.contain,
                      alignment: Alignment.topRight,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
