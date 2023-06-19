import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ramadan/utils/extention.dart';

enum Validator {
  required,
  email,
  phone,
  textOnly,
  number,
  familyNumber,
  cardNumber,
  password
}

extension TextValidate on Validator {
  String hint({String? a}) {
    var msg = "";
    switch (this) {
      case Validator.required:
        msg = a ?? "is_required".tr();
        break;
      case Validator.phone:
        msg = a ?? "phone_validate".tr();
        break;
      case Validator.email:
        msg = a ?? "email_validator".tr();
        break;
      case Validator.textOnly:
        msg = a ?? "text_validator".tr();
        break;
      case Validator.number:
        msg = a ?? "number_validator".tr();
        break;
      case Validator.familyNumber:
        msg = a ?? "card_national_family_validator".tr();
        break;
      case Validator.cardNumber:
        msg = a ?? "enter_number_required".tr();
        break;
      case Validator.password:
        msg = a ?? "password_hint".tr();
        break;
    }
    return msg;
  }

  bool isRequired(String? a) {
    if (a == null || a.isEmpty || a.replaceAll(" ", "").isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  bool isPhone(String? a) {
    if (!isPhoneRegex(a!) ||
        (a.length > 11 || a.length < 10) ||
        (a.length == 11 && a[0] != "0") ||
        (a.length == 10 && a[0] == "0") ||
        (a.length == 11 && a[1] != "7") ||
        (a.length == 10 && a[0] != "7")) {
      return false;
    } else {
      return true;
    }
  }

  bool isPhoneRegex(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    return regExp.hasMatch(value);
  }

  bool isNumebr(String value) {
    String patttern = r'^[0-9]+$';
    RegExp regExp = RegExp(patttern);
    return regExp.hasMatch(value.replaceAll(",", ""));
  }

  bool isCardNumebr(String value) {
    bool isnumber = isNumebr(value) && (value.length == 6 || value.length == 7);
    return isnumber;
  }

  bool isValidEmail(String a) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(a);
  }

  bool isTextOnly(String a) {
    return RegExp(r'^([a-z]||[A-Z]||[ ء-ي])+$').hasMatch(a.replaceAll(" ", ""));
  }

  bool isFamilyNumber(String a) {
    return RegExp(r'^(?=.*?\d)(?=.*?[A-Z])[A-Z\d]+$').hasMatch(a) &&
        a.length > 15;
  }

  bool isPassword(String a) {
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(a) &&
        a.length > 7;
  }
}

Future<OverlayEntry> showOverlay(BuildContext context, ValueNotifier<bool> show,
    {required String text}) async {
  var renderbox = context.findRenderObject() as RenderBox;
  var offset = renderbox.localToGlobal(Offset.zero);
  OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
    return Material(
      child: Positioned(
          left: offset.dx,
          top: offset.dy,
          child: Wrap(
            children: [
              Container(
                width: 100,
                height: 70,
                // decoration: ShapeDecoration(
                //     color: Colors.red, shape: ToolTipCustomShape()),
                child: Text("jfji"),
              ),
            ],
          )),
    );
  });

  return overlayEntry;
}

String? validateTextInput(String? value, ValueNotifier<int> isValidate,
    Validator? isRequired, Validator? validator) {
  if (isRequired != null && !isRequired.isRequired(value!)) {
    isValidate.value = 1;
    isValidate.notifyListeners();
    return isRequired.hint();
  }

  if (validator != null) {
    if (validator == Validator.phone && !validator.isPhone(value)) {
      isValidate.value = 2;
      isValidate.notifyListeners();
      return validator.hint();
    }

    if (validator == Validator.email && !validator.isValidEmail(value!)) {
      isValidate.value = 2;
      isValidate.notifyListeners();
      print("error email $validator");
      return validator.hint();
    } else {
      print("error email $validator");
    }
    if (validator == Validator.textOnly && !validator.isTextOnly(value!)) {
      isValidate.value = 2;
      isValidate.notifyListeners();
      return validator.hint();
    }
    if (validator == Validator.number && !validator.isNumebr(value!)) {
      isValidate.value = 2;
      isValidate.notifyListeners();
      return validator.hint();
    }
    if (validator == Validator.familyNumber &&
        !validator.isFamilyNumber(value!)) {
      isValidate.value = 2;
      isValidate.notifyListeners();
      return validator.hint();
    }
    if (validator == Validator.cardNumber && !validator.isCardNumebr(value!)) {
      isValidate.value = 2;
      isValidate.notifyListeners();
      return validator.hint();
    }
    if (validator == Validator.password && !validator.isPassword(value!)) {
      isValidate.value = 2;
      isValidate.notifyListeners();
      return validator.hint();
    }
  }

  isValidate.notifyListeners();
  isValidate.value = 0;

  return null;
}

int dateToJulian(int year, int month, int day) {
  int a = (14 - month) ~/ 12;
  int y = year + 4800 - a;
  int m = month + 12 * a - 3;
  int julianDay = day +
      ((153 * m + 2) ~/ 5) +
      (365 * y) +
      (y ~/ 4) -
      (y ~/ 100) +
      (y ~/ 400) -
      32045;
  return julianDay;
}

double equationOfTime(int dayOfYear) {
  // Convert the day of year to radians
  double n = 2 * pi * (dayOfYear - 1) / 365;

  // Calculate the equation of time in minutes
  double e = 229.18 *
      (0.000075 +
          0.001868 * cos(n) -
          0.032077 * sin(n) -
          0.014615 * cos(2 * n) -
          0.040849 * sin(2 * n));

  // Convert the equation of time to hours
  double equationInHours = e / 60;

  return equationInHours;
}

int getDayNumberInYear(DateTime currentDate) {
  int dayOfYear =
      currentDate.difference(DateTime(currentDate.year, 1, 1)).inDays + 1;
  return dayOfYear;
}

double sunDeclination(DateTime date) {
  final dec = 23.45 *
      sin(degToRad(360 *
          (284 +
              dateToJulian(date.year, date.month, getDayNumberInYear(date))) /
          365));

  return dec;
}

double calculateFajer(DateTime date, Dhuhr, double latitiude) {
  var d = sunDeclination(date);
// 0.28790331666 - 0.9502105809
  var top =
      (-sin(degToRad(16)) - (sin(degToRad(latitiude)) * sin(degToRad(d))));
  var bottom = (cos(degToRad(latitiude)) * cos(degToRad(d)));
  var qst = (top / bottom);
  var acrcos = radToDeg(acos(qst));
  // kdp(
  //     name: "claculate fajer",
  //     msg: "=latitiude=$latitiude====d=$d===qst=$qst====acrcos=$acrcos",
  //     c: "m");
  var T = (1 / 15) * acrcos;
  // -1.37802574747/0.0763487005
  double fajer = Dhuhr - T;

  return fajer;
}

double calculateEsha(DateTime date, Dhuhr, double latitiude) {
  var d = sunDeclination(date);
// 0.28790331666 - 0.9502105809
  var top =
      (-sin(degToRad(14)) - (sin(degToRad(latitiude)) * sin(degToRad(d))));
  var bottom = (cos(degToRad(latitiude)) * cos(degToRad(d)));
  var qst = (top / bottom);
  var acrcos = radToDeg(acos(qst));
  // kdp(
  //     name: "claculate fajer",
  //     msg: "=latitiude=$latitiude====d=$d===qst=$qst====acrcos=$acrcos",
  //     c: "m");
  var T = (1 / 15) * acrcos;
  // -1.37802574747/0.0763487005

  double esha = Dhuhr + T;

  return esha;
}

double calculateMugrib(DateTime date, Dhuhr, double latitiude) {
  var d = sunDeclination(date);
// 0.28790331666 - 0.9502105809
  var top = (-sin(degToRad(4)) - (sin(degToRad(latitiude)) * sin(degToRad(d))));
  var bottom = (cos(degToRad(latitiude)) * cos(degToRad(d)));
  var qst = (top / bottom);
  var acrcos = radToDeg(acos(qst));
  // kdp(
  //     name: "claculate fajer",
  //     msg: "=latitiude=$latitiude====d=$d===qst=$qst====acrcos=$acrcos",
  //     c: "m");
  var T = (1 / 15) * acrcos;
  // -1.37802574747/0.0763487005

  double esha = Dhuhr + T;

  return esha;
}

double calculateMidnite({required double fajer, required Duration sunset}) {
  final nightD = Duration(minutes: 1440 - sunset.inMinutes);
  final dur = fajer.toDuration().inMinutes + nightD.inMinutes;
  final halfDur = dur / 2;
  final midnight = Duration(minutes: halfDur.toInt() + sunset.inMinutes);

  //kdp(name: "calculateMidnite", msg: "midnight==$midnight===ZZZ", c: "m");
  return midnight.toTime();
}

String getTimeText(num hours) {
  var hour = (hours.toInt());
  var min = ((hours % 1) * 60).toInt();
  return "$hour:$min";
}

double durationToTime(Duration duration) {
  final du = (duration.inHours + (duration.inMinutes % 60) / 60);
  return du;
}

Duration timeToDuration(double time) {
  final h = time.toInt();
  var m = ((time % 1) * 60).toInt();

  return Duration(hours: h, minutes: m);
}

double degToRad(double degrees) {
  return degrees * pi / 180;
}

double radToDeg(double radians) {
  return radians * 180 / pi;
}
