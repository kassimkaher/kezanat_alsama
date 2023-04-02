import 'package:flutter/material.dart';
import 'package:ramadan/utils/utils.dart';

class JBButton extends StatelessWidget {
  const JBButton(
      {Key? key,
      required this.title,
      this.icon,
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

  final IconData? icon;
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

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        textStyle: textStyle ?? theme.textTheme.titleSmall,
        foregroundColor: color,
        backgroundColor: backgroundColor,
        disabledBackgroundColor: theme.colorScheme.outline,
        disabledForegroundColor: Colors.white,
        padding: icon != null ? EdgeInsets.zero : null,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        ),
      ),
      onPressed: isLoading || onPressed == null ? null : () => onPressed!(),
      child: isLoading
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
              child: icon != null && title.isEmpty
                  ? Icon(
                      icon,
                      color: color,
                      size: iconSize,
                    )
                  : Text(
                      title,
                    ),
            ),
    );
  }
}
