import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/src/core/enum/work_type.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/daily_work_model.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WorkCard extends StatelessWidget {
  const WorkCard(
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
          leading: Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: theme.disabledColor,
            ),
            child: SvgPicture.asset(
              "assets/svg/${dailyWorkData.type == WorkType.salat ? "munajat" : dailyWorkData.type == WorkType.zyara ? "zyara" : "dua"}.svg",
              color: theme.scaffoldBackgroundColor,
            ),
          ),
          title: Text(
            dailyWorkData.title ?? "",
            style: theme.textTheme.bodyLarge,
          ),
          // const SizedBox(width: 5),
          subtitle: Text(
            dailyWorkData.description ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleSmall,
          ),
          trailing: ondelete != null
              ? ActionChip(
                  backgroundColor: Colors.red,
                  onPressed: ondelete,
                  label: Icon(
                    LucideIcons.trash,
                    color: Colors.white,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

class WorkCardPlaceHolder extends StatelessWidget {
  const WorkCardPlaceHolder({
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
          leading: Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: theme.disabledColor,
              ),
              child: SizedBox(
                height: 20,
                width: 20,
              )),
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
