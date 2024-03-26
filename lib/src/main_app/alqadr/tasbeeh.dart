// import 'dart:developer';

// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lottie/lottie.dart';
// import 'package:lucide_icons/lucide_icons.dart';
// import 'package:ramadan/model/alqadr_model.dart';
// import 'package:ramadan/src/alqadr/cubit/alqadr_cubit.dart';
// import 'package:ramadan/utils/utils.dart';
// import 'package:ramadan/src/core/widget/jb_button.dart';

// // class TasbeehPage extends StatelessWidget {
// //   const TasbeehPage({super.key, required this.data});

// //   final DataList data;
// //   @override
// //   Widget build(BuildContext context) {
// //     final theme = Theme.of(context);
// //     final query = MediaQuery.of(context);
// //     final alqadrCubit = context.read<AlqadrCubit>();

// //     return Scaffold(
// //       body: BlocBuilder<AlqadrCubit, AlqadrState>(
// //         builder: (context, state) {
// //           if (state.alqadrInfo.currentTasbeeh == null ||
// //               state.alqadrInfo.currentTasbeeh!.all == 0 ||
// //               state.alqadrInfo.currentTasbeeh!.all != data.index) {
// //             alqadrCubit.increesTasbeeh(data.index!, 0);
// //           }
// //           return Stack(
// //             children: [
// //               Container(
// //                 height: query.size.height,
// //                 width: query.size.width,
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(kDefaultBorderRadius),
// //                   gradient: const LinearGradient(
// //                       colors: [alqadrAccesntColor, alqadrColor],
// //                       stops: [0, 0.8],
// //                       begin: Alignment.topRight,
// //                       end: Alignment.bottomLeft),
// //                 ),
// //                 child: LottieBuilder.asset("assets/lottie/back.json"),
// //               ),
// //               Align(
// //                 alignment: Alignment.topCenter,
// //                 child: Column(
// //                   children: [
// //                     SizedBox(
// //                       height: query.viewPadding.top,
// //                     ),
// //                     Row(
// //                       children: [
// //                         const Spacer(),
// //                         IconButton(
// //                             onPressed: () {
// //                               Navigator.pop(context);
// //                               alqadrCubit.increesTasbeeh(0, 0);
// //                             },
// //                             icon: Icon(
// //                               LucideIcons.x,
// //                               color: theme.cardColor,
// //                             ))
// //                       ],
// //                     ),
// //                     Text(
// //                       data.title ?? "",
// //                       style: theme.textTheme.titleLarge!
// //                           .copyWith(color: theme.cardColor),
// //                     ),
// //                     Padding(
// //                       padding: const EdgeInsets.symmetric(
// //                           horizontal: kDefaultPadding),
// //                       child: Text(
// //                         data.smallText ?? "",
// //                         style: theme.textTheme.titleSmall!.copyWith(
// //                             color: theme.cardColor,
// //                             fontWeight: FontWeight.w100),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: query.size.height,
// //                 width: query.size.width,
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     const Spacer(),
// //                     const SizedBox(height: kDefaultPadding * 4),
// //                     // InkWell(
// //                     //   onTap: () {
// //                     //     AudioPlayer().play(AssetSource('sound/tick.MP3'));
// //                     //     alqadrCubit.increesTasbeeh(
// //                     //         data.index ?? 0,
// //                     //         (state.alqadrInfo.currentTasbeeh?.current ?? 0) +
// //                     //             1);
// //                     //   },
// //                     //   child: CircularWidget(
// //                     //     theme: theme,
// //                     //     value: (state.alqadrInfo.currentTasbeeh?.current ?? 0) /
// //                     //         (data.index ?? 0),
// //                     //     size: 270,
// //                     //     number: state.alqadrInfo.currentTasbeeh?.current ?? 0,
// //                     //   ),
// //                     // ),
// //                     const SizedBox(height: kDefaultPadding * 2),
// //                     SizedBox(
// //                       width: double.infinity,
// //                       child: Text(
// //                         data.title ?? "",
// //                         style: theme.textTheme.titleSmall!
// //                             .copyWith(color: Colors.white70),
// //                         textAlign: TextAlign.center,
// //                       ),
// //                     ),
// //                     const Spacer(),
// //                     Container(
// //                       height: 48,
// //                       padding: const EdgeInsets.symmetric(
// //                           horizontal: kDefaultPadding),
// //                       child: JBButton(
// //                         title: "اعادة العداد",
// //                         onPressed: () => alqadrCubit.resetTasbeeh(),
// //                         backgroundColor: theme.primaryColor,

// //                         /// color: theme.textTheme.titleLarge!.color!,
// //                       ),
// //                     ),
// //                     const SizedBox(height: kDefaultPadding * 2),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// // class CircularWidget extends StatelessWidget {
// //   const CircularWidget({
// //     super.key,
// //     required this.theme,
// //     required this.size,
// //     required this.value,
// //     required this.number,
// //   });

// //   final ThemeData theme;

// //   final double value;
// //   final double size;
// //   final int number;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: Container(
// //         height: size,
// //         width: size,
// //         alignment: Alignment.center,
// //         child: Stack(
// //           children: [
// //             Align(
// //               alignment: Alignment.center,
// //               child: Container(
// //                 height: size - 10,
// //                 width: size - 10,
// //                 padding: const EdgeInsets.all(20),
// //                 decoration: BoxDecoration(
// //                   color: theme.cardColor,
// //                   borderRadius: BorderRadius.circular(180),
// //                   boxShadow: [
// //                     BoxShadow(
// //                         offset: const Offset(0, 4),
// //                         color: theme.primaryColor == jbPrimaryColor
// //                             ? theme.colorScheme.outline
// //                             : Colors.black.withOpacity(0.2),
// //                         spreadRadius: 0,
// //                         blurRadius: 4),
// //                   ],
// //                 ),
// //                 child: Container(
// //                   alignment: Alignment.center,
// //                   padding: const EdgeInsets.all(8.0),
// //                   child: number.toString().arabicNumber.toGradiant(
// //                       style: theme.textTheme.displayMedium!
// //                           .copyWith(fontSize: 100),
// //                       colors: [
// //                         theme.primaryColor,
// //                         theme.colorScheme.onPrimary
// //                       ]),
// //                 ),
// //               ),
// //             ),
// //             Align(
// //               alignment: Alignment.center,
// //               child: SizedBox(
// //                 height: size,
// //                 width: size,
// //                 child: CircularProgressIndicator(
// //                   strokeWidth: 6,
// //                   value: value,
// //                 ),
// //               ),
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// class TasbeehPage extends StatefulWidget {
//   const TasbeehPage({super.key, required this.data});

//   final DataList data;
//   @override
//   _TasbeehPageState createState() => _TasbeehPageState();
// }

// class _TasbeehPageState extends State<TasbeehPage> {
//   int _count = 0;
//   late PageController _pageController;
//   late ScrollController scontroller;
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(viewportFraction: 0.1, initialPage: 0);
//     scontroller = ScrollController();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   void _incrementCount(int index) {
//     HapticFeedback.selectionClick();

//     AudioPlayer().play(AssetSource('sound/bead.wav'));

//     setState(() {
//       _count = index;
//     });

//     if ((scontroller.position.pixels + 100) >=
//         scontroller.position.maxScrollExtent) {
//       return;
//     }

//     // scontroller.jumpTo((33 * index * 2).toDouble());
//     // _pageController.animateToPage(
//     //   index,
//     //   duration: const Duration(milliseconds: 200),
//     //   curve: Curves.ease,
//     // );
//   }

//   void _resetCount() {
//     setState(() {
//       _count = 0;
//     });
//     _pageController.animateToPage(
//       0,
//       duration: Duration(milliseconds: 500),
//       curve: Curves.ease,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final query = MediaQuery.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: ListTile(
//           contentPadding: EdgeInsets.zero,
//           horizontalTitleGap: 0,
//           leading: IconButton(
//             icon: const Icon(LucideIcons.x),
//             onPressed: () => navigatorKey.currentState!.pop(),
//           ),
//           title: Text('تسبيح الزهراء عليها السلام'),
//           subtitle: Text(
//               "تسبيح الزهراء، أو تسبيح فاطمة من الأذكار المشهورة عند الشيعة، وهو أن يقول المسبّح: الله أكبر (34) مرة، الحمد لله (33) مرة، سبحان الله (33) مرة."),
//         ),
//         centerTitle: true,
//         toolbarHeight: 130,
//       ),
//       body: Stack(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                   height: double.infinity,
//                   width: 10,
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage("assets/images/threads.jpg"),
//                         fit: BoxFit.fitHeight,
//                         colorFilter:
//                             ColorFilter.mode(Colors.cyan, BlendMode.color)),
//                   )),
//             ],
//           ),
//           Center(
//             child: SizedBox(
//               width: 70,
//               child: true
//                   ? Stack(children: [
//                       AnimatedPositioned(
//                         duration: Duration(milliseconds: 500),
//                         bottom: ((query.size.height / 60)) * 60 * 0.3 -
//                             (_count * 60),
//                         left: 0,
//                         right: 0,
//                         child: Wrap(
//                           alignment: WrapAlignment.end,
//                           runAlignment: WrapAlignment.end,
//                           verticalDirection: VerticalDirection.up,
//                           children: List.generate(33, (index) => index)
//                               .map(
//                                 (index) => BeadItem(
//                                   count: _count,
//                                   index: index,
//                                   incrementCount: (a) => _incrementCount(a),
//                                 ),
//                               )
//                               .toList(),
//                         ),
//                       ),
//                     ]
//                       // List.generate(33, (index) => index)
//                       //     .map(
//                       //       (index) => AnimatedPositioned(
//                       //         duration: Duration(milliseconds: 200),
//                       //         bottom: (60 * index).toDouble() +
//                       //             (index + 1 > _count
//                       //                 ? 200
//                       //                 : (-60 * _count - index)),
//                       //         child: BeadItem(
//                       //           count: _count,
//                       //           index: index,
//                       //           incrementCount: (a) => _incrementCount(a),
//                       //         ),
//                       //       ),
//                       //     )
//                       //     .toList(),
//                       )
//                   : true
//                       ? ListView.builder(
//                           controller: scontroller,
//                           padding: const EdgeInsets.only(bottom: 100, top: 100),
//                           physics: const NeverScrollableScrollPhysics(),
//                           scrollDirection: Axis.vertical,
//                           reverse: true,
//                           itemCount: 33,
//                           itemBuilder: (context, index) => BeadItem(
//                             count: _count,
//                             index: index,
//                             incrementCount: (a) => _incrementCount(a),
//                           ),
//                         )
//                       : PageView.builder(
//                           onPageChanged: (a) => _incrementCount(a),
//                           scrollDirection: Axis.vertical,
//                           reverse: true,
//                           controller: _pageController,
//                           itemCount: 33,
//                           //  padEnds: false,
//                           itemBuilder: (context, index) {
//                             return BeadItem(
//                               count: _count,
//                               index: index,
//                               incrementCount: (a) => _incrementCount(a),
//                             );
//                           },
//                         ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class BeadItem extends StatelessWidget {
//   final int count;
//   final int index;
//   final Function(int index) incrementCount;
//   const BeadItem(
//       {required this.count, required this.index, required this.incrementCount});

//   @override
//   Widget build(BuildContext context) {
//     final query = MediaQuery.of(context);
//     return GestureDetector(
//       onVerticalDragEnd: (details) {
//         if ((details.primaryVelocity ?? 0) > 0) {
//           incrementCount(count + 1);
//         }
//       },
//       child: Opacity(
//         opacity: 0.9,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 100),
//           curve: Curves.ease,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(50),
//             gradient: _calculateGradient(),
//             image: const DecorationImage(
//               image: const AssetImage("assets/images/bead.png"),
//               fit: BoxFit.cover,
//             ),
//           ),
//           width: 70.0,
//           height: 60.0,
//           margin:
//               EdgeInsets.symmetric(vertical: index >= count ? 5 : 0).copyWith(
//                   //top: (count == index) ? 100 : 0,
//                   bottom: count == index ? 100 : 0),
//           child: Center(
//             child: Text(
//               index == count ? '${index + 1}' : '',
//               style: const TextStyle(
//                 fontSize: 24.0,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//     // AnimatedContainer(
//     //   duration: const Duration(milliseconds: 200),
//     //   curve: Curves.ease,
//     //   width: 200,
//     //   height: index == count ? 10.0 : 0,
//     // ),
//   }

//   _calculateGradient() {
//     // Adjust factor for smoother gradient color
//     return RadialGradient(
//       // begin: Alignment.bottomCenter,
//       // end: Alignment.topCenter,
//       colors: index == count
//           ? [Colors.white70, Colors.black]
//           : [Colors.brown.withOpacity(0.9), Colors.brown.shade900],
//     );
//   }
// }
