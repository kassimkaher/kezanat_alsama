// import 'package:jop_me/utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// enum SnackbarStyle { error, alert, success }

// showSnackbar({required String subtitle, required SnackbarStyle style}) {
//   try {
//     Get.closeAllSnackbars();
//   } catch (e) {}
//   Get.showSnackbar(GetSnackBar(
//       borderRadius: kDefaultBorderRadius,
//       margin: const EdgeInsets.all(kDefaultPadding),
//       padding: const EdgeInsets.all(kDefaultPadding),
//       backgroundColor: Colors.white,
//       snackStyle: SnackStyle.FLOATING,
//       forwardAnimationCurve: Curves.slowMiddle,
//       //reverseAnimationCurve: Curves.easeOutBack,
//       boxShadows: const [
//         BoxShadow(offset: Offset(0, 1), color: jbGrayCardColor)
//       ],
//       duration: const Duration(milliseconds: 2500),
//       messageText: ListTile(
//         contentPadding: EdgeInsets.zero,
//         leading: Container(
//           height: 40,
//           width: 40,
//           decoration: BoxDecoration(
//             color: (style == SnackbarStyle.error
//                     ? jbSecondary
//                     : style == SnackbarStyle.alert
//                         ? Colors.amber
//                         : style == SnackbarStyle.success
//                             ? Colors.green
//                             : jbSecondary)
//                 .withOpacity(0.2),
//             borderRadius: BorderRadius.circular(kDefaultBorderRadius),
//           ),
//           child: Icon(
//             style == SnackbarStyle.error
//                 ? Icons.info_outline
//                 : style == SnackbarStyle.alert
//                     ? Icons.warning_amber_rounded
//                     : style == SnackbarStyle.success
//                         ? Icons.check_circle_outline
//                         : Icons.info_outline,
//             color: style == SnackbarStyle.error
//                 ? jbSecondary
//                 : style == SnackbarStyle.alert
//                     ? Colors.amber
//                     : style == SnackbarStyle.success
//                         ? Colors.green
//                         : jbSecondary,
//             size: 26,
//           ),
//         ),
//         title: Text(subtitle.tr(),
//             style: const TextStyle(
//               fontSize: 12,
//               color: const Color(0xFFA0A0A0),
//             )),
//         trailing: InkWell(
//           onTap: () => Get.closeAllSnackbars(),
//           child: SizedBox(
//             width: 20,
//             height: 50,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SvgPicture.asset("assets/svg/cancel.svg"),
//               ],
//             ),
//           ),
//         ),
//       )));
// }
