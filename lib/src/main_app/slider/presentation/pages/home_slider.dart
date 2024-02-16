import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/main_app/slider/presentation/cubit/slider_cubit.dart';
import 'package:ramadan/src/main_app/slider/presentation/widgets/post_details.dart';

class HomeSliderView extends StatelessWidget {
  const HomeSliderView({super.key});

  @override
  Widget build(BuildContext context) {
    final sliderCubit = context.read<SliderCubit>();
    final theme = Theme.of(context);
    final query = MediaQuery.of(context);

    return BlocBuilder<SliderCubit, SliderState>(
      builder: (context, state) => switch (state.datastatus) {
        DataStatus.success =>

          // reverseDuration: const Duration(seconds: 4),
          // transitionBuilder: (Widget child, Animation<double> animation) {
          //   return FadeTransition(
          //     opacity: Tween<double>(begin: 0, end: 1).animate(animation),

          //     child: child,
          //     // position: Tween<double>(
          //     //         begin: Offset(0.0, -0.5),
          //     //         end: Offset(0.0, 0.0))
          //     //     .animate(animation),
          //   );
          // },
          InkWell(
              onTap: () => showBottomSheet(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    constraints:
                        BoxConstraints(maxHeight: query.size.height - 200),
                    context: context,
                    builder: (c) => ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: PostDetails(
                        theme: theme,
                        post: state.postlist!.data![state.activeIndex],
                      ),
                    ),
                  ),
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  height: 200,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(16)),
                  alignment: Alignment.topCenter,
                  child: ListTile(
                    title: AnimatedTextKit(
                      animatedTexts: state.postlist!.data!
                          .map(
                            (e) => FadeAnimatedText(
                              e.author ?? "",
                              // maxLines: 5,
                              //   overflow: TextOverflow.ellipsis,
                              duration: const Duration(seconds: 6),
                              fadeInEnd: 0.1,
                              fadeOutBegin: 0.9,
                              textStyle: theme.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                          .toList(),
                      pause: const Duration(milliseconds: 200),
                    ),

                    // Text(
                    //   state.postlist?.data?[state.activeIndex].author ??
                    //       "",
                    //   style: theme.textTheme.bodyLarge!.copyWith(
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                    subtitle: SizedBox(
                        child: AnimatedTextKit(
                      animatedTexts: state.postlist!.data!
                          .map((e) => FadeAnimatedText(
                                e.description ?? "",
                                // maxLines: 5,
                                //   overflow: TextOverflow.ellipsis,
                                textStyle: theme.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),

                                duration: const Duration(seconds: 6),
                                fadeInEnd: 0.1,
                                fadeOutBegin: 0.9,
                              ))
                          .toList(),
                      onNext: (p0, p1) => sliderCubit.changeActiveIndex(p0 + 1),
                      pause: const Duration(milliseconds: 200),
                    )),
                  ))),
        DataStatus.loading => AspectRatio(
            aspectRatio: 16 / 8,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(16)),
            ),
          ),
        _ => const SizedBox()
      },
    );
  }
}
