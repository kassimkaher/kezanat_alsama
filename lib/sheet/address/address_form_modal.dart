// import 'package:jop_me/controller/main_controller.dart';
// import 'package:jop_me/main.dart';
// import 'package:jop_me/services/snackbar.dart';
// import 'package:jop_me/services/validation.dart';
// import 'package:jop_me/sheet/address/pin_location_modal.dart';
// import 'package:jop_me/utils/utils.dart';
// import 'package:jop_me/widgets/fd_button.dart';
// import 'package:jop_me/widgets/fd_modal.dart';
// import 'package:jop_me/widgets/fd_text_input.dart';
// import 'package:jop_me/widgets/map_widget.dart';
// import 'package:jop_me/widgets/tab_page_identifier.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:smooth_corner/smooth_corner.dart';
// import 'package:visibility_detector/visibility_detector.dart';

// class AddressFormModal extends GetView<MainController> {
//   const AddressFormModal(
//       {Key? key, this.addressModelIndex, this.sId, this.isPage = false})
//       : super(key: key);
//   final int? addressModelIndex;
//   final String? sId;
//   final bool isPage;

//   @override
//   build(BuildContext context) {
//     final theme = Theme.of(context);
//     final query = MediaQuery.of(context);
//     if (controller.mapController.mapStatus.value != MapStatus.done &&
//         controller.mapController.mapStatus.value != MapStatus.loading) {
//       controller.mapController.iniMap((status) {
//         if (status == MapStatus.done) {
//           controller.mapController.changeTrack(
//             controller: controller.mapController.mapControllerDisplay.value!,
//             latLng: LatLng(
//                 controller.mapController.currentAddress.value.latitude,
//                 controller.mapController.currentAddress.value.longitude),
//           );
//         }
//       }, context);
//     }
//     return isPage
//         ? Scaffold(
//             appBar: true
//                 ? PreferredSize(
//                     preferredSize:
//                         Size.fromHeight(AppBar().preferredSize.height + 5 + 10),
//                     child: SmoothContainer(
//                       height: double.infinity,
//                       alignment: Alignment.bottomCenter,
//                       smoothness: 1,
//                       color: theme.appBarTheme.backgroundColor,
//                       borderRadius: const BorderRadius.only(
//                         bottomLeft: Radius.circular(16),
//                         bottomRight: Radius.circular(16),
//                       ),
//                       padding: EdgeInsets.only(
//                           top: query.padding.top,
//                           left: kDefaultPadding,
//                           right: kDefaultPadding,
//                           bottom: kDefaultPadding),
//                       child: Obx(
//                         () => Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             const SizedBox(width: 10),
//                             Expanded(
//                               child: Text(
//                                 "add_address".tr,
//                                 style: theme.appBarTheme.titleTextStyle,
//                                 textAlign: TextAlign.start,
//                               ),
//                             ),
//                             controller.auth.requestState.value ==
//                                     RequestState.loading
//                                 ? Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: const [
//                                       SizedBox(
//                                           width: 20,
//                                           height: 20,
//                                           child: CircularProgressIndicator()),
//                                     ],
//                                   )
//                                 : InkWell(
//                                     onTap: () async {
//                                       await controller.logOut1(context);

//                                       Navigator.pushReplacement(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (c) => const LoginPage(),
//                                         ),
//                                       );
//                                     },
//                                     child: SvgPicture.asset(
//                                       "assets/svg/logout.svg",
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                             const SizedBox(
//                               width: kDefaultSpacing,
//                             )
//                           ],
//                         ),
//                       ),
//                     ))
//                 : AppBar(
//                     title: Text(
//                       "add_address".tr,
//                     ),
//                     actions: [
//                       controller.auth.requestState.value == RequestState.loading
//                           ? Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: const [
//                                 SizedBox(
//                                     width: 20,
//                                     height: 20,
//                                     child: CircularProgressIndicator()),
//                               ],
//                             )
//                           : InkWell(
//                               onTap: () async {
//                                 await controller.logOut1(context);

//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (c) => const LoginPage(),
//                                   ),
//                                 );
//                               },
//                               child: SvgPicture.asset(
//                                 "assets/svg/logout.svg",
//                                 color: Colors.black,
//                               ),
//                             ),
//                       const SizedBox(
//                         width: kDefaultSpacing,
//                       )
//                     ],
//                     centerTitle: false,
//                   ),
//             body: BodyContent(
//               controller: controller,
//               isPage: isPage,
//               addressModelIndex: addressModelIndex,
//               sId: sId,
//             ),
//           )
//         : FDModal(
//             title: "delivery_address".tr,
//             body: BodyContent(
//               controller: controller,
//               isPage: isPage,
//               addressModelIndex: addressModelIndex,
//               sId: sId,
//             ),
//           );
//   }
// }

// class BodyContent extends StatelessWidget {
//   const BodyContent({
//     Key? key,
//     required this.controller,
//     required this.isPage,
//     required this.addressModelIndex,
//     required this.sId,
//   }) : super(key: key);

//   final MainController controller;

//   final bool isPage;

//   final int? addressModelIndex;

//   final String? sId;

//   @override
//   Widget build(BuildContext context) {
//     final query = MediaQuery.of(context);
//     final theme = Theme.of(context);
//     return Obx(
//       () => Scaffold(
//         body: Form(
//           key: controller.addressC.addressForm.value,
//           child: ListView(
//             physics: const ClampingScrollPhysics(),
//             padding: query.viewInsets.bottom > 0
//                 ? const EdgeInsets.all(kDefaultPadding)
//                     .copyWith(bottom: query.viewInsets.bottom + kDefaultPadding)
//                 : const EdgeInsets.all(kDefaultPadding)
//                     .copyWith(bottom: kDefaultPadding * 6),
//             children: [
//               VisibilityDetector(
//                 key: GlobalKey(),
//                 onVisibilityChanged: (info) {
//                   if (info.visibleFraction == 1) {
//                     //  kdp(name: "ini mappppp", msg: "back pin", c: "r");
//                     // controller.mapController.mapFunctionality.value =
//                     //     MapFunctionality.display;
//                     controller.mapController.changeTrack(
//                       controller:
//                           controller.mapController.mapControllerDisplay.value!,
//                       latLng: LatLng(
//                           controller
//                               .mapController.currentAddress.value.latitude,
//                           controller
//                               .mapController.currentAddress.value.longitude),
//                     );
//                   }
//                 },
//                 child: AspectRatio(
//                   aspectRatio: 1.6 / 1,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(kDefaultBorderRadius),
//                     child: KDMapComponent(
//                       functionality: MapFunctionality.display,
//                       onTap: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (c) => const PinLocationModal(
//                               functionality: MapFunctionality.chooser,
//                               type: MapChooserType.sheet),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: kDefaultSpacing),
//               FDTextInput(
//                 isRequired: Validator.required,
//                 topPadding: kDefaultPadding,
//                 bottomPadding: kDefaultPadding,
//                 label: "address_title".tr,
//                 controller: controller.addressC.addressController,
//               ),
//               const SizedBox(height: kDefaultSpacing),
//               FDTextInput(
//                 topPadding: kDefaultPadding,
//                 bottomPadding: kDefaultPadding,
//                 label: "street".tr,
//                 controller: controller.addressC.streetController,
//               ),
//               const SizedBox(height: kDefaultSpacing),
//               FDTextInput(
//                 topPadding: kDefaultPadding,
//                 bottomPadding: kDefaultPadding,
//                 label: "building".tr,
//                 controller: controller.addressC.buildingController,
//               ),
//               const SizedBox(height: kDefaultSpacing),
//               // FDTextInput(
//               //   topPadding: kDefaultPadding,
//               //   bottomPadding: kDefaultPadding,
//               //   label: "apartment".tr,
//               //   controller: controller.addressC.apartmentController,
//               // ),
//               // const SizedBox(height: kDefaultSpacing),
//               Container(
//                 margin: const EdgeInsets.only(top: 0),
//                 width: double.infinity,
//                 child: FDTextInput(
//                   controller: controller.addressC.phoneController,
//                   isRequired: Validator.required,
//                   validator: Validator.phone,
//                   topPadding: kDefaultPadding,
//                   bottomPadding: kDefaultPadding,
//                   textInputType: TextInputType.phone,
//                   leftPadding: controller.currentLang.value == Lang.arbic
//                       ? 0
//                       : kDefaultPadding,
//                   rightPadding: controller.currentLang.value == Lang.arbic
//                       ? kDefaultPadding
//                       : 0,
//                   icon: SizedBox(
//                     width: 75,
//                     child: IntrinsicHeight(
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Image.asset(
//                             "assets/images/iraq.png",
//                             fit: BoxFit.fill,
//                             height: 16,
//                             width: 16,
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             "+964",
//                             style: theme.textTheme.bodyMedium,
//                           ),
//                           const VerticalDivider(
//                             width: 10,
//                             thickness: 1,
//                             color: kBorderColor,
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   label: "phone_hint".tr,
//                 ),
//               ),
//               const SizedBox(height: kDefaultSpacing),
//               FDTextInput(
//                 topPadding: kDefaultPadding,
//                 bottomPadding: kDefaultPadding,
//                 controller: controller.addressC.notesController,
//                 label: "notes".tr,
//                 textInputType: TextInputType.multiline,
//                 isMultiline: true,
//               ),
//               const SizedBox(height: kDefaultSpacing),
//             ],
//           ),
//         ),
//         bottomNavigationBar: Container(
//           padding: const EdgeInsets.only(
//               left: kDefaultPadding,
//               right: kDefaultPadding,
//               bottom: kDefaultPadding),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 theme.scaffoldBackgroundColor.withOpacity(0),
//                 theme.scaffoldBackgroundColor,
//                 theme.scaffoldBackgroundColor
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               stops: const [0, 0.4, 1],
//             ),
//           ),
//           child: SafeArea(
//             child: Obx(
//               () => AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 400),
//                 child: controller.mapController.mapStatus.value !=
//                         MapStatus.done
//                     ? FDButton(
//                         isLoading: controller.mapController.mapStatus.value ==
//                             MapStatus.loading,
//                         title: "gps_permition".tr,
//                         onPressed: () {
//                           controller.mapController.iniMap((status) {}, context);
//                         },
//                       )
//                     : controller.addressC.editMode.value
//                         ? BTUpdateAddress(
//                             controller: controller,
//                             addressModelIndex: addressModelIndex,
//                             theme: theme,
//                             sId: sId)
//                         : BtAddAdress(controller: controller, isPage: isPage),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class BTUpdateAddress extends StatelessWidget {
//   const BTUpdateAddress({
//     Key? key,
//     required this.controller,
//     required this.addressModelIndex,
//     required this.theme,
//     required this.sId,
//   }) : super(key: key);

//   final MainController controller;
//   final int? addressModelIndex;
//   final ThemeData theme;
//   final String? sId;

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Row(
//         children: [
//           InkWell(
//             onTap: controller.addressC.loadingDeleteAddAdress.value ==
//                         RequestState.loading ||
//                     controller.addressC.addressModel.value.data!.length < 2
//                 ? () {}
//                 : () => controller.addressC
//                         .deleteAddressApi(
//                             controller.auth.token.value,
//                             controller.addressC.addressModel.value
//                                 .data![addressModelIndex!],
//                             context)
//                         .then(
//                       (value) {
//                         if (value) {
//                           controller
//                                   .addressC.addressModel.value.data!.isNotEmpty
//                               ? controller.addressC.selectAddressApi(context, 0)
//                               : null;
//                           Navigator.pop(context);
//                         }
//                       },
//                     ),
//             child: Container(
//               width: 55,
//               height: 55,
//               padding: const EdgeInsets.all(kDefaultPadding),
//               decoration: BoxDecoration(
//                 color: controller.addressC.addressModel.value.data!.length < 2
//                     ? theme.cardColor
//                     : const Color(0xFFFDEBF3),
//                 borderRadius: BorderRadius.circular(kDefaultBorderRadius * 2),
//               ),
//               child: controller.addressC.loadingDeleteAddAdress.value ==
//                       RequestState.loading
//                   ? CircularProgressIndicator(
//                       color: theme.primaryColor,
//                     )
//                   : SvgPicture.asset(
//                       "assets/svg/trash.svg",
//                       color:
//                           controller.addressC.addressModel.value.data!.length <
//                                   2
//                               ? theme.disabledColor
//                               : theme.primaryColor,
//                     ),
//             ),
//           ),
//           const SizedBox(width: 8),
//           Obx(
//             () => Expanded(
//               child: FDButton(
//                 isLoading: controller.addressC.loadingUpdateAddAdress.value ==
//                     RequestState.loading,
//                 title: "update".tr,
//                 onPressed: () async {
//                   if (controller.addressC.addressForm.value.currentState!
//                       .validate()) {
//                     //controller.login();
//                     await controller.addressC.updateAddressApi(
//                         controller.auth.token.value,
//                         AddressData(
//                             sId: sId,
//                             name: controller.addressC.addressController.text,
//                             addLine1: controller
//                                     .addressC.streetController.text.isNotEmpty
//                                 ? controller.addressC.streetController.text
//                                 : "  ",
//                             addLine2:
//                                 controller.addressC.buildingController.text
//                                         .isNotEmpty
//                                     ? controller
//                                         .addressC.buildingController.text
//                                     : "  ",
//                             landmark: controller
//                                     .addressC.notesController.text.isNotEmpty
//                                 ? controller.addressC.notesController.text
//                                 : "  ",
//                             mobileNumber:
//                                 controller.addressC.phoneController.text,
//                             mobileNumberCode: "+964",
//                             latitude: controller
//                                 .mapController.currentAddress.value.latitude,
//                             longitude: controller
//                                 .mapController.currentAddress.value.longitude,
//                             deliveryAddressNote: ""),
//                         context);
//                     Get.back();
//                     showSnackbar(
//                         subtitle: "address_edit_sucess",
//                         style: SnackbarStyle.success);

//                     // Navigator.pop(context);
//                   }
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class BtAddAdress extends StatelessWidget {
//   const BtAddAdress({
//     Key? key,
//     required this.controller,
//     required this.isPage,
//   }) : super(key: key);

//   final MainController controller;
//   final bool isPage;

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => FDButton(
//         isLoading:
//             controller.addressC.loadingAddAdress.value == RequestState.loading,
//         title: "add_address".tr,
//         onPressed: () {
//           // controller.mapController.changeTrack(
//           //   latLng: LatLng(
//           //       controller.mapController.currentAddress.value.latitude,
//           //       controller.mapController.currentAddress.value.longitude),
//           // );
//           // return;
//           if (controller.addressC.addressForm.value.currentState!.validate()) {
//             if (controller.mapController.currentAddress.value.latitude == 0) {
//               showSnackbar(
//                   subtitle: "map_permition_error", style: SnackbarStyle.alert);
//               return;
//             }
//             FocusScope.of(context).unfocus();
//             controller.addressC
//                 .addAddressApi(
//                     controller.auth.token.value,
//                     AddressData(
//                       name: controller.addressC.addressController.text,
//                       addLine1:
//                           controller.addressC.streetController.text.isNotEmpty
//                               ? controller.addressC.streetController.text
//                               : "  ",
//                       addLine2:
//                           controller.addressC.buildingController.text.isNotEmpty
//                               ? controller.addressC.buildingController.text
//                               : "  ",
//                       landmark:
//                           controller.addressC.notesController.text.isNotEmpty
//                               ? controller.addressC.notesController.text
//                               : "  ",
//                       mobileNumber: controller.addressC.phoneController.text,
//                       mobileNumberCode: "+964",
//                       latitude: controller
//                           .mapController.currentAddress.value.latitude,
//                       longitude: controller
//                           .mapController.currentAddress.value.longitude,
//                       deliveryAddressNote: "--",
//                     ),
//                     context)
//                 .then((value) {
//               if (value) {
//                 if (isPage) {
//                   controller.addressC
//                       .selectAddressApi(
//                           context,
//                           controller.addressC.addressModel.value.data!.length -
//                               1)
//                       .then((value) {
//                     controller.homeController.token.value =
//                         controller.auth.token.value;
//                     controller.notificationController.setupInteractedMessage(
//                         controller.auth.userModel.value!.data!.fcmTopic ??
//                             "kwd",
//                         controller.auth.token.value);
//                     controller.homeController.token.value =
//                         controller.auth.token.value;
//                     controller.currentPage.value = NavPages.home;
//                     Get.offAll(RootPage());
//                   });
//                   return;
//                 }
//                 Get.back();
//                 if (value) {}
//               }
//             });
//           }
//         },
//       ),
//     );
//   }
// }
