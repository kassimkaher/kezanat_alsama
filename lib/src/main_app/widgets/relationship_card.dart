import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/daily_work_model.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RelationshibsCard extends StatelessWidget {
  const RelationshibsCard(
      {super.key, this.onTap, required this.dailyWorkData, this.ondelete});

  final Function()? onTap;

  final DailyWorkData dailyWorkData;

  final Function()? ondelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final query = MediaQuery.of(context);
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: query.size.width - 32,
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.primaryColor.withAlpha(100)),
              boxShadow: [
                BoxShadow(
                  color: theme.scaffoldBackgroundColor,
                  blurRadius: 10,
                  spreadRadius: -1,
                  blurStyle: BlurStyle.inner,
                )
              ]),
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  dailyWorkData.title ?? "",
                  style: theme.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: dailyWorkData.url ?? "",
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              dailyWorkData.description == null ||
                      dailyWorkData.description!.isEmpty
                  ? const SizedBox()
                  : Text(
                      dailyWorkData.description ?? "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
