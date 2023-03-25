import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/bussines_logic/dua/dua_cubit.dart';
import 'package:ramadan/bussines_logic/ramadan/ramadan_cubit.dart';
import 'package:ramadan/model/ramadan_dua.dart';
import 'package:ramadan/pages/home/home.dart';
import 'package:ramadan/utils/utils.dart';

import '../bussines_logic/Setting/settings_cubit.dart';

class DuaPage extends StatelessWidget {
  const DuaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final query = MediaQuery.of(context);
    final size = query.size;
    final duaController = context.read<DuaCubit>();
    if (duaController.state is! DuaStateLoaded) {
      duaController.getMufatehALgynan();
    }
    return BlocBuilder<DuaCubit, DuaState>(builder: (context, state) {
      return Container(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: state is DuaStateLoading
                ? const Center(child: CircularProgressIndicator())
                : state is DuaStateLoaded
                    ? Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: query.viewPadding.top,
                                left: kDefaultPadding,
                                right: kDefaultPadding,
                                bottom: 0),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border(bottom: BorderSide(color: jbGary2))),
                            child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: ListTile(
                                  title: "الادعية".toGradiant(
                                    colors: [
                                      theme.textTheme.titleLarge!.color!,
                                      theme.textTheme.bodySmall!.color!
                                    ],
                                    style: theme.textTheme.titleLarge!,
                                  ),
                                )),
                          ),
                          Expanded(
                            child: ListView.builder(
                                padding:
                                    const EdgeInsets.only(bottom: 100, top: 12),
                                itemCount:
                                    state.info.ramadanDuaModel?.dua?.length ??
                                        0,
                                itemBuilder: (c, i) => InkWell(
                                      onTap: () => Navigator.push(
                                        context,
                                        to(
                                          DuaDisplay(
                                            data: state
                                                .info.ramadanDuaModel!.dua![i],
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
                                        // decoration: BoxDecoration(
                                        //     // color: scaffoldColor,
                                        //     borderRadius: BorderRadius.circular(
                                        //         kDefaultBorderRadius)),
                                        child: ListTile(
                                          dense: true,
                                          horizontalTitleGap: 0,
                                          contentPadding: EdgeInsets.zero,
                                          leading: SvgPicture.asset(
                                            "assets/svg/dua.svg",
                                            height: 20,
                                            color: jbSecondary,
                                          ),
                                          title: Text(
                                            state.info.ramadanDuaModel!.dua![i]
                                                .title!,
                                            style: theme.textTheme.titleSmall,
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

class DuaDisplay extends StatelessWidget {
  const DuaDisplay({super.key, required this.data, required this.index});
  final Dua data;
  final int index;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final query = MediaQuery.of(context);
    final duaController = context.read<DuaCubit>();
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
                  BlocBuilder<RamadanCubit, RamadanState>(
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
