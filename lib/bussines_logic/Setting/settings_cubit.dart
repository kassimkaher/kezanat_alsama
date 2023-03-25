import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramadan/services/local_db.dart';
import 'package:ramadan/utils/utils.dart';
part 'setting_state.dart';

class SettingCubit extends Cubit<NavigationState> {
  SettingCubit()
      : super(SettingStateMain(SettingInfo(
            menuKey: true,
            currentpageIndex: 1,
            currentPage: NavPages.home,
            currentLang: Lang.arbic,
            nodes: [
              FocusNode(),
              FocusNode(),
              FocusNode(),
              FocusNode(),
              FocusNode(),
              FocusNode(),
              FocusNode(),
              FocusNode(),
              FocusNode()
            ])));

  void toggleMenu(value) {
    state.setting.menuKey = value;

    refresh();
  }

  void changePage(NavPages page, int index) {
    state.setting.currentPage = page;
    state.setting.currentpageIndex = index;
    refresh();
  }

  refresh() {
    if (state is SettingStateMain) {
      emit(SettingStateSecond(state.setting));
      emit(SettingStateMain(state.setting));
      return;
    }
  }

  Future<void> getIsSetNotification() async {
    try {
      await LocalDB.inite();
      await Future.delayed(const Duration(milliseconds: 200));
      final data = LocalDB.getIsSetNotification();
      //kdp(name: "notification chek is set", msg: data, c: 'gr');
      state.setting.isSetNotification = data ?? false;
    } catch (e) {
      kdp(name: "notification chek is set", msg: e, c: 'r');
    }
    refresh();
  }

  Future<void> setIsNotification() async {
    LocalDB.setIsSetNotification(true);
    state.setting.isSetNotification = true;
    refresh();
  }
}

Route to(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: Duration(milliseconds: 20),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
