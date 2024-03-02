import 'dart:ui';

import 'package:ramadan/services/tasbeeh/cubit/tasbeeh_cubit.dart';
import 'package:ramadan/utils/utils.dart';
import 'dart:math' as math;

class TasbeehView extends StatelessWidget {
  const TasbeehView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final tasbeehCubit = context.read<TasbeehCubit>();
    final query = MediaQuery.of(context);
    final theme = Theme.of(context);
    return BlocBuilder<TasbeehCubit, TasbeehState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(tasbeehCubit.tasbeehModel.tasbeehList.isNotEmpty
                ? tasbeehCubit.tasbeehModel.tasbeehList.first.title
                : "تسبيح مفتوح"),
            centerTitle: false,
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [theme.primaryColor, theme.scaffoldBackgroundColor],
                  stops: const [0, 0.8],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const ThreadWidget(),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 100),
                  bottom: ((query.size.height / 60)) * 60 * 0.3 -
                      (state.repetitionNumber * 60),
                  left: 0,
                  right: 0,
                  child: Wrap(
                    // direction: Axis.vertical,
                    runAlignment: WrapAlignment.center,
                    verticalDirection: VerticalDirection.up,
                    children: List.generate(
                            tasbeehCubit.tasbeehModel.tasbeehList.isNotEmpty &&
                                    tasbeehCubit.tasbeehModel
                                            .tasbeehList[state.index].number >
                                        101
                                ? tasbeehCubit.tasbeehModel
                                    .tasbeehList[state.index].number
                                : 101,
                            (index) => index + 1)
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
              ],
            ),
          ),
          bottomNavigationBar: tasbeehCubit.tasbeehModel.tasbeehList.isEmpty
              ? const SizedBox()
              : Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: theme.textTheme.bodyLarge!.color),
                  child: Text(
                    tasbeehCubit.tasbeehModel.tasbeehList[state.index].speak,
                    style: theme.textTheme.titleLarge!
                        .copyWith(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ),
        );
      },
    );
  }
}

class ThreadWidget extends StatelessWidget {
  const ThreadWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: double.infinity,
            width: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/thread.png"),
              ),
            )),
      ],
    );
  }
}

class ShahoolBead extends StatelessWidget {
  const ShahoolBead({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.9,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.ease,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.black,
        ),
        width: 70.0,
        height: 40.0,
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawArc(rect, 0, math.pi, true, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class BeadItem extends StatelessWidget {
  final int count;
  final int index;
  final Function(int index) incrementCount;
  const BeadItem(
      {super.key,
      required this.count,
      required this.index,
      required this.incrementCount});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: () => incrementCount(count + 1),
        onVerticalDragEnd: (details) {
          if ((details.primaryVelocity ?? 0) > 0 && index == count) {
            incrementCount(count + 1);
          }
          if ((details.primaryVelocity ?? 0) < 0 && index == count) {
            incrementCount(count - 1);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: 0.9,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                curve: Curves.ease,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: _calculateGradient(),
                  image: DecorationImage(
                      image: const AssetImage("assets/images/bead.png"),
                      fit: BoxFit.cover,
                      colorFilter: (index == 34 || index == 68)
                          ? const ColorFilter.srgbToLinearGamma()
                          : null),
                ),
                width: 70.0,
                height: (index == 34 || index == 68) ? 40 : 60.0,
                margin: EdgeInsets.symmetric(vertical: index >= count ? 5 : 0)
                    .copyWith(
                  bottom: count == index ? 100 : 0,
                ),
                child: Center(
                  child: Text(
                    index == count ? '$index' : '',
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _calculateGradient() {
    // Adjust factor for smoother gradient color
    return RadialGradient(
      // begin: Alignment.bottomCenter,
      // end: Alignment.topCenter,
      colors: [Colors.green.withOpacity(0.9), Colors.green.shade900],
    );
  }
}