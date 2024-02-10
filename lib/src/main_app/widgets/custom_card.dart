import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ramadan/utils/utils.dart';

class RCard extends StatelessWidget {
  const RCard(
      {super.key,
      required this.child,
      this.margin,
      this.padding,
      this.background,
      this.height,
      this.width,
      this.borderRadius});

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? background;
  final double? height;
  final double? width;
  final double? borderRadius;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: height,
      width: width,
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: background ??
            (theme.primaryColor == jbPrimaryColor
                ? cardColor
                : theme.cardColor),
        borderRadius:
            BorderRadius.circular(borderRadius ?? kDefaultBorderRadius),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 4),
              color: theme.primaryColor == jbPrimaryColor
                  ? theme.colorScheme.outline
                  : Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 4),
        ],
      ),
      child: child,
    );
  }
}

class ForYouCard extends StatelessWidget {
  const ForYouCard({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultSpacing),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
          border: Border.all(color: jbUnselectColor.withOpacity(0.2))),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 0,
        dense: true,
        leading: SvgPicture.asset(
          "assets/svg/dua.svg",
          width: 25,
          color: Colors.black,
        ),
        title: title.toGradiant(
            style: theme.textTheme.titleMedium!.copyWith(fontSize: 16),
            colors: [Colors.black, Colors.black]),
      ),
    );
  }
}
