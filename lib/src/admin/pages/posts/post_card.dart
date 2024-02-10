import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/src/main_app/slider/data/model/slider_model.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.dailyPostData, this.ondelete});

  final DailyPostData dailyPostData;
  final Function()? ondelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final query = MediaQuery.of(context);
    return Container(
      width: query.size.width - 32,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.disabledColor.withAlpha(100)),
          boxShadow: [
            BoxShadow(
              color: theme.scaffoldBackgroundColor,
              blurRadius: 10,
              spreadRadius: -1,
              blurStyle: BlurStyle.inner,
            )
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: ListTile(
        horizontalTitleGap: 10,

        title: Text(
          dailyPostData.title ?? "",
          style: theme.textTheme.bodyLarge,
        ),
        // const SizedBox(width: 5),
        subtitle: Text(
          dailyPostData.description ?? "",
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: theme.textTheme.titleSmall,
        ),
        trailing: ondelete != null
            ? ActionChip(
                backgroundColor: Colors.red,
                onPressed: ondelete,
                label: const Icon(
                  LucideIcons.trash,
                  color: Colors.white,
                ),
              )
            : null,
      ),
    );
  }
}

class PostCardPlaceHolder extends StatelessWidget {
  const PostCardPlaceHolder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final query = MediaQuery.of(context);
    return Skeletonizer(
      child: Container(
        width: query.size.width - 32,
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.disabledColor.withAlpha(100)),
            boxShadow: [
              BoxShadow(
                color: theme.scaffoldBackgroundColor,
                blurRadius: 10,
                spreadRadius: -1,
                blurStyle: BlurStyle.inner,
              )
            ]),
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: ListTile(
          horizontalTitleGap: 10,

          title: Text(
            " workType.name.tr()",
            style: theme.textTheme.bodyLarge,
          ),
          // const SizedBox(width: 5),
          subtitle: Text(
            "subtitle",
            style: theme.textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}
