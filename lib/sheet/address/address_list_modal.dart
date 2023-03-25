
// import 'package:jop_me/controller/map_contoller.dart';
// import 'package:jop_me/sheet/address/address_form_modal.dart';
// import 'package:jop_me/sheet/address/pin_location_modal.dart';
// import 'package:jop_me/utils/utils.dart';
// import 'package:jop_me/widgets/address_item.dart';
// import 'package:jop_me/widgets/fd_button.dart';
// import 'package:jop_me/widgets/fd_modal.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:get/get.dart';

// class AddressListModal extends StatelessWidget {
//   const AddressListModal({Key? key, this.scrollController, this.type})
//       : super(key: key);
//   final ScrollController? scrollController;
//   final int? type;
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final userConroller = Get.find<LoginController>();
//     final controller = Get.find<AddressController>();
//     final mapController = Get.put(MapGetController());
//     if (controller.begin.value &&
//         controller.loadingGetAddress.value != RequestState.success) {
//       controller.begin.value = false;
//       controller.getAddressList(userConroller.userModel.value!.token!);
//     }
//     return Obx(
//       () => FDModal(
//         title: "delivery_address".tr,
//         body: AnimatedSwitcher(
//           duration: const Duration(milliseconds: 300),
//           child: controller.loadingGetAddress.value == RequestState.loading
//               ? Stack(
//                   children: [
//                     ListView.separated(
//                       physics: const ClampingScrollPhysics(parent: null),
//                       padding: const EdgeInsets.all(kDefaultPadding).copyWith(
//                         bottom: 150,
//                       ),
//                       itemCount: 10,
//                       separatorBuilder: (context, idx) =>
//                           const SizedBox(height: kDefaultSpacing),
//                       itemBuilder: (context, idx) =>
//                           const AddressItemSkeleton(),
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       left: 0,
//                       right: 0,
//                       child: Container(
//                         padding: const EdgeInsets.all(kDefaultPadding)
//                             .copyWith(top: 120),
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               theme.scaffoldBackgroundColor.withOpacity(0),
//                               theme.scaffoldBackgroundColor,
//                             ],
//                             stops: const [0, .6],
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                           ),
//                         ),
//                         child: Column(
//                           children: [
//                             FDButton(
//                               color: theme.textTheme.displaySmall?.color,
//                               backgroundColor: theme.colorScheme.outline,
//                               icon: Icons.add,
//                               title: "add_new_address".tr,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               : Stack(
//                   children: [
//                     ListView.separated(
//                       reverse: false,
//                       physics: const BouncingScrollPhysics(),
//                       padding: const EdgeInsets.all(kDefaultPadding).copyWith(
//                         bottom: 150,
//                       ),
//                       itemCount: controller.loadingGetAddress.value ==
//                                   RequestState.success &&
//                               controller.addressModel.value != null
//                           ? controller.addressModel.value.data!.length
//                           : 0,
//                       separatorBuilder: (context, idx) =>
//                           const SizedBox(height: kDefaultSpacing),
//                       itemBuilder: (context, idx) => AddressItem(
//                         index: idx,
//                         onSelected: (idx) {
//                           if (type != null && type == 1) {
//                             Navigator.pop(context);
//                           }
//                         },
//                       ),
//                     ),
//                     Visibility(
//                       visible: controller.loadingGetAddress.value !=
//                           RequestState.success,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Icon(FeatherIcons.info),
//                           Text(
//                             controller.loadingGetAddress.value ==
//                                     RequestState.nullData
//                                 ? "address_null".tr
//                                 : "error".tr,
//                             textAlign: TextAlign.center,
//                           )
//                         ],
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 20,
//                       left: 0,
//                       right: 0,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: kDefaultPadding),
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               theme.scaffoldBackgroundColor.withOpacity(0),
//                               theme.scaffoldBackgroundColor,
//                             ],
//                             stops: const [0, .6],
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                           ),
//                         ),
//                         child: AnimatedSwitcher(
//                           duration: const Duration(milliseconds: 300),
//                           child: FDButton(
//                             onPressed: () async {
//                               controller.addressController.clear();
//                               controller.notesController.clear();

//                               controller.streetController.clear();
//                               controller.buildingController.clear();

//                               controller.phoneController.clear();
//                               mapController.iniMap((a) {}, context);

//                               mapController.mapMarker.value = [];
//                               mapController.onComplete.value = () {};
//                               // mapController.mapFunctionality.value =
//                               //     MapFunctionality.display;

//                               // mapController.onTap.value = () {
//                               //   mapController.mapFunctionality.value =
//                               //       MapFunctionality.chooser;
//                               //   Navigator.push(
//                               //     context,
//                               //     MaterialPageRoute(
//                               //       builder: (c) =>
//                               //           const PinLocationModal(),
//                               //     ),
//                               //   ).then((value) {
//                               //     mapController.mapFunctionality.value =
//                               //         MapFunctionality.display;
//                               //   });
//                               // };
//                               controller.editMode.value = false;
//                               await showModal(
//                                 context: context,
//                                 builder: (c, s) => const AddressFormModal(),
//                               );
//                             },
//                             icon: Icons.add,
//                             title: "add_new_address".tr,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }
// }
