import 'package:flutter_svg/flutter_svg.dart';
import 'package:ramadan/src/main_app/dua/work_display_view.dart';
import 'package:ramadan/src/main_app/widgets/custom_card.dart';
import 'package:ramadan/utils/utils.dart';

class MunajatPage extends StatelessWidget {
  const MunajatPage({super.key});

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
              title: "المناجات".toGradiant(
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
                    ? ListView.builder(
                        padding: const EdgeInsets.only(bottom: 100, top: 12),
                        itemCount:
                            state.info.zyaratData?.munajatList?.length ?? 0,
                        itemBuilder: (c, i) => InkWell(
                              onTap: () => Navigator.push(
                                context,
                                to(
                                  WorkDisplayText(
                                    data:
                                        state.info.zyaratData!.munajatList![i],
                                  ),
                                ),
                              ),
                              child: RCard(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding, vertical: 3),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding),
                                child: ListTile(
                                  dense: true,
                                  horizontalTitleGap: 0,
                                  contentPadding: EdgeInsets.zero,
                                  leading: SvgPicture.asset(
                                    "assets/svg/munajat.svg",
                                    height: 20,
                                    color: jbSecondary,
                                  ),
                                  title: Text(
                                    state.info.zyaratData?.munajatList?[i]
                                            .title ??
                                        "",
                                    style: theme.textTheme.titleSmall!
                                        .copyWith(fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ))
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
