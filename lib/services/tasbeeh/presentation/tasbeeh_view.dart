import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/services/tasbeeh/cubit/tasbeeh_cubit.dart';
import 'package:ramadan/utils/utils.dart';

class TasbeehView extends StatelessWidget {
  const TasbeehView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final tasbeehCubit = context.read<TasbeehCubit>();
    final query = MediaQuery.of(context);
    return BlocBuilder<TasbeehCubit, TasbeehState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: ListTile(
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 0,
              leading: IconButton(
                icon: const Icon(LucideIcons.x),
                onPressed: () => navigatorKey.currentState!.pop(),
              ),
              title: Text(tasbeehCubit.tasbeehModel.tasbeehList.first.title),
              subtitle:
                  Text(tasbeehCubit.tasbeehModel.tasbeehList.first.description),
            ),
            centerTitle: true,
            toolbarHeight: 130,
          ),
          body: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: double.infinity,
                      width: 10,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/threads.jpg"),
                            fit: BoxFit.fitHeight,
                            colorFilter:
                                ColorFilter.mode(Colors.cyan, BlendMode.color)),
                      )),
                ],
              ),
              Center(
                child: SizedBox(
                    width: 70,
                    child:
                        //  true
                        //     ?
                        Stack(children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 500),
                        bottom: ((query.size.height / 60)) * 60 * 0.3 -
                            (state.repetitionNumber * 60),
                        left: 0,
                        right: 0,
                        child: Wrap(
                          alignment: WrapAlignment.end,
                          runAlignment: WrapAlignment.end,
                          verticalDirection: VerticalDirection.up,
                          children: List.generate(33, (index) => index)
                              .map(
                                (index) => BeadItem(
                                    count: state.repetitionNumber,
                                    index: index,
                                    incrementCount: (a) =>
                                        tasbeehCubit.incrementCount(a)),
                              )
                              .toList(),
                        ),
                      ),
                    ]
                            // List.generate(33, (index) => index)
                            //     .map(
                            //       (index) => AnimatedPositioned(
                            //         duration: Duration(milliseconds: 200),
                            //         bottom: (60 * index).toDouble() +
                            //             (index + 1 > _count
                            //                 ? 200
                            //                 : (-60 * _count - index)),
                            //         child: BeadItem(
                            //           count: _count,
                            //           index: index,
                            //           incrementCount: (a) => _incrementCount(a),
                            //         ),
                            //       ),
                            //     )
                            //     .toList(),
                            )
                    // : true
                    //     ? ListView.builder(
                    //         controller: scontroller,
                    //         padding:
                    //             const EdgeInsets.only(bottom: 100, top: 100),
                    //         physics: const NeverScrollableScrollPhysics(),
                    //         scrollDirection: Axis.vertical,
                    //         reverse: true,
                    //         itemCount: 33,
                    //         itemBuilder: (context, index) => BeadItem(
                    //           count: _count,
                    //           index: index,
                    //           incrementCount: (a) => _incrementCount(a),
                    //         ),
                    //       )
                    //     : PageView.builder(
                    //         onPageChanged: (a) => _incrementCount(a),
                    //         scrollDirection: Axis.vertical,
                    //         reverse: true,
                    //         controller: _pageController,
                    //         itemCount: 33,
                    //         //  padEnds: false,
                    //         itemBuilder: (context, index) {
                    //           return BeadItem(
                    //             count: _count,
                    //             index: index,
                    //             incrementCount: (a) => _incrementCount(a),
                    //           );
                    //         },
                    //       ),
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BeadItem extends StatelessWidget {
  final int count;
  final int index;
  final Function(int index) incrementCount;
  const BeadItem(
      {required this.count, required this.index, required this.incrementCount});

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if ((details.primaryVelocity ?? 0) > 0) {
          incrementCount(count + 1);
        }
      },
      child: Opacity(
        opacity: 0.9,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.ease,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: _calculateGradient(),
            image: const DecorationImage(
              image: const AssetImage("assets/images/bead.png"),
              fit: BoxFit.cover,
            ),
          ),
          width: 70.0,
          height: 60.0,
          margin:
              EdgeInsets.symmetric(vertical: index >= count ? 5 : 0).copyWith(
                  //top: (count == index) ? 100 : 0,
                  bottom: count == index ? 100 : 0),
          child: Center(
            child: Text(
              index == count ? '${index + 1}' : '',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
    // AnimatedContainer(
    //   duration: const Duration(milliseconds: 200),
    //   curve: Curves.ease,
    //   width: 200,
    //   height: index == count ? 10.0 : 0,
    // ),
  }

  _calculateGradient() {
    // Adjust factor for smoother gradient color
    return RadialGradient(
      // begin: Alignment.bottomCenter,
      // end: Alignment.topCenter,
      colors: index == count
          ? [Colors.white70, Colors.black]
          : [Colors.brown.withOpacity(0.9), Colors.brown.shade900],
    );
  }
}
