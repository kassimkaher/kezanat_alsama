import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/main_app/slider/presentation/cubit/slider_cubit.dart';
import 'package:ramadan/src/main_app/slider/presentation/widgets/post_details.dart';
import 'package:ramadan/utils/color.dart';
import 'package:ramadan/src/core/widget/blure_background.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeSliderView extends StatefulWidget {
  const HomeSliderView({super.key});

  @override
  State<HomeSliderView> createState() => _HomeSliderViewState();
}

class _HomeSliderViewState extends State<HomeSliderView> {
  int activeIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SliderCubit>().getSliders();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final query = MediaQuery.of(context);
    return BlocBuilder<SliderCubit, SliderState>(
      builder: (context, state) => switch (state.datastatus) {
        DataStatus.success => Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CarouselSlider.builder(
                  itemCount: state.postlist?.data?.length ?? 0,
                  itemBuilder: (context, index, realIndex) {
                    return BlureWidget(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        onTap: () => showBottomSheet(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          constraints: BoxConstraints(
                              maxHeight: query.size.height - 200),
                          context: context,
                          builder: (c) => ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: PostDetails(
                              theme: theme,
                              post: state.postlist!.data![index],
                            ),
                          ),
                        ),
                        child: Container(
                          height: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                              color: theme.scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(16)),
                          child: ListTile(
                            title: Text(
                              state.postlist?.data?[index].author ?? "",
                              style: theme.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: SizedBox(
                              child: Text(
                                state.postlist?.data?[index].description ?? "",
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    aspectRatio: 16 / 8,
                    viewportFraction: 0.95,
                    autoPlayInterval: const Duration(seconds: 8),
                    autoPlay: true,
                    scrollPhysics: const BouncingScrollPhysics(),
                    onPageChanged: (index, _) {
                      setState(() => activeIndex = index);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
              AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: state.postlist?.data?.length ?? 0,
                effect: WormEffect(
                  activeDotColor: theme.primaryColor,
                  dotColor: jbFontColorD,
                  dotHeight: 5,
                  dotWidth: 20,
                ),
              ),
            ],
          ),
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
