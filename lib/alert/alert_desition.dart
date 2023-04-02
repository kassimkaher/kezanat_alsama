import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/utils/utils.dart';

class KDAlert {
  // pushAlert1({
  //   required BuildContext context,
  //   required Widget child,
  //   Color? background,
  // }) {
  //   OverlayState? overlayState = Overlay.of(context);
  //   OverlayEntry overlayEntry;
  //   final query = MediaQuery.of(context);
  //   final theme = Theme.of(context);
  //   overlayEntry = OverlayEntry(builder: (context) {
  //     return Positioned(
  //         left: query.size.width * 0.1,
  //         top: query.size.height * 0.80,
  //         child: Focus(
  //           onFocusChange: (a) {
  //             print(a);
  //           },
  //           autofocus: true,
  //           child: Container(
  //               width: query.size.width,
  //               color: background ?? theme.dialogBackgroundColor,
  //               child: child),
  //         ));
  //   });

  //   // inserting overlay entry
  //   overlayState.insert(overlayEntry);
  // }

  static showOverly(
      {required BuildContext context,
      required Widget child,
      bool isRequired = false}) {
    Navigator.push(
      context,
      CupertinoModalPopupRoute(
        barrierDismissible: !isRequired,
        builder: (c) => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Material(
              color: Colors.transparent,
              child: Align(alignment: Alignment.center, child: child),
            )
          ],
        ),
      ),
    );
  }

  KDAlert.showSheet1(
    BuildContext context, {
    required double height,
    required double width,
    required Widget child,
  }) {
    final theme = Theme.of(context);
    showOverly(
        context: context,
        child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: 100,
                maxWidth: width,
                maxHeight: height,
                minHeight: 100),
            child: Material(shape: theme.dialogTheme.shape, child: child)));
  }

  KDAlert.showSheet(BuildContext context,
      {required String title,
      required double height,
      required double width,
      required Widget child,
      Widget? action}) {
    final theme = Theme.of(context);
    showOverly(
        context: context,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: 100,
              maxWidth: width,
              maxHeight: height,
              minHeight: 100),
          child: Material(
            shape: theme.dialogTheme.shape,
            color: theme.scaffoldBackgroundColor,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: theme.colorScheme.outline),
                      ),
                      color: theme.scaffoldBackgroundColor),
                  child: Row(
                    children: [
                      Text(
                        title.tr(),
                        style: theme.textTheme.titleLarge,
                      ),
                      const Spacer(),
                      action ?? SizedBox(),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(LucideIcons.arrowLeft),
                      )
                    ],
                  ),
                ),
                Expanded(child: child)
              ],
            ),
          ),
        ));
  }
}

class AlertLayout extends HookWidget {
  const AlertLayout(
      {super.key,
      this.height,
      this.width,
      this.padding,
      this.background,
      required this.child});
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color? background;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final complete = useState(false);

    final theme = Theme.of(context);
    Future.delayed(const Duration(milliseconds: 1))
        .then((a) => complete.value = true);
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedScale(
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.center,
            scale: complete.value ? 1 : 0.1,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: width ?? double.infinity,
                  maxHeight: height ?? double.infinity,
                  minHeight: 100,
                  minWidth: 100),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipPath(
                      clipper: RPSCustomPainter(),
                      child: Material(
                        shape: theme.dialogTheme.shape,
                        color: background,
                        child: Padding(
                          padding: padding ?? const EdgeInsets.all(12.0),
                          child: child,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 35,
                    height: 35,
                    child: Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          LucideIcons.x,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RPSCustomPainter extends CustomClipper<Path> {
  @override
  @override
  Path getClip(Size size) {
    const shape = 28.0;
    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(size.width - shape, 0);
    path_0.arcToPoint(Offset(size.width, shape),
        radius: Radius.circular(15), clockwise: false);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, size.height);

    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
