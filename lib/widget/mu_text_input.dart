import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/services/validation.dart';
import 'package:ramadan/utils/utils.dart';

class FDTextInput extends HookWidget {
  const FDTextInput(
      {Key? key,
      this.focusNode,
      this.trailing,
      this.label,
      this.icon,
      this.controller,
      this.onFocus,
      this.suffixIcon,
      this.textAlign = TextAlign.start,
      required this.onSubmit,
      required this.onType})
      : super(key: key);

  final Widget? trailing;
  final Widget? suffixIcon;
  final Widget? icon;

  final TextEditingController? controller;

  final String? label;
  final FocusNode? focusNode;
  final void Function(bool isFocus)? onFocus;
  final TextAlign textAlign;
  final Function(String value) onType;
  final Function(String value) onSubmit;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Focus(
      child: SizedBox(
        child: TextFormField(
          focusNode: focusNode,
          maxLines: 1,
          controller: controller,
          textAlign: textAlign,
          onChanged: onType,
          onFieldSubmitted: onSubmit,
          decoration: InputDecoration(
            filled: false,
            hintText: label,
            prefixIcon: Icon(LucideIcons.search),
            isDense: true,
            contentPadding:
                EdgeInsets.only(bottom: 12, top: 12, left: 0, right: 0),
            hintStyle: theme.textTheme.displaySmall!.copyWith(fontSize: 16),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
          style: theme.textTheme.titleSmall,
        ),
      ),
    );
  }

  showMessage(ValueNotifier<bool> isShow) {
    isShow.value = true;

    Future.delayed(const Duration(seconds: 4))
        .then((value) => isShow.value = false);
  }
}

class ToolTipCustomShape extends ShapeBorder {
  final bool usePadding;
  final bool isArabic;
  ToolTipCustomShape({this.usePadding = true, this.isArabic = false});

  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.only(bottom: usePadding ? 0 : 0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect = Rect.fromPoints(rect.topLeft, rect.bottomRight - const Offset(0, 0));

    return isArabic
        ? (Path()
          ..addRRect(
            RRect.fromRectAndRadius(
              rect,
              const Radius.circular(kDefaultBorderRadius),
            ),
          )
          ..moveTo(rect.bottomLeft.dx + 25, rect.bottomCenter.dy)
          ..relativeLineTo(0, 15)
          ..relativeLineTo(10, -15)
          ..close())
        : (Path()
          ..addRRect(
            RRect.fromRectAndRadius(
              rect,
              Radius.circular(rect.height / 3),
            ),
          )
          ..moveTo(rect.bottomRight.dx - 35, rect.bottomCenter.dy)
          ..relativeLineTo(10, 15)
          ..relativeLineTo(0, -15)
          ..close());
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
