import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/sheet/alert_dialog.dart';
import 'package:ramadan/src/admin/logic/calendar_cubit/calendar_cubit.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/core/resources/validation.dart';
import 'package:ramadan/src/core/widget/jb_button_mix.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/calendar_model.dart';
import 'package:ramadan/src/main_app/widgets/custom_drop_down_menu_string.dart';
import 'package:ramadan/src/main_app/widgets/custom_text_input.dart';
import 'package:ramadan/utils/utils.dart';

class UpdateCalendarForm extends StatefulWidget {
  const UpdateCalendarForm({super.key});

  @override
  State<UpdateCalendarForm> createState() => _UpdateCalendarFormState();
}

class _UpdateCalendarFormState extends State<UpdateCalendarForm> {
  late CalendarCubit calendarCubit;
  final hijryYearController = TextEditingController();

  String? hijreeDay;
  String? meladyDay;

  String? hijryMonth;
  String? meladMonth;
  final urlController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final key = GlobalKey();
  @override
  void initState() {
    super.initState();

    calendarCubit = context.read<CalendarCubit>();
    try {
      if (calendarCubit.state.calendarModel != null) {
        hijryYearController.text =
            calendarCubit.state.calendarModel!.hijreYear ?? "";
        hijryMonth = hijreeMonthArray[
            calendarCubit.state.calendarModel!.hijreeMonth! - 1];
        hijreeDay = calendarCubit.state.calendarModel!.hijreeDay.toString();
        meladMonth = calendarCubit.state.calendarModel!.meladyMonth != null
            ? arabicMonthNames[
                calendarCubit.state.calendarModel!.meladyMonth! - 1]
            : null;
        meladyDay = calendarCubit.state.calendarModel!.meladyDay.toString();
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalendarCubit, CalendarState>(
      bloc: calendarCubit,
      listener: (context, state) {
        if (state.datastatus == const StateError()) {
          showTMDialog(
            title: "fail".tr(),
            msg: "connection_error_confirm".tr(),
            icon: const Icon(
              LucideIcons.alertTriangle,
              color: Colors.red,
            ),
          );
        }
        if (state.datastatus == const SateSucess()) {
          showTMDialog(
              title: "Sucess".tr(),
              msg: "Done Add Work".tr(),
              icon: const Icon(
                LucideIcons.checkCheck,
                color: Colors.green,
              ),
              onDissmiss: () {
                navigatorKey.currentState!.pop();
              });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("التقويم"),
          ),
          body: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                CustomTextInput(
                  isRequired: ValidatorEnum.required,
                  validator: ValidatorEnum.number,
                  controller: hijryYearController,
                  label: "رقم السنة الهجري",
                  rightPadding: 16,
                  leftPadding: 16,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropDownMenuString(
                        array: hijreeMonthArray,
                        selectValue: hijryMonth,
                        hint: " الشهر العربي",
                        onSelect: (s) {
                          hijryMonth = s;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CustomDropDownMenuString(
                        array: List<String>.generate(
                            31, (i) => (i + 1).toString()),
                        selectValue: hijreeDay,
                        hint: "رقم اليوم الهجري",
                        onSelect: (s) {
                          hijreeDay = s;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropDownMenuString(
                        array: arabicMonthNames,
                        selectValue: meladMonth,
                        hint: " الشهر الميلادي",
                        onSelect: (s) {
                          meladMonth = s;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CustomDropDownMenuString(
                        array: List<String>.generate(
                            31, (i) => (i + 1).toString()),
                        selectValue: meladyDay,
                        hint: " رقم اليوم الميلادي",
                        onSelect: (s) {
                          meladyDay = s;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: JBButtonMix(
              isLoading: state.datastatus == const StateLoading(),
              icon: const Icon(LucideIcons.plusCircle),
              title: "تحديث التقويم",
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  calendarCubit.updateCalendar(CalendarModel(
                    refrence: state.calendarModel!.refrence,
                    hijreYear: hijryYearController.text,
                    hijreeMonth: hijreeMonthArray.indexOf(hijryMonth!) + 1,
                    hijreeDay: int.parse(hijreeDay ?? "0"),
                    meladyMonth: arabicMonthNames.indexOf(meladMonth!) + 1,
                    meladyDay: int.parse(meladyDay ?? "0"),
                    hijreeMonthName: hijryMonth,
                  ));
                }
                setState(() {});
              },
            ),
          ),
        );
      },
    );
  }
}
