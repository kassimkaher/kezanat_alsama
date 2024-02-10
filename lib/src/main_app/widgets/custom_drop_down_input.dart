import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/utils/utils.dart';

class CustomDropDownInput extends StatelessWidget {
  const CustomDropDownInput(
      {Key? key,
      required this.array,
      required this.onSelect,
      required this.hint,
      this.background,
      this.borderColor,
      this.bottomPadding,
      this.enable = true,
      this.leftPadding,
      this.rightPadding,
      this.topPadding,
      required this.selectValue,
      this.readOnly = false,
      this.onValidate,
      this.offset})
      : super(key: key);
  final List<Enum> array;
  final Function(Enum selectData) onSelect;

  final String hint;
  final Color? background;
  final double? leftPadding;
  final double? rightPadding;
  final double? topPadding;
  final double? bottomPadding;

  final bool enable;
  final Enum? selectValue;
  final Color? borderColor;
  final bool readOnly;
  final Offset? offset;
  final String? Function(Enum? value)? onValidate;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DropdownButtonFormField2<Enum>(
      //icon: const Icon(FeatherIcons.chevronDown),

      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (a) {
        if (onValidate != null && onValidate!(a) != null) {
          return onValidate!(a);
        }

        return a == null ? "is_required".tr() : null;
      },

      decoration: InputDecoration(
        fillColor: enable ? Colors.white70 : Colors.transparent,
        filled: true,
        hintText: hint,
        errorMaxLines: 2,
        isDense: true,
        enabled: enable,
        errorStyle: theme.textTheme.bodySmall?.copyWith(color: Colors.red),
        contentPadding:
            const EdgeInsets.only(bottom: 0, top: 0, left: 0, right: 0),
        hintStyle: theme.textTheme.bodyLarge,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            kDefaultBorderRadius,
          ),
          borderSide: const BorderSide(color: jbGary2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            kDefaultBorderRadius,
          ),
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            kDefaultBorderRadius,
          ),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
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
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            kDefaultBorderRadius,
          ),
          borderSide: const BorderSide(color: jbGary2),
        ),
      ),

      hint: Text(
        enable ? hint : (selectValue?.name.tr() ?? ""),
        style: theme.textTheme.bodyLarge,
      ),
      buttonStyleData: ButtonStyleData(
        height: 58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        ),
      ),

      iconStyleData: const IconStyleData(
          icon: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Icon(LucideIcons.chevronDown),
      )),

      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        ),
      ),

      value: selectValue,

      onChanged: (Enum? newValue) {
        readOnly ? null : onSelect(newValue!);
      },
      items: !enable
          ? null
          : array.map<DropdownMenuItem<Enum>>((Enum value) {
              return DropdownMenuItem<Enum>(
                value: value,
                child: Text(
                  value.name.tr(),
                  style: theme.textTheme.bodyMedium,
                ),
              );
            }).toList(),
    );
  }
}
