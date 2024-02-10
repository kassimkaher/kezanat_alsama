import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/utils/utils.dart';

class TMDropdownButton extends StatelessWidget {
  const TMDropdownButton(
      {Key? key,
      required this.array,
      required this.onSelect,
      required this.hint,
      required this.selectValue,
      required this.isLoading})
      : super(key: key);
  final List<Enum> array;
  final Function(Enum selectData) onSelect;

  final String hint;

  final Enum? selectValue;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DropdownButton2<Enum>(
      buttonStyleData: ButtonStyleData(
        height: 58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        ),
      ),
      underline: const SizedBox(),
      iconStyleData: const IconStyleData(
        icon: Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Icon(LucideIcons.chevronDown),
        ),
      ),
      customButton: SizedBox(
        width: 110,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              selectValue?.name.tr() ?? "",
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.end,
            ),
            const SizedBox(width: 8),
            isLoading
                ? const SizedBox(
                    height: 24, width: 24, child: CircularProgressIndicator())
                : Icon(LucideIcons.chevronDown,
                    color: theme.textTheme.bodySmall!.color),
          ],
        ),
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        ),
      ),
      value: selectValue,
      onChanged: (Enum? newValue) {
        isLoading ? null : onSelect(newValue!);
      },
      items: array.map<DropdownMenuItem<Enum>>((Enum value) {
        return DropdownMenuItem<Enum>(
          value: value,
          child: Text(
            value.name.tr(),
            style: theme.textTheme.bodySmall,
          ),
        );
      }).toList(),
    );
  }
}
