import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/bussines_logic/dua/dua_cubit.dart';
import 'package:ramadan/bussines_logic/prayer/prayer_cubit.dart';
import 'package:ramadan/model/ramadan_dua.dart';
import 'package:ramadan/pages/home/emsal_view.dart';
import 'package:ramadan/utils/utils.dart';

import '../bussines_logic/Setting/settings_cubit.dart';

class ZyaratPage extends StatelessWidget {
  const ZyaratPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final duaController = context.read<DuaCubit>();
    if (duaController.state.info.zyaratData == null) {
      duaController.getZyaratMunajat();
    }
    return BlocBuilder<DuaCubit, DuaState>(builder: (context, state) {
      return Container(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: "الزيارات".toGradiant(
                colors: [
                  theme.textTheme.titleLarge!.color!,
                  theme.textTheme.bodySmall!.color!
                ],
                style: theme.textTheme.titleLarge!,
              ),
            ),
            body: state is DuaStateLoading
                ? const Center(child: CircularProgressIndicator())
                : state is DuaStateLoaded && state.info.zyaratData != null
                    ? Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                padding:
                                    const EdgeInsets.only(bottom: 100, top: 12),
                                itemCount:
                                    state.info.zyaratData?.zyaratList?.length ??
                                        0,
                                itemBuilder: (c, i) => InkWell(
                                      onTap: () => Navigator.push(
                                        context,
                                        to(
                                          ZyaraDisplay(
                                            data: state.info.zyaratData!
                                                .zyaratList![i],
                                            index: i,
                                          ),
                                        ),
                                      ),
                                      child: RCard(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: kDefaultPadding,
                                            vertical: 3),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: kDefaultPadding),
                                        child: ListTile(
                                          dense: true,
                                          horizontalTitleGap: 0,
                                          contentPadding: EdgeInsets.zero,
                                          leading: SvgPicture.asset(
                                            "assets/svg/zyara.svg",
                                            height: 20,
                                            color: jbSecondary,
                                          ),
                                          title: Text(
                                            state.info.zyaratData
                                                    ?.zyaratList?[i].title ??
                                                "",
                                            style: theme.textTheme.titleSmall!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    )),
                          ),
                        ],
                      )
                    : state is DuaStateFiald
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "حدث خطأ",
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                " dataProv.trans.error_ser_title",
                                style: Theme.of(context).textTheme.titleLarge,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                " dataProv.trans.error_ser_subtitle",
                                style: Theme.of(context).textTheme.titleLarge,
                                textAlign: TextAlign.center,
                              )
                            ],
                          )),
      );
    });
  }
}

class ZyaraDisplay extends StatelessWidget {
  const ZyaraDisplay({super.key, required this.data, required this.index});
  final Dua data;
  final int index;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final query = MediaQuery.of(context);
    final duaController = context.read<DuaCubit>();
    if (data.text == null) {
      duaController.loadContent(data.path!, (value) {
        if (value != null) {
          duaController.state.info.zyaratData!.zyaratList![index].text = value;
          data.text = value;
          duaController.refresh();
        }
      });
    }

    return Scaffold(
      backgroundColor: theme.cardColor,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: query.viewPadding.top, bottom: 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                color: theme.cardColor),
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
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                  color: theme.scaffoldBackgroundColor),
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
          ),
        ],
      ),
    );
  }
}
