import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/bussines_logic/prayer/prayer_cubit.dart';
import 'package:ramadan/model/ramadan_dua.dart';
import 'package:ramadan/utils/utils.dart';

class TextDisplay extends StatelessWidget {
  const TextDisplay({super.key, required this.data, required this.index});
  final Dua data;
  final int index;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final query = MediaQuery.of(context);
    final duaController = context.read<PrayerCubit>();
    if (data.text == null) {
      duaController.loadData(data, index);
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: query.viewPadding.top, bottom: 0),
            decoration: BoxDecoration(
                border: Border.all(color: jbGary2),
                borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                color: Colors.white38),
            child: Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      data.title!,
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
          const SizedBox(height: kDefaultSpacing),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding)
                  .copyWith(bottom: 30, top: kDefaultSpacing),
              child: Column(
                children: [
                  data.desc != null
                      ? Column(
                          children: [
                            Text(
                              data.desc ?? "",
                              style: theme.textTheme.displayLarge!.copyWith(
                                  fontSize: 16, color: jbUnselectColor),
                            ),
                            const SizedBox(
                              height: kDefaultSpacing,
                            ),
                          ],
                        )
                      : const SizedBox(),
                  BlocBuilder<PrayerCubit, PrayerState>(
                    builder: (context, state) {
                      return Text(
                        data.text ?? "",
                        style: theme.textTheme.displayLarge!
                            .copyWith(fontWeight: FontWeight.w400, height: 2),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
