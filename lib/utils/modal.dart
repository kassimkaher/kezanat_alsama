import 'package:flutter/material.dart';

Future<T?> showModal<T>(
    {required BuildContext context,
    required Widget Function(BuildContext, ScrollController) builder,
    double? topSpace,
    bool? enableDrag}) {
  final query = MediaQuery.of(context);
  final theme = Theme.of(context);

  return showModalBottomSheet<T>(
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return SizedBox.expand(
          child: DraggableScrollableSheet(
              initialChildSize: topSpace ?? 0.95,
              maxChildSize: topSpace ?? 0.95,
              minChildSize: 0.0,
              snap: true,
              builder: (_, scrollController) =>
                  builder(context, ScrollController())),
        );
      },
      backgroundColor: Colors.transparent,
      elevation: 0);
}
