// import 'package:ramadan/src/core/enum/work_type.dart';
// import 'package:ramadan/src/core/resources/validation.dart';
// import 'package:ramadan/src/main_app/widgets/custom_drop_down_input.dart';
// import 'package:ramadan/src/main_app/widgets/custom_drop_down_menu_string.dart';
// import 'package:ramadan/src/main_app/widgets/custom_text_input.dart';
// import 'package:ramadan/utils/utils.dart';

// class WorkDetailsFormsView extends StatelessWidget {
//   const WorkDetailsFormsView({super.key,required this.titleController});

//   final TextEditingController titleController;
//    final TextEditingController descriptionController;
//     final   WorkType? titleController;
//      final TextEditingController titleController;
//   @override
//   Widget build(BuildContext context) {
//     final document = context.read<DuaCubit>().state.info;
//     return Column(
//       children: [
//         CustomTextInput(
//           isRequired: ValidatorEnum.required,
//           validator: ValidatorEnum.textOnly,
//           controller: titleController,
//           label: "العنوان",
//           rightPadding: 16,
//           leftPadding: 16,
//         ),
//         const SizedBox(height: 12),
//         CustomTextInput(
//           validator: ValidatorEnum.textOnly,
//           controller: descriptionController,
//           label: "شرح العمل",
//           rightPadding: 16,
//           leftPadding: 16,
//         ),
//         const SizedBox(height: 12),
//         CustomDropDownInput(
//           array: WorkType.values,
//           selectValue: typeController,
//           hint: "نوع العمل",
//           onSelect: (s) {
//             typeController = s as WorkType;
//             setState(() {});
//           },
//         ),
//         const SizedBox(height: 12),
//         CustomTextInput(
//           controller: textController,
//           label: "نص العمل",
//           rightPadding: 16,
//           leftPadding: 16,
//           maxLine: 3,
//         ),
//         const SizedBox(height: 12),
//         CustomDropDownMenuString(
//           array: typeController == WorkType.dua
//               ? document.documentEntity!.dua!.map((e) => e.title!).toList()
//               : typeController == WorkType.zyara
//                   ? document.zyaratData!.zyaratList!
//                       .map((e) => e.title!)
//                       .toList()
//                   : typeController == WorkType.munajat
//                       ? document.zyaratData!.munajatList!
//                           .map((e) => e.title!)
//                           .toList()
//                       : [],
//           selectValue: pathController,
//           isNullable: textController.text.isNotEmpty ||
//               typeController == WorkType.quran,
//           hint: " مسار",
//           onSelect: (s) {
//             pathController = s;
//             setState(() {});
//           },
//         ),
//         const SizedBox(height: 12),
//         CustomDropDownMenuString(
//           isNullable: true,
//           array: allSura.map((e) => e.name!).toList(),
//           selectValue: quransuraController,
//           hint: " القرآن",
//           onSelect: (s) {
//             quransuraController =
//                 allSura.where((element) => element.name == s).first.name;
//           },
//         ),
//       ],
//     );
//   }
// }
