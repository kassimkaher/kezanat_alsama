import 'package:flutter/material.dart';
import 'package:ramadan/utils/utils.dart';

enum ValidatorEnum {
  required,
  email,
  phone,
  textOnly,
  number,
  familyNumber,
  cardNumber,
  password,
  salary
}

extension TextValidate on ValidatorEnum {
  String hint({String? a}) {
    var msg = "";
    switch (this) {
      case ValidatorEnum.required:
        msg = a ?? "is_required".tr();
        break;
      case ValidatorEnum.phone:
        msg = a ?? "phone_validate".tr();
        break;
      case ValidatorEnum.email:
        msg = a ?? "email_validator".tr();
        break;
      case ValidatorEnum.textOnly:
        msg = a ?? "text_validator".tr();
        break;
      case ValidatorEnum.number:
        msg = a ?? "number_validator".tr();
        break;
      case ValidatorEnum.familyNumber:
        msg = a ?? "card_national_family_validator".tr();
        break;
      case ValidatorEnum.cardNumber:
        msg = a ?? "enter_number_required".tr();
        break;
      case ValidatorEnum.password:
        msg = a ?? "password_hint".tr();
        break;
      case ValidatorEnum.salary:
        msg = a ?? "salary_hint".tr();
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
    a = getEnglishNumber(a!);
    if (!isPhoneRegex(a) ||
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
    value = getEnglishNumber(value);
    String patttern = r'^[0-9]+$';
    RegExp regExp = RegExp(patttern);
    return regExp.hasMatch(value.replaceAll(",", ""));
  }

  bool isCardNumebr(String value) {
    value = getEnglishNumber(value);
    bool isnumber = isNumebr(value) && (value.length == 6 || value.length == 7);
    return isnumber;
  }

  bool isNumberWithLength(String value, int length) {
    value = getEnglishNumber(value);
    bool isnumber = isNumebr(value) && (value.length == length);
    return isnumber;
  }

  bool isNumberWithLengthOrLess(String value, int length) {
    value = getEnglishNumber(value);
    bool isnumber = isNumebr(value) && (value.length <= length);
    return isnumber;
  }

  bool isValidEmail(String a) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(a);
  }

  bool isTextOnly(String a) {
    return a.isEmpty || RegExp(r'^([ ء-ي])+$').hasMatch(a.replaceAll(" ", ""));
  }

  bool isFamilyNumber(String a) {
    return RegExp(r'^(?=.*?\d)(?=.*?[a-zA-Z])[a-zA-Z\d]+$').hasMatch(a) &&
        a.length == 18;
  }

  bool isPassword(String a) {
    return a.length > 7;
  }
}

String getEnglishNumber(String value) {
  value = value.replaceAll('٠', '0');
  value = value.replaceAll('١', '1');
  value = value.replaceAll('٢', '2');
  value = value.replaceAll('٣', '3');
  value = value.replaceAll('٤', '4');
  value = value.replaceAll('٥', '5');
  value = value.replaceAll('٦', '6');
  value = value.replaceAll('٧', '7');
  value = value.replaceAll('٨', '8');
  value = value.replaceAll('٩', '9');
  return value;
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
