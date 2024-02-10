import 'dart:developer';

import 'package:flutter/rendering.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/utils/utils.dart';

class CustomDropDownMenuString extends StatefulWidget {
  const CustomDropDownMenuString(
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
      this.prefixIcon,
      this.isNullable = false,
      this.offset})
      : super(key: key);
  final List<String> array;
  final Function(String selectData) onSelect;

  final String hint;
  final Color? background;
  final double? leftPadding;
  final double? rightPadding;
  final double? topPadding;
  final double? bottomPadding;

  final bool enable;
  final String? selectValue;
  final Color? borderColor;
  final bool readOnly;
  final Offset? offset;
  final Widget? prefixIcon;
  final bool isNullable;

  @override
  State<CustomDropDownMenuString> createState() =>
      _CustomDropDownMenuStringState();
}

class _CustomDropDownMenuStringState extends State<CustomDropDownMenuString> {
  final keyWidget = GlobalKey();
  double? width;
  void afterBuild(_) {
    RenderBox renderBox =
        keyWidget.currentContext?.findRenderObject() as RenderBox;
    setState(() {
      width = renderBox.size.width - 48;
    });
    log('Width of the widget: $width');
  }

  @override
  void initState() {
    super.initState();
  }

  // @override
  // void didUpdateWidget(covariant CustomDropDownMenuString oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  //   WidgetsBinding.instance.addPostFrameCallback(afterBuild);
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      key: keyWidget,
      child: DropdownButtonFormField<String>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (a) {
          if (widget.isNullable && a == null) {
            return null;
          }
          return a == null ? "is_required".tr() : null;
        },
        decoration: InputDecoration(
          fillColor: widget.enable ? Colors.white70 : Colors.transparent,
          filled: true,
          hintText: widget.hint,
          errorMaxLines: 2,
          isDense: true,
          enabled: widget.enable,
          // errorStyle: theme.textTheme.bodySmall?.copyWith(color: Colors.red),
          contentPadding:
              const EdgeInsets.only(bottom: 12, top: 12, left: 8, right: 8),
          //  hintStyle: theme.textTheme.bodySmall,
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
          widget.hint,
          style: theme.textTheme.bodySmall,
        ),
        style: theme.textTheme.titleMedium,
        // buttonStyleData: ButtonStyleData(
        //   height: 58,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        //   ),
        // ),
        icon: const Icon(LucideIcons.chevronDown),
        // dropdownStyleData: DropdownStyleData(
        //   decoration: BoxDecoration(
        //     color: theme.cardColor,
        //     borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        //   ),
        // ),
        value: widget.selectValue,
        onChanged: (String? newValue) {
          widget.readOnly ? null : widget.onSelect(newValue!);
        },
        items: widget.array.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            alignment: Alignment.center,
            child: Container(
              // padding: const EdgeInsets.symmetric(vertical: 4),
              // margin: const EdgeInsets.only(bottom: 8),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: jbGary2))),
              child: Text(
                value.tr(),
                style: theme.textTheme.titleSmall!
                    .copyWith(color: jbAccentSecondary),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
