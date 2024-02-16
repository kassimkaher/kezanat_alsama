import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ramadan/bussines_logic/prayer/fuctions/functions.dart';
import 'package:ramadan/bussines_logic/prayer/model/prayer_model.dart';
import 'package:ramadan/src/core/resources/validation.dart';
import 'package:ramadan/utils/translate.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

extension KQDatime on DateTime {
  String toDayName(local) {
    try {
      final format2 = DateFormat('E', local);
      final d = this.toLocal();
      final date = format2.format(d);
      return date;
    } catch (e) {
      return "N";
    }
  }
}

extension RText on String {
  Widget toGradiant(
      {required TextStyle style,
      required List<Color> colors,
      TextAlign? textAlign}) {
    return GradientText(this,
        style: style, textAlign: textAlign ?? TextAlign.start, colors: colors);
  }
}

extension Dur on Duration {
  double toTime() {
    return durationToTime(this);
  }
}

extension KQ on String {
  String tr() {
    return Translation.lang == Lang.arbic
        ? Translation.arabicTranslate[this] ?? this
        : Translation.englishString[this] ?? this;
  }

  String toDate(local) {
    try {
      final format2 = DateFormat('E d MMM yyyy , h:mm a', local);
      final d = DateTime.parse(this).toLocal();
      final date = format2.format(d);
      return date;
    } catch (e) {
      return this;
    }
  }

  int? toInt() {
    return int.tryParse(this);
  }

  String toPrice() {
    if (this.length > 2) {
      var value = this;
      value = value.replaceAll(RegExp(r'\D'), '');
      value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
      return value;
    }
    return this;
  }

  String clearText() {
    if (this.replaceAll(" ", "").isNotEmpty) {
      return this;
    }
    return "";
  }

  double? getnum() {
    String? num = this.replaceAll(new RegExp(r'[^0-9]'), '');

    try {
      return num.isEmpty ? null : double.tryParse(num);
    } catch (e) {
      return null;
    }
  }

  String? getTextOnly() =>
      isEmpty ? null : replaceAll(RegExp(r'[^a-zء-ي]'), '');

  double toTimeZone() {
    final isMinus = this.contains("-");
    final number = double.parse(this.replaceAll("+", "").replaceAll("-", "+"));
    return number * (isMinus ? -1 : 1);
  }

  String toEnglishNumber() {
    return getEnglishNumber(this);
  }
}

extension Dgree on double {
  double toDgree() {
    return this * (pi / 180);
  }

  Duration toDuration() {
    return timeToDuration(this);
  }
}

extension KQI on int {
  String toPrice() {
    if (this.toString().length > 2) {
      var value = this.toString();
      value = value.replaceAll(RegExp(r'\D'), '');
      value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
      return value;
    }
    return this.toString();
  }
}

extension KQD on double {
  double finalPrice(double waller_balance) {
    double finalprice = 0;
    finalprice = waller_balance - this;
    if (finalprice >= 0) {
      return 0;
    }
    return finalprice * -1;
  }

  String toPrice() {
    final price = this.toQuantity();

    if (price.length > 2) {
      var value = this.toInt().toString();
      value = value.replaceAll(RegExp(r'\D'), '');
      value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
      return value;
    }
    return price;
  }

  String toQuantity() {
    final numb = this % 1;
    if (numb > 0) {
      return this.toString();
    }

    return this.toInt().toString();
  }
}

kdp({required name, required msg, required c}) {
  final col = {
    "r": "\x1B[31m",
    "gr": "\x1B[32m",
    "y": "\x1B[33m",
    "cy": "\x1B[36m",
    "b": "\x1B[34m",
    "m": "\x1B[35m"
  };
  final e = {
    "r": "🥵",
    "gr": "📗",
    "y": "😨",
    "cy": "🧑🏻‍🎤",
    "b": "👨🏻‍🏭",
    "m": "👩🏻‍🎤"
  };

  log("\x1B[37m ${e[c]} $name: ${col[c]}  $msg");
}

extension FarsiNumberExtension on String {
  String get arabicNumber {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    String text = this;
    for (int i = 0; i < english.length; i++) {
      text = text.replaceAll(english[i], farsi[i]);
    }
    return text;
  }
}

int getSeconds(hour, minute, second) {
  final s = second;
  final s1 = minute * 60;
  final s2 = hour * 60 * 60;
  return s + s1 + s2;
}

FullTime getDateFromSecond(int seconds) {
  final hour = (seconds > (3600) ? (seconds / 3600) : 0).toInt();
  final s = seconds % 60;

  final minuts = seconds ~/ 60 - (60 * hour);

  return FullTime(hour, minuts, s);
}

String getTimeFormat(
    {required int hour, required int minut, required int seconds}) {
  String hourLeft =
      hour.toString().length < 2 ? "0" + hour.toString() : hour.toString();

  String minuteLeft =
      minut.toString().length < 2 ? "0" + minut.toString() : minut.toString();

  String secondsLeft = seconds.toString().length < 2
      ? "0" + seconds.toString()
      : seconds.toString();

  String result = "$hourLeft:$minuteLeft:$secondsLeft";
  return result.arabicNumber;
}

String getTimeFormatWithoutSecond(
    {required int hour, required int minut, required int seconds}) {
  hour = hour > 12 ? hour - 12 : hour;
  String hourLeft =
      hour.toString().length < 2 ? "0" + hour.toString() : hour.toString();

  String minuteLeft =
      minut.toString().length < 2 ? "0" + minut.toString() : minut.toString();

  String result = "$hourLeft:$minuteLeft";
  return result.arabicNumber;
}
