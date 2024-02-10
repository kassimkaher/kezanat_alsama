import 'package:ramadan/src/core/enum/work_type.dart';
import 'package:ramadan/src/main_app/dua/work_display_view.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/daily_work_model.dart';
import 'package:ramadan/src/main_app/widgets/work_card.dart';
import 'package:ramadan/utils/utils.dart';

class ZyaratPage extends StatelessWidget {
  const ZyaratPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final duaController = context.read<DuaCubit>();
    if (duaController.state.info.zyaratData == null) {
      duaController.getZyaratMunajat();
    }
    return BlocBuilder<DuaCubit, DuaState>(builder: (context, state) {
      return Container(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: "الزيارات".toGradiant(
                colors: [
                  theme.textTheme.titleLarge!.color!,
                  theme.textTheme.bodySmall!.color!
                ],
                style: theme.textTheme.titleLarge!,
              ),
            ),
            body: state is DuaStateLoading
                ? const Center(child: CircularProgressIndicator())
                : state is DuaStateLoaded && state.info.zyaratData != null
                    ? Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              itemCount:
                                  state.info.zyaratData?.zyaratList?.length ??
                                      0,
                              itemBuilder: (c, i) => WorkCard(
                                dailyWorkData: DailyWorkData(
                                    type: WorkType.zyara,
                                    title: state.info.zyaratData?.zyaratList?[i]
                                            .title ??
                                        "",
                                    description: ""),
                                onTap: () => Navigator.push(
                                  context,
                                  to(
                                    WorkDisplayText(
                                      data:
                                          state.info.zyaratData!.zyaratList![i],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : state is DuaStateFiald
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "حدث خطأ",
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                " dataProv.trans.error_ser_title",
                                style: Theme.of(context).textTheme.titleLarge,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                " dataProv.trans.error_ser_subtitle",
                                style: Theme.of(context).textTheme.titleLarge,
                                textAlign: TextAlign.center,
                              )
                            ],
                          )),
      );
    });
  }
}

// class ZyaraDisplay extends StatelessWidget {
//   const ZyaraDisplay({super.key, required this.data, required this.index});
//   final DuaEntity data;
//   final int index;
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final query = MediaQuery.of(context);
//     final duaController = context.read<DuaCubit>();
//     if (data.text == null) {
//       duaController.loadContent(data.path!, (value) {
//         if (value != null) {
//           duaController.state.info.zyaratData!.zyaratList![index].text = value;
//           data.text = value;
//           duaController.refresh();
//         }
//       });
//     }

//     return Scaffold(
//       backgroundColor: theme.cardColor,
//       body: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.only(top: query.viewPadding.top, bottom: 0),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(kDefaultBorderRadius),
//                 color: theme.cardColor),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: ListTile(
//                     title: Text(
//                       data.title!,
//                       style: theme.textTheme.titleLarge,
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: const Icon(LucideIcons.x))
//               ],
//             ),
//           ),
//           const SizedBox(height: kDefaultSpacing),
//           Expanded(
//             child: Container(
//               width: double.infinity,
//               margin: const EdgeInsets.symmetric(horizontal: 10),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(kDefaultBorderRadius),
//                   color: theme.scaffoldBackgroundColor),
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding)
//                     .copyWith(bottom: 30, top: kDefaultSpacing),
//                 child: Column(
//                   children: [
//                     data.desc != null
//                         ? Column(
//                             children: [
//                               Text(
//                                 data.desc ?? "",
//                                 style: theme.textTheme.displayLarge!.copyWith(
//                                     fontSize: 16, color: jbUnselectColor),
//                               ),
//                               const SizedBox(
//                                 height: kDefaultSpacing,
//                               ),
//                             ],
//                           )
//                         : const SizedBox(),
//                     BlocBuilder<PrayerCubit, PrayerState>(
//                       builder: (context, state) {
//                         return Text(
//                           data.text ?? "",
//                           style: theme.textTheme.displayLarge!
//                               .copyWith(fontWeight: FontWeight.w400, height: 2),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
