import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../core/widget/jb_button_icon.dart';

class AdaptivAppBar extends StatelessWidget {
  const AdaptivAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Navigator.canPop(context)
              ? JBIconButton(
                  backgroundColor: theme.primaryColor.withOpacity(0.2),
                  color: theme.primaryColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: LucideIcons.x)
              : const SizedBox()
        ],
      ),
    );
  }
}
