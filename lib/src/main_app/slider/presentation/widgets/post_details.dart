import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/src/main_app/slider/data/model/slider_model.dart';
import 'package:ramadan/utils/color.dart';
import 'package:ramadan/src/core/widget/jb_button_icon.dart';

class PostDetails extends StatelessWidget {
  const PostDetails({super.key, required this.theme, required this.post});

  final ThemeData theme;
  final DailyPostData post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(
            children: [
              Text(
                post.author ?? "",
                style: theme.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w600, color: fontTitle),
              ),
              const Spacer(),
              JBIconButton(
                  backgroundColor: theme.primaryColor.withOpacity(0.2),
                  color: theme.primaryColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: LucideIcons.x)
            ],
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                post.description ?? "",
                style: theme.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w400, color: fontTitle),
              ),
            ),
          ),
          const Divider(),
          Row(
            children: [
              const Text("المصدر : "),
              Text(
                post.author ?? "",
                style: theme.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.w600, color: fontTitle),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          )
        ]),
      ),
    );
  }
}
