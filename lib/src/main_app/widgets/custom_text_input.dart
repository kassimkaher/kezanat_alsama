import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/src/core/resources/validation.dart';
import 'package:ramadan/utils/utils.dart';

class CustomTextInput extends HookWidget {
  const CustomTextInput(
      {Key? key,
      this.trailing,
      this.label,
      this.icon,
      this.enable = true,
      this.controller,
      this.textInputType = TextInputType.text,
      this.maxLine,
      this.borderColor,
      this.backgroundColor,
      this.onFocus,
      this.leftPadding,
      this.rightPadding,
      this.bottomPadding,
      this.topPadding,
      this.maxLength,
      this.isRequired,
      this.validator,
      this.disableColor,
      this.suffixIcon,
      this.readOnly = false,
      this.onChanged,
      this.errorStyle,
      this.onTap,
      this.validatThis,
      this.inputFormat,
      this.height,
      this.textAlign = TextAlign.start})
      : super(key: key);

  final bool readOnly;
  final bool enable;
  final Widget? trailing;
  final Widget? suffixIcon;
  final Widget? icon;

  final TextEditingController? controller;
  final TextInputType textInputType;
  final Color? borderColor;
  final Color? disableColor;
  final Color? backgroundColor;
  final int? maxLine;

  final double? leftPadding;
  final double? rightPadding;
  final double? topPadding;
  final double? bottomPadding;
  final int? maxLength;
  final ValidatorEnum? isRequired;
  final ValidatorEnum? validator;
  final String? label;
  final TextStyle? errorStyle;
  final Function(String value)? onChanged;
  final Function()? onTap;
  final void Function(bool isFocus)? onFocus;
  final String? Function(String? value)? validatThis;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormat;
  final double? height;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isPasswordShowMessage = useState(false);
    return SizedBox(
      height: height,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLines: maxLine ?? 1,
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
        keyboardType: textInputType,
        controller: controller,
        readOnly: readOnly,
        inputFormatters: inputFormat,
        enabled: enable,

        onTap: () {
          onTap != null ? onTap!() : null;
          // controller!.selection = TextSelection.fromPosition(
          //     TextPosition(offset: controller!.text.length));

          if (controller!.selection ==
              TextSelection.fromPosition(
                  TextPosition(offset: controller!.text.length - 1))) {
            controller!.selection = TextSelection.fromPosition(
                TextPosition(offset: controller!.text.length));
          }
        },
        textAlign: textAlign,
        textAlignVertical: TextAlignVertical.center,
        obscureText: textInputType == TextInputType.visiblePassword &&
            !isPasswordShowMessage.value,
        // onChanged: (value) {
        //   onChanged != null && !readOnly ? onChanged!(value) : null;
        // },
        decoration: InputDecoration(
          fillColor:
              !enable ? Colors.transparent : backgroundColor ?? Colors.white70,
          filled: true,
          hintText: label,

          suffixIcon: textInputType == TextInputType.visiblePassword
              ? IconButton(
                  onPressed: () => isPasswordShowMessage.value =
                      !isPasswordShowMessage.value,
                  icon: Icon(isPasswordShowMessage.value
                      ? LucideIcons.eye
                      : LucideIcons.eyeOff))
              : suffixIcon,
          errorStyle: errorStyle ??
              theme.textTheme.bodySmall?.copyWith(color: Colors.red),
          errorMaxLines: 2,
          prefixIcon: icon != null
              ? Padding(
                  padding: EdgeInsets.only(
                      right: rightPadding ?? kDefaultPadding,
                      left: leftPadding ?? kDefaultPadding,
                      bottom: bottomPadding ?? 0,
                      top: topPadding ?? 0),
                  child: icon,
                )
              : null,
          // suffix: suffixIcon,
          isDense: true,

          contentPadding: EdgeInsets.only(
              bottom: 12,
              top: 12,
              left: leftPadding ?? 0,
              right: rightPadding ?? 0),
          hintStyle: theme.textTheme.bodyLarge,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              kDefaultBorderRadius,
            ),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              kDefaultBorderRadius,
            ),
            borderSide: BorderSide(color: theme.primaryColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              kDefaultBorderRadius,
            ),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              kDefaultBorderRadius,
            ),
            borderSide: const BorderSide(color: Colors.red),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              kDefaultBorderRadius,
            ),
            borderSide: const BorderSide(color: jbGary2),
          ),
          enabledBorder: readOnly
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    kDefaultBorderRadius,
                  ),
                  borderSide: const BorderSide(color: jbGary2),
                )
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    kDefaultBorderRadius,
                  ),
                  borderSide: BorderSide(
                    color: borderColor ?? Colors.transparent,
                  ),
                ),
        ),
        style: theme.textTheme.titleSmall,
        validator: (h) {
          if (isRequired != null && !isRequired!.isRequired(h!)) {
            return isRequired?.hint();
          }
          if (validatThis != null) {
            return validatThis!(h);
          }

          if (validator != null) {
            if (validator == ValidatorEnum.phone && !validator!.isPhone(h)) {
              return validator?.hint();
            }

            if (validator == ValidatorEnum.email &&
                !validator!.isValidEmail(h!)) {
              return validator?.hint();
            }
            if (validator == ValidatorEnum.textOnly &&
                !validator!.isTextOnly(h!)) {
              return validator?.hint();
            }
            if (validator == ValidatorEnum.number && !validator!.isNumebr(h!)) {
              return validator?.hint();
            }
            if (validator == ValidatorEnum.familyNumber &&
                !validator!.isFamilyNumber(h!)) {
              return validator?.hint();
            }
            if (validator == ValidatorEnum.cardNumber &&
                !validator!.isCardNumebr(h!)) {
              return validator?.hint();
            }
            if (validator == ValidatorEnum.password &&
                !validator!.isPassword(h!)) {
              return validator?.hint();
            }
            if (validator == ValidatorEnum.salary && h!.length > 11) {
              return validator?.hint();
            }
          }

          return null;
        },
      ),
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String patttern = r'^[٠-٩]+$';
    RegExp regExp = RegExp(patttern);
    var isAr = regExp.hasMatch(newValue.text.replaceAll(",", ""));
    if (newValue.text.length < 3) {
      return newValue.copyWith(
          text: newValue.text,
          selection: TextSelection.collapsed(offset: newValue.text.length));
    }

    var value = newValue.text.toEnglishNumber();
    value = value.replaceAll(RegExp(r'\D'), '');
    value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');

    return newValue.copyWith(
        text: isAr ? value.arabicNumber : value,
        selection: TextSelection.collapsed(offset: value.length));
  }
}
