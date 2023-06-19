import 'dart:ui';

import 'package:flutter/material.dart';

Future<T?> showModal<T>(
    {required BuildContext context,
    required Widget Function(BuildContext, ScrollController) builder,
    double? topSpace,
    bool? enableDrag,
    double? horizontalMargin}) {
  final query = MediaQuery.of(context);
  final theme = Theme.of(context);

  return showModalBottomSheet<T>(
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return Stack(
          children: [
            BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  height: query.size.height,
                  width: query.size.width,
                  color: theme.disabledColor.withOpacity(0.0),
                )),
            Container(
              margin: topSpace != null
                  ? EdgeInsets.symmetric(
                      vertical: topSpace / 2, horizontal: horizontalMargin ?? 0)
                  : EdgeInsets.symmetric(horizontal: horizontalMargin ?? 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: builder(
                  context,
                  ScrollController(),
                ),
              ),
            ),
          ],
        );
      },
      backgroundColor: Colors.transparent,
      elevation: 0);
}
