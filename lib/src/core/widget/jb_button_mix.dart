import 'package:flutter/material.dart';
import 'package:ramadan/utils/utils.dart';

class JBButtonMix extends StatelessWidget {
  const JBButtonMix(
      {Key? key,
      required this.title,
      required this.icon,
      this.color = Colors.white,
      this.backgroundColor,
      this.borderColor,
      this.onPressed,
      this.isLoading = false,
      this.padding,
      this.textStyle,
      this.isunderLine = false,
      this.iconSize})
      : super(key: key);

  final Widget icon;
  final Color color;
  final Color? backgroundColor;
  final String title;
  final Color? borderColor;
  final Function? onPressed;
  final bool isLoading;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final bool isunderLine;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = this.backgroundColor ?? theme.colorScheme.secondary;

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        textStyle: textStyle ?? theme.textTheme.titleMedium,
        foregroundColor: color,
        backgroundColor: backgroundColor,
        disabledBackgroundColor: jbOutlineColor,
        disabledForegroundColor: Colors.white,
        padding: padding ?? EdgeInsets.zero,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        ),
      ),
      icon: isLoading
          ? const SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Container(
              alignment: Alignment.center,
              height: 40,
              child: icon,
            ),
      onPressed: isLoading || onPressed == null ? null : () => onPressed!(),
      label: Text(
        title,
      ),
    );
  }
}
