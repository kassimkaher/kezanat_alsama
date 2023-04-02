import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ramadan/bussines_logic/Setting/settings_cubit.dart';
import 'package:ramadan/bussines_logic/dua/dua_cubit.dart';
import 'package:ramadan/bussines_logic/ramadan/ramadan_cubit.dart';
import 'package:ramadan/pages/cities_page.dart';
import 'package:ramadan/pages/main_page.dart';
import 'package:ramadan/utils/utils.dart';

class SplashPage extends HookWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final controller = context.read<SettingCubit>();
    final controllerRamadan = context.read<RamadanCubit>();
    final controllerDua = context.read<DuaCubit>();

    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        if (state is SettingStateInitial) {
          print(state);

          controller.getSetting(controllerRamadan, controllerDua);
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
                  right: state.setting.isBegin ? -80 : -300,
                  top: state.setting.isBegin ? -80 : -150,
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
                  left: state.setting.isBegin ? -100 : -300,
                  bottom: state.setting.isBegin ? -100 : -400,
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
                        Future.delayed(const Duration(milliseconds: 800)).then(
                          (value) => Navigator.pushReplacement(
                            context,
                            to(
                              state.setting.setting?.city != null
                                  ? MainPage()
                                  : const CitiesPage(),
                            ),
                          ),
                        );
                      },
                      duration: const Duration(milliseconds: kSplashDuration),
                      scale: state.setting.isBegin ? 1 : 0.4,
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
      },
    );
  }
}
