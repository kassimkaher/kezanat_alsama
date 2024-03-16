import 'package:flutter/widgets.dart';
import 'package:ramadan/src/main_app/home/daily_work/logic/daily_work_logic/daily_work_cubit.dart';
import 'package:ramadan/src/main_app/home/daily_work/page/daily_work_view.dart';
import 'package:ramadan/src/main_app/widgets/adaptive_dialog_appbar.dart';
import 'package:ramadan/src/main_app/widgets/work_card.dart';
import 'package:ramadan/utils/utils.dart';

class WorkOfMonthView extends StatelessWidget {
  const WorkOfMonthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DailyWorkCubit, DailyWorkState>(
        builder: (c, state) => state.monthWorkModel == null ||
                state.monthWorkModel!.data!.isEmpty
            ? const SizedBox()
            : SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AdaptivAppBar(title: "اعمال هذا الشهر"),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        separatorBuilder: (c, i) => const SizedBox(height: 0),
                        itemCount: state.monthWorkModel?.data?.length ?? 0,
                        itemBuilder: (c, i) => WorkCard(
                          dailyWorkData: state.monthWorkModel!.data![i],
                          onTap: () =>
                              onTapWork(state.monthWorkModel!.data![i]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
