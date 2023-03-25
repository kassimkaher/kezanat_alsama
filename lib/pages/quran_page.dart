import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/bussines_logic/quran/quran_cubit.dart';
import 'package:ramadan/model/quran_model.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:ramadan/widget/mu_text_input.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../bussines_logic/Setting/settings_cubit.dart';

class QuranPage extends HookWidget {
  const QuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isSearch = useState(false);
    final theme = Theme.of(context);
    final size = MediaQuery.of(context);
    final focusNode = FocusNode();
    final quranController = context.read<QuranCubit>();
    if (quranController.state is! QuranStateLoaded) {
      quranController.getQuran();
    }
    if (quranController.state is QuranStateLoaded) {
      quranController.getContinu();
    }
    return BlocBuilder<QuranCubit, QuranState>(builder: (context, state) {
      return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: state is QuranStateLoading
              ? const Center(child: CircularProgressIndicator())
              : state is QuranStateLoaded
                  ? Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: size.viewPadding.top,
                              left: kDefaultPadding,
                              right: kDefaultPadding,
                              bottom: kDefaultPadding),
                          decoration: BoxDecoration(
                              color: theme.cardColor,
                              border:
                                  Border(bottom: BorderSide(color: jbGary2))),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: isSearch.value
                                ? Row(
                                    children: [
                                      Expanded(
                                          child: FDTextInput(
                                        focusNode: focusNode,
                                        label: "ابحث عن سورة",
                                        onSubmit: (a) =>
                                            quranController.search(a),
                                        onType: (value) =>
                                            quranController.search(value),
                                      )),
                                      TextButton(
                                          onPressed: () {
                                            isSearch.value = false;
                                            quranController.resetQuran();
                                          },
                                          child: Text("إلغاء"))
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Text(
                                        "القرآن الكريم",
                                        style: theme.textTheme.titleLarge,
                                      ),
                                      const Spacer(),
                                      IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            isSearch.value = true;
                                            FocusScope.of(context)
                                                .requestFocus(focusNode);
                                          },
                                          icon: const Icon(
                                            LucideIcons.search,
                                            color: jbPrimaryColor,
                                          ))
                                    ],
                                  ),
                          ),
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: state.info.continuQuranModel != null
                              ? Column(
                                  children: [
                                    const SizedBox(height: kDefaultSpacing / 2),
                                    InkWell(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();

                                        Navigator.push(
                                            context,
                                            to(SuraView(
                                              data: state.info.quranModel!.data!
                                                  .surahs![state
                                                      .info
                                                      .continuQuranModel!
                                                      .suara! -
                                                  1],
                                              index: state.info
                                                  .continuQuranModel!.suara!,
                                              ayaIndex: state
                                                  .info.continuQuranModel!.aya,
                                            )));
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              QuranCircular(
                                                continuQuranModel: state
                                                    .info.continuQuranModel!,
                                              ),
                                              state.info.continuQuranModel!
                                                  .nameSura!
                                                  .toGradiant(
                                                      colors: [
                                                    theme.textTheme.titleLarge!
                                                        .color!,
                                                    theme.textTheme.bodySmall!
                                                        .color!
                                                  ],
                                                      style: theme.textTheme
                                                          .titleLarge!),
                                              const SizedBox(
                                                  height: kDefaultSpacing / 2),
                                              Text(
                                                " لقد وصلت بالقراءة للآية ${(state.info.continuQuranModel!.aya! + 1).toString()}",
                                                style: theme
                                                    .textTheme.displaySmall,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: kDefaultSpacing),
                                  ],
                                )
                              : SizedBox(),
                        ),
                        Expanded(
                          child: ListView.separated(
                              padding: const EdgeInsets.only(bottom: 100),
                              separatorBuilder: (c, i) => const Divider(
                                    indent: 60,
                                    height: 1,
                                    color: jbGary2,
                                  ),
                              itemCount:
                                  state.info.quranModel?.data?.surahs?.length ??
                                      0,
                              itemBuilder: (c, i) => InkWell(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();

                                      Navigator.push(
                                          context,
                                          to(SuraView(
                                            data: state.info.quranModel!.data!
                                                .surahs![i],
                                            index: i,
                                          )));
                                    },
                                    child: Container(
                                      color: theme.cardColor,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kDefaultPadding,
                                          vertical: 8),
                                      child: Row(
                                        children: [
                                          NumberWidget(
                                            theme: theme,
                                            number: (i + 1).toString(),
                                            size: 40,
                                          ),
                                          const SizedBox(width: 12),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.info.quranModel!.data!
                                                    .surahs![i].name!,
                                                style:
                                                    theme.textTheme.titleSmall,
                                              ),
                                              Text(
                                                "${state.info.quranModel!.data!.surahs![i].ayahs!.length} آية  ",
                                                style: theme
                                                    .textTheme.displaySmall,
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          const Icon(
                                            LucideIcons.chevronLeft,
                                            color: jbSecondary,
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                        ),
                      ],
                    )
                  : state is QuranStateFiald
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
                        ));
    });
  }
}

class QuranCircular extends StatelessWidget {
  const QuranCircular({super.key, required this.continuQuranModel});
  final ContinuQuranModel continuQuranModel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 70,
      child: Stack(
        children: [
          SizedBox(
            width: 70,
            height: 70,
          ),
          Center(
            child: Image.asset(
              "assets/images/quran.png",
              width: 60,
              height: 60,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: 70,
            height: 70,
            child: CircularProgressIndicator(
              color: jbSecondary,
              value: continuQuranModel.aya! / continuQuranModel.number!,
            ),
          )
        ],
      ),
    );
  }
}

class NumberWidget extends StatelessWidget {
  const NumberWidget(
      {super.key, required this.theme, required this.number, this.size = 40});

  final ThemeData theme;
  final String number;
  final double size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          SvgPicture.asset(
            "assets/svg/star.svg",
            height: size,
            color: jbSecondary,
          ),
          Center(
            child: Text(
              number.toString().farsiNumber,
              style: theme.textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                  fontSize: number.length > 2 ? 10 : 12),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

class SuraView extends StatelessWidget {
  const SuraView(
      {super.key, required this.data, required this.index, this.ayaIndex});
  final Surahs data;
  final int index;
  final int? ayaIndex;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final query = MediaQuery.of(context);
    final quranController = context.read<QuranCubit>();
    if (ayaIndex != null) {
      print("938748937284");
      Future.delayed(const Duration(milliseconds: 200)).then((value) =>
          Scrollable.ensureVisible(data.ayahs![ayaIndex!].key.currentContext!,
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear));
    }
    return WillPopScope(
      onWillPop: () async {
        quranController.resetScrool();
        return true;
      },
      child: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: query.viewPadding.top, bottom: 0),
                  decoration: BoxDecoration(
                      border: Border.all(color: jbGary2),
                      borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                      color: Colors.white),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(
                            data.name!,
                            style: theme.textTheme.titleLarge,
                          ),
                          subtitle: Text(
                            "   ${data.ayahs!.length} آية",
                            style: theme.textTheme.displaySmall,
                          ),
                        ),
                      ),
                      // IconButton(
                      //     onPressed: () => quranController.startReading(),
                      //     icon: const Icon(LucideIcons.speaker)),
                      IconButton(
                          onPressed: () {
                            quranController.resetQuran();
                            Navigator.pop(context);
                          },
                          icon: const Icon(LucideIcons.x))
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        const EdgeInsets.only(bottom: 30, top: kDefaultSpacing),
                    child: Column(children: [
                      index != 0
                          ? Text(
                              "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
                              style: theme.textTheme.displayLarge!
                                  .copyWith(fontWeight: FontWeight.w600),
                            )
                          : SizedBox(),
                      ...data.ayahs!
                          .asMap()
                          .map((i, aya) => MapEntry(
                                i,
                                VisibilityDetector(
                                  key: aya.key,
                                  onVisibilityChanged: (a) {},
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            kDefaultBorderRadius)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    dense: true,
                                    tileColor: aya.sajda != null
                                        ? theme.primaryColor.withOpacity(0.2)
                                        : Colors.transparent,
                                    title: aya.sajda != null
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: kDefaultPadding),
                                            child: Text(
                                              aya.sajda!.recommended == true
                                                  ? "سجدة واجبة"
                                                  : "سجدة مستحبة",
                                              style:
                                                  theme.textTheme.displaySmall,
                                            ),
                                          )
                                        : null,
                                    subtitle: InkWell(
                                      onLongPress: () =>
                                          quranController.setContinu(
                                              suraName: data.name!,
                                              suraIndex: data.number!,
                                              ayaIndex: i,
                                              number: data.ayahs!.length),
                                      child: Container(
                                          alignment: Alignment.centerRight,
                                          // margin: const EdgeInsets.symmetric(
                                          //     vertical: 12),
                                          // padding: const EdgeInsets.symmetric(
                                          //     horizontal: 12),
                                          // decoration: BoxDecoration(
                                          //     borderRadius:
                                          //         BorderRadius.circular(
                                          //             kDefaultBorderRadius),

                                          child: RichText(
                                            textAlign: TextAlign.start,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: i == 0
                                                      ? aya.text
                                                      : aya.text!.replaceFirst(
                                                          "بسم اللَّه الرحمن الرحيم",
                                                          ""),
                                                  style: theme
                                                      .textTheme.displayLarge!
                                                      .copyWith(height: 2),
                                                ),
                                                WidgetSpan(
                                                  alignment:
                                                      PlaceholderAlignment
                                                          .middle,
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5),
                                                    child: Wrap(
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .center,
                                                      children: [
                                                        NumberWidget(
                                                          theme: theme,
                                                          size: 30,
                                                          number: (i + 1)
                                                              .toString(),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                          width: 5,
                                                        ),
                                                        state.info.continuQuranModel !=
                                                                    null &&
                                                                state
                                                                        .info
                                                                        .continuQuranModel!
                                                                        .suara ==
                                                                    data
                                                                        .number &&
                                                                state
                                                                        .info
                                                                        .continuQuranModel!
                                                                        .aya ==
                                                                    i
                                                            ? const Icon(
                                                                LucideIcons
                                                                    .bookmark,
                                                                color: Colors
                                                                    .green,
                                                              )
                                                            : SizedBox(),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              ))
                          .values
                          .toList()
                    ]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
//   Widget workDay(BuildContext context, QuranModel data) {
//     return Container(
//         height: MediaQuery.of(context).size.height,
//         padding: EdgeInsets.only(top: 10),
//         width: double.infinity,
//         child: ListView(
//             children: data.suar!.map((e) {
//           return Container(

//               // height: e.id == index
//               //     ? MediaQuery.of(context).size.height * 0.4
//               //     : MediaQuery.of(context).size.height * 0.07,
//               child: e.name == index
//                   ? Transform.scale(
//                       scale: squareScaleA, child: cardAmaal(e, context))
//                   : Card(
//                       elevation: 0,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(4)),
//                       child: InkWell(
//                         onTap: () {
//                           showCupertinoModalPopup(
//                               context: context,
//                               builder: (context) =>
//                                   SafeArea(child: cardAmaal(e, context)));
//                           // setState(() {
//                           //   index = e.name;
//                           // });
//                           _animationcontroller.forward(from: 0);
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                 "سورة ${e.name}",
//                                 style: Theme.of(context).textTheme.subtitle1,
//                               ),
//                               Spacer(),
//                               Text(
//                                 "${e.ayat.length - 1} آية",
//                                 style: Theme.of(context).textTheme.bodyText1,
//                               ),
//                               Icon(
//                                 Icons.arrow_forward_ios,
//                                 size: 20,
//                                 color:
//                                     Theme.of(context).textTheme.subtitle1.color,
//                               ),
//                             ],
//                           ),
//                         ),
//                       )));
//         }).toList()));
//   }

//   Card cardAmaal(Suar data, BuildContext context) {
//     return Card(
//       elevation: 0,
//       margin: EdgeInsets.zero,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: SingleChildScrollView(
//         child: Column(children: [
//           SizedBox(
//             height: 10,
//           ),
//           Container(
//             padding: EdgeInsets.all(10),
//             child: Row(
//               children: [
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text(
//                   data.name,
//                   style: Theme.of(context).textTheme.headline2,
//                 ),
//                 Spacer(),
//                 Text(
//                   "${data.ayat.length - 1} آية",
//                   style: Theme.of(context).textTheme.bodyText1,
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 InkWell(
//                   onTap: () => Navigator.pop(context),
//                   child: Icon(
//                     Icons.close,
//                     size: 20,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//               ],
//             ),
//           ),
//           // Container(
//           //   height: 1,
//           //   color: Colors.grey,
//           //   child: Text(""),
//           //   ),
//           ListTile(
//             tileColor: Theme.of(context).scaffoldBackgroundColor,
//             title: Text(
//               "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ",
//               textAlign: TextAlign.center,
//               style: Theme.of(context)
//                   .textTheme
//                   .subtitle2
//                   .copyWith(fontWeight: FontWeight.bold),
//             ),
//           ),
//           data.ayat != null && data.ayat.length > 0
//               ? Padding(
//                   padding: const EdgeInsets.only(bottom: 0),
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: data.ayat
//                           .asMap()
//                           .map((i, e) {
//                             return MapEntry(
//                                 i,
//                                 e
//                                             .replaceAll(data.name, " ")
//                                             .replaceAll(" ", "")
//                                             .length >
//                                         0
//                                     ? ListTile(
//                                         tileColor: i % 2 == 0
//                                             ? Theme.of(context)
//                                                 .primaryColor
//                                                 .withOpacity(0.04)
//                                             : Theme.of(context)
//                                                 .scaffoldBackgroundColor,
//                                         title: RichText(
//                                           textAlign: TextAlign.start,
//                                           text: TextSpan(children: [
//                                             TextSpan(
//                                               text: e
//                                                   .replaceAll(data.name, " ")
//                                                   .replaceAll("0", ""),
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .subtitle2
//                                                   .copyWith(height: 3),
//                                             ),
//                                             WidgetSpan(
//                                                 alignment:
//                                                     PlaceholderAlignment.middle,
//                                                 child: SizedBox(
//                                                     width: 30,
//                                                     height: 30,
//                                                     child: Container(
//                                                       alignment:
//                                                           Alignment.center,
//                                                       decoration: BoxDecoration(
//                                                           image:
//                                                               DecorationImage(
//                                                         image: AssetImage(
//                                                           "images/star.png",
//                                                         ),
//                                                         colorFilter:
//                                                             new ColorFilter
//                                                                     .mode(
//                                                                 Theme.of(
//                                                                         context)
//                                                                     .accentColor,
//                                                                 BlendMode
//                                                                     .dstIn),
//                                                       )),
//                                                       child: Text(
//                                                         arN((i + 1).toString()),
//                                                         textAlign:
//                                                             TextAlign.center,
//                                                         style: TextStyle(
//                                                           fontFamily: 'Am',
//                                                           color: Colors.white,
//                                                           fontSize: 11,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                         ),
//                                                       ),
//                                                     )

//                                                     // Stack(children: [
//                                                     //   Align(
//                                                     //     alignment: Alignment.center,
//                                                     //     child: Image.asset("images/star.png",fit: BoxFit.fill,)),
//                                                     //   Align(
//                                                     //       alignment: Alignment.center,
//                                                     //     child: Text(arN((i+1).toString()),
//                                                     //   textAlign: TextAlign.center,
//                                                     //   style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold,),
//                                                     //   ),

//                                                     //   )

//                                                     // ],),
//                                                     ))
//                                           ]),
//                                         ))
//                                     : SizedBox());
//                           })
//                           .values
//                           .toList()),
//                 )
//               : SizedBox(),
//           SizedBox(
//             height: 10,
//           )
//         ]),
//       ),
//     );
//   }

//   String arN(String input) {
//     const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
//     const farsi = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

//     for (int i = 0; i < english.length; i++) {
//       input = input.replaceAll(english[i], farsi[i]);
//     }

//     return input;
//   }
// }
