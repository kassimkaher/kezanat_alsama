import 'package:flutter/material.dart';
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
