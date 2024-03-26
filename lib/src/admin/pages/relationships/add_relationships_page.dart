import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/sheet/alert_dialog.dart';
import 'package:ramadan/src/admin/logic/work_cubit/work_crud_cubit.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/core/enum/week_day.dart';
import 'package:ramadan/src/core/enum/work_timing.dart';
import 'package:ramadan/src/core/enum/work_type.dart';
import 'package:ramadan/src/core/resources/validation.dart';
import 'package:ramadan/src/core/widget/jb_button_mix.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/daily_work_model.dart';
import 'package:ramadan/src/main_app/widgets/custom_drop_down_menu_string.dart';
import 'package:ramadan/src/main_app/widgets/custom_text_input.dart';
import 'package:ramadan/utils/utils.dart';

class AddRelationshipsPage extends StatefulWidget {
  const AddRelationshipsPage({super.key, this.dailyWorkData});
  final DailyWorkData? dailyWorkData;
  @override
  State<AddRelationshipsPage> createState() => _AddRelationshipsPageState();
}

class _AddRelationshipsPageState extends State<AddRelationshipsPage> {
  late WorkCrudCubit workCrudCubit;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final urlController = TextEditingController();

  String? dayController;

  String? hour;
  String? monthController;

  final formKey = GlobalKey<FormState>();
  final key = GlobalKey();
  @override
  void initState() {
    super.initState();

    workCrudCubit = context.read<WorkCrudCubit>();

    if (widget.dailyWorkData != null) {
      fillData(widget.dailyWorkData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocConsumer<WorkCrudCubit, WorkCrudState>(
      bloc: workCrudCubit,
      listener: (context, state) {
        if (state.dataStatus == const StateError()) {
          showTMDialog(
            title: "fail".tr(),
            msg: "connection_error_confirm".tr(),
            icon: const Icon(
              LucideIcons.alertTriangle,
              color: Colors.red,
            ),
          );
        }
        if (state.dataStatus == const DataSucessOperation()) {
          showTMDialog(
            title: "Sucess".tr(),
            msg: "Done Add Work".tr(),
            icon: const Icon(
              LucideIcons.checkCheck,
              color: Colors.green,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("المناسبات "),
          ),
          body: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  "تفاصيل المناسبة ",
                  style: textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                const Divider(
                  height: 24,
                ),
                buildWorkDetailsFormView(),
                const SizedBox(height: 32),
                Text(
                  "توقيت المناسبة ",
                  style: textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                const Divider(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropDownMenuString(
                        array: hijreeMonthArray,
                        selectValue: monthController,
                        hint: " الشهر العربي",
                        onSelect: (s) {
                          monthController = s;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CustomDropDownMenuString(
                        array: List<String>.generate(
                            30, (i) => (i + 1).toString()),
                        selectValue: dayController,
                        hint: " رقم اليوم",
                        onSelect: (s) {
                          dayController = s;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                CustomTextInput(
                  controller: urlController,
                  label: " URL",
                  rightPadding: 16,
                  leftPadding: 16,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropDownMenuString(
                        isNullable: true,
                        array: arabic24HourNames,
                        selectValue: hour,
                        hint: "ساعة المناسبة",
                        onSelect: (s) {
                          hour = s;
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
              isLoading: state.dataStatus == const StateLoading(),
              icon: Icon(widget.dailyWorkData != null &&
                      widget.dailyWorkData?.id != null
                  ? LucideIcons.edit
                  : LucideIcons.plusCircle),
              title: widget.dailyWorkData != null &&
                      widget.dailyWorkData?.id != null
                  ? "تعديل"
                  : "اضافة المناسبة ",
              onPressed: () {
                setState(() {});

                if (formKey.currentState!.validate()) {
                  workCrudCubit.submitEvent(
                    DailyWorkData(
                      id: widget.dailyWorkData?.id,
                      refrence: widget.dailyWorkData?.refrence,
                      title: titleController.text,
                      description: descriptionController.text,
                      text: "",
                      path: "",
                      type: WorkType.relationship,
                      workTiming: WorkTiming.dayInmonth,
                      isRequired: true,
                      url: urlController.text,
                      month: getMonthNumber(),
                      weekDay: WeekDay.friday,
                      hour:
                          hour != null ? arabic24HourNames.indexOf(hour!) : -1,
                      day: dayController?.toInt(),
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  int getMonthNumber() => monthController == null
      ? -1
      : hijreeMonthArray.indexOf(monthController!) + 1;
  String getMonthName(int number) => hijreeMonthArray[number];

  Column buildWorkDetailsFormView() {
    return Column(
      children: [
        CustomTextInput(
          isRequired: ValidatorEnum.required,
          controller: titleController,
          label: "العنوان",
          rightPadding: 16,
          leftPadding: 16,
        ),
        const SizedBox(height: 12),
        CustomTextInput(
          controller: descriptionController,
          label: "شرح المناسبة",
          rightPadding: 16,
          leftPadding: 16,
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  void fillData(DailyWorkData? dailyWorkData) {
    titleController.text = dailyWorkData?.title ?? "";
    descriptionController.text = dailyWorkData?.description ?? "";

    dayController = dailyWorkData?.day.toString();

    hour = dailyWorkData!.hour != null
        ? arabic24HourNames[dailyWorkData.hour!]
        : null;

    monthController = dailyWorkData.month != null
        ? getMonthName(dailyWorkData.month! - 1)
        : null;
    urlController.text = dailyWorkData.url ?? "";
  }
}
