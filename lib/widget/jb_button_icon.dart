import 'package:flutter/material.dart';

import 'package:ramadan/utils/color.dart';
import 'package:ramadan/utils/const.dart';

class JBIconButton extends StatelessWidget {
  const JBIconButton(
      {Key? key,
      required this.icon,
      this.color = jbFontColorD,
      this.backgroundColor,
      this.borderColor,
      this.onPressed,
      this.isLoading = false,
      this.padding,
      this.iconSize})
      : super(key: key);

  final IconData icon;
  final Color color;
  final Color? backgroundColor;

  final Color? borderColor;
  final Function? onPressed;
  final bool isLoading;

  final EdgeInsetsGeometry? padding;

  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: color,
        backgroundColor: backgroundColor ?? jbGary2,
        disabledBackgroundColor: jbOutlineColor,
        disabledForegroundColor: Colors.white,
        padding: padding,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        ),
      ),
      onPressed: isLoading || onPressed == null ? null : () => onPressed!(),
      child: Icon(
        icon,
        size: iconSize ?? 20,
      ),
    );
  }
}
