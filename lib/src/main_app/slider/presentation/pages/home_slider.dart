import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/main_app/slider/presentation/widgets/post_details.dart';
import 'package:ramadan/utils/utils.dart';

class HomeSliderView extends StatelessWidget {
  const HomeSliderView({super.key});

  @override
  Widget build(BuildContext context) {
    final sliderCubit = context.read<SliderCubit>();
    final theme = Theme.of(context);
    final query = MediaQuery.of(context);

    return BlocBuilder<SliderCubit, SliderState>(
      builder: (context, state) => switch (state.datastatus) {
        SateSucess() => InkWell(
            onTap: () => showAdaptiveDialog(
              context: context,
              builder: (c) => ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: PostDetails(
                  theme: theme,
                  post: state.postlist!.data![state.activeIndex.toInt()],
                ),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              height: 200,
              decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(16)),
              alignment: Alignment.topCenter,
              child: ClipRRect(
                child: Stack(
                  children: state.postlist!.data!
                      .asMap()
                      .map(
                        (i, e) => MapEntry(
                          i,
                          AnimatedSlide(
                            curve: Curves.easeInOutExpo,
                            offset: i > state.activeIndex.toInt()
                                ? const Offset(-1, 0)
                                : const Offset(0, 0),
                            duration: const Duration(milliseconds: 1000),
                            onEnd: () =>
                                sliderCubit.slidePost(state.activeIndex + 1),
                            child: Container(
                              height: 200,
                              padding: const EdgeInsets.all(16),
                              width: query.size.width - 24,
                              child: AnimatedOpacity(
                                curve: Curves.easeInCirc,
                                opacity: i == state.activeIndex.toInt() ? 1 : 0,

                                duration: const Duration(milliseconds: 1000),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      state.postlist!.data![i].author ?? "",
                                      style:
                                          theme.textTheme.bodyLarge!.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      state.postlist!.data![i].description ??
                                          "",
                                      style:
                                          theme.textTheme.bodyLarge!.copyWith(
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 5,
                                    ),
                                  ],
                                ),
                                // onEnd: () => sliderCubit
                                //     .slidePost(state.activeIndex + 1),
                              ),
                            ),
                          ),
                        ),
                      )
                      .values
                      .toList(),
                ),
              ),
            ),
          ),
        const StateLoading() => AspectRatio(
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
