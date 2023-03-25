// import 'package:feed_app/controller/map_contoller.dart';
// import 'package:feed_app/utils/utils.dart';
// import 'package:feed_app/widgets/fd_button.dart';
// import 'package:feed_app/widgets/fd_modal.dart';
// import 'package:feed_app/widgets/map_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:get/get_utils/get_utils.dart';

// class PinLocationModal extends GetView<MapGetController> {
//   const PinLocationModal(
//       {Key? key, required this.functionality, required this.type})
//       : super(key: key);
//   final MapFunctionality functionality;
//   final MapChooserType type;
//   @override
//   build(BuildContext context) {
//     final theme = Theme.of(context);

//     return type == MapChooserType.sheet
//         ? SafeArea(
//             bottom: false,
//             child: FDModal(
//               title: "pin_location".tr,
//               body: BodyPinLocation(
//                 controller: controller,
//                 functionality: functionality,
//               ),
//             ),
//           )
//         : SafeArea(
//             child: FDModal(
//               title: "pin_location".tr,
//               topPadding: 0,
//               body: BodyPinLocation(
//                 controller: controller,
//                 functionality: functionality,
//               ),
//             ),
//           );
//   }
// }

// class BodyPinLocation extends StatelessWidget {
//   const BodyPinLocation(
//       {Key? key, required this.controller, required this.functionality})
//       : super(key: key);

//   final MapGetController controller;
//   final MapFunctionality functionality;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(kDefaultPadding).copyWith(top: 0),
//       child: Column(
//         children: [
//           const SizedBox(
//             height: kDefaultSpacing,
//           ),
//           Expanded(
//             child: ClipRRect(
//                 borderRadius: BorderRadius.circular(kDefaultBorderRadius),
//                 child: KDMapComponent(
//                   functionality: functionality,
//                   onTap: () {},
//                 )),
//           ),
//           const SizedBox(height: kDefaultPadding),
//           SafeArea(
//             child: FDButton(
//               title: "use_location".tr,
//               onPressed: () {
//                 controller.currentAddress.value =
//                     controller.chooserPostion.value;
//                 Navigator.pop(context);
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class TrackMapView extends GetView<MapGetController> {
//   const TrackMapView({
//     Key? key,
//   }) : super(key: key);

//   @override
//   build(BuildContext context) {
//     final theme = Theme.of(context);

//     return FDModal(
//       title: "pin_location".tr,
//       topPadding: 0,
//       body: Padding(
//         padding: const EdgeInsets.all(kDefaultPadding).copyWith(top: 0),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: kDefaultSpacing,
//             ),
//             Expanded(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(kDefaultBorderRadius),
//                 child: KDMapComponent(
//                   functionality: MapFunctionality.track,
//                   onTap: () {},
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
