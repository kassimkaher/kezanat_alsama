import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/utils/utils.dart';

class ReadSheet extends StatelessWidget {
  const ReadSheet(
      {super.key, required this.title, required this.content, this.desc});
  final String title;
  final String? desc;
  final String content;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final query = MediaQuery.of(context);

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: kDefaultPadding, bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(color: theme.colorScheme.outline),
              borderRadius: BorderRadius.circular(kDefaultBorderRadius),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      title,
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(LucideIcons.x))
              ],
            ),
          ),
          // const SizedBox(height: kDefaultSpacing),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding)
                  .copyWith(bottom: 30, top: kDefaultSpacing),
              child: Column(
                children: [
                  desc != null
                      ? Column(
                          children: [
                            Text(
                              desc ?? "",
                              style: theme.textTheme.displayLarge!.copyWith(
                                  fontSize: 16, color: jbUnselectColor),
                            ),
                            const SizedBox(
                              height: kDefaultSpacing,
                            ),
                          ],
                        )
                      : const SizedBox(),
                  Text(
                    content,
                    style: theme.textTheme.displayLarge!
                        .copyWith(fontWeight: FontWeight.w400, height: 2),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
