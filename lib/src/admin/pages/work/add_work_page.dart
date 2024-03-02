import 'dart:developer';

import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/model/quran_model.dart';
import 'package:ramadan/sheet/alert_dialog.dart';
import 'package:ramadan/src/admin/logic/work_cubit/work_crud_cubit.dart';
import 'package:ramadan/src/core/entity/data_status.dart';
import 'package:ramadan/src/core/enum/week_day.dart';
import 'package:ramadan/src/core/enum/work_timing.dart';
import 'package:ramadan/src/core/enum/work_type.dart';
import 'package:ramadan/src/core/resources/validation.dart';
import 'package:ramadan/src/core/widget/jb_button_mix.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/daily_work_model.dart';
import 'package:ramadan/src/main_app/widgets/custom_drop_down_input.dart';
import 'package:ramadan/src/main_app/widgets/custom_drop_down_menu_string.dart';
import 'package:ramadan/src/main_app/widgets/custom_text_input.dart';
import 'package:ramadan/utils/utils.dart';

class AddWorkPage extends StatefulWidget {
  const AddWorkPage({super.key, this.dailyWorkData});
  final DailyWorkData? dailyWorkData;
  @override
  State<AddWorkPage> createState() => _AddWorkPageState();
}

class _AddWorkPageState extends State<AddWorkPage> {
  late WorkCrudCubit workCrudCubit;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final textController = TextEditingController();
  String? pathController;
  String? quransuraController;
  String? dayController;
  WeekDay? weekDay;

  String? hour;
  String? monthController;
  final urlController = TextEditingController();
  WorkType? typeController;
  WorkTiming? workTiming;
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
    final allSura =
        context.read<QuranCubit>().state.info.quranModel!.data!.surahs!;
    final document = context.read<DuaCubit>().state.info;

    final textTheme = Theme.of(context).textTheme;
    return BlocConsumer<WorkCrudCubit, WorkCrudState>(
      bloc: workCrudCubit,
      listener: (context, state) {
        if (state.dataStatus == const DataError()) {
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
            title: const Text("add Work"),
          ),
          body: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  "تفاصيل العمل ",
                  style: textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                const Divider(
                  height: 24,
                ),
                buildWorkDetailsFormView(document, allSura),
                const SizedBox(height: 32),
                Text(
                  "توقيت العمل ",
                  style: textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                const Divider(
                  height: 24,
                ),
                CustomDropDownInput(
                  array: WorkTiming.values,
                  selectValue: workTiming,
                  hint: "نوع توقيت العمل",
                  onSelect: (s) {
                    workTiming = s as WorkTiming;
                    setState(() {});
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Visibility(
                      visible: workTiming != null &&
                          [
                            WorkTiming.dayInmonth,
                            WorkTiming.dailyInMonth,
                            WorkTiming.weeklyInMonth,
                            WorkTiming.oneWeekDayInMonth
                          ].contains(workTiming),
                      child: Expanded(
                        child: CustomDropDownMenuString(
                          array: hijreeMonthArray,
                          selectValue: monthController,
                          hint: " الشهر العربي",
                          onSelect: (s) {
                            monthController = s;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Visibility(
                      visible: workTiming != null &&
                          [WorkTiming.dayInmonth, WorkTiming.oneWeekDayInMonth]
                              .contains(workTiming),
                      child: Expanded(
                        child: CustomDropDownMenuString(
                          array: workTiming != null &&
                                  workTiming == WorkTiming.oneWeekDayInMonth
                              ? ["0", "1"]
                              : List<String>.generate(
                                  30, (i) => (i + 1).toString()),
                          selectValue: dayController,
                          hint: " رقم اليوم",
                          onSelect: (s) {
                            dayController = s;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Visibility(
                      visible: workTiming != null &&
                          [
                            WorkTiming.weekly,
                            WorkTiming.weeklyInMonth,
                            WorkTiming.oneWeekDayInMonth
                          ].contains(workTiming),
                      child: Expanded(
                        child: CustomDropDownInput(
                          array: WeekDay.values,
                          selectValue: weekDay,
                          hint: "يوم الاسبوع",
                          onSelect: (s) {
                            weekDay = s as WeekDay;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Visibility(
                      visible: workTiming != null,
                      child: Expanded(
                        child: CustomDropDownMenuString(
                          isNullable: true,
                          array: arabic24HourNames,
                          selectValue: hour,
                          hint: "ساعة العمل",
                          onSelect: (s) {
                            hour = s;
                          },
                        ),
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
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: JBButtonMix(
              isLoading: state.dataStatus == const DataLoading(),
              icon: Icon(widget.dailyWorkData != null &&
                      widget.dailyWorkData?.id != null
                  ? LucideIcons.edit
                  : LucideIcons.plusCircle),
              title: widget.dailyWorkData != null &&
                      widget.dailyWorkData?.id != null
                  ? "تعديل"
                  : "اضافة العمل ",
              onPressed: () {
                setState(() {});

                if (formKey.currentState!.validate()) {
                  workCrudCubit.submitEvent(
                    DailyWorkData(
                      id: widget.dailyWorkData?.id,
                      refrence: widget.dailyWorkData?.refrence,
                      title: titleController.text,
                      description: descriptionController.text,
                      text: textController.text,
                      path: pathController == null
                          ? ""
                          : context
                              .read<DuaCubit>()
                              .state
                              .info
                              .documentEntity!
                              .dua!
                              .where(
                                  (element) => element.title == pathController)
                              .first
                              .path,
                      type: typeController!,
                      workTiming: workTiming,
                      isRequired: true,
                      sura: allSura.indexWhere(
                          (element) => element.name == quransuraController),
                      month: getMonthNumber(),
                      weekDay: weekDay,
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
  String? getMonthName(int number) =>
      (number < 0 || number > 11) ? null : hijreeMonthArray[number];

  Column buildWorkDetailsFormView(DuaData document, List<Surahs> allSura) {
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
          validator: ValidatorEnum.textOnly,
          controller: descriptionController,
          label: "شرح العمل",
          rightPadding: 16,
          leftPadding: 16,
        ),
        const SizedBox(height: 12),
        CustomDropDownInput(
          array: WorkType.values
              .where((element) => element != WorkType.relationship)
              .toList(),
          selectValue: typeController,
          hint: "نوع العمل",
          onSelect: (s) {
            typeController = s as WorkType;
            setState(() {});
          },
        ),
        const SizedBox(height: 12),
        typeController == WorkType.tasbeeh
            ? CustomTextInput(
                validator: ValidatorEnum.number,
                controller: textController,
                label: " عدد التسبيح",
                rightPadding: 16,
                leftPadding: 16,
              )
            : CustomTextInput(
                controller: textController,
                label: "نص العمل",
                rightPadding: 16,
                leftPadding: 16,
                maxLine: 3,
              ),
        const SizedBox(height: 12),
        (typeController != WorkType.quran && typeController != WorkType.tasbeeh)
            ? CustomDropDownMenuString(
                array: typeController == WorkType.dua
                    ? document.documentEntity!.dua!
                        .map((e) => e.title!)
                        .toList()
                    : typeController == WorkType.zyara
                        ? document.zyaratData!.zyaratList!
                            .map((e) => e.title!)
                            .toList()
                        : typeController == WorkType.munajat
                            ? document.zyaratData!.munajatList!
                                .map((e) => e.title!)
                                .toList()
                            : [],
                selectValue: pathController,
                isNullable: textController.text.isNotEmpty ||
                    typeController == WorkType.quran,
                hint: " مسار",
                onSelect: (s) {
                  pathController = s;
                  setState(() {});
                },
              )
            : const SizedBox(),
        const SizedBox(height: 12),
        typeController == WorkType.quran
            ? CustomDropDownMenuString(
                isNullable: true,
                array: allSura.map((e) => e.name!).toList(),
                selectValue: quransuraController,
                hint: " القرآن",
                onSelect: (s) {
                  quransuraController =
                      allSura.where((element) => element.name == s).first.name;
                },
              )
            : const SizedBox(),
      ],
    );
  }

  void fillData(DailyWorkData? dailyWorkData) {
    final allSura =
        context.read<QuranCubit>().state.info.quranModel!.data!.surahs!;

    titleController.text = dailyWorkData?.title ?? "";
    descriptionController.text = dailyWorkData?.description ?? "";
    textController.text = dailyWorkData?.text ?? "";

    try {
      quransuraController = dailyWorkData!.sura != null
          ? allSura[dailyWorkData.sura!].name
          : null;
    } catch (_) {}

    dayController = dailyWorkData?.day.toString();

    weekDay = dailyWorkData?.weekDay;

    hour = dailyWorkData!.hour != null
        ? arabic24HourNames[dailyWorkData.hour!]
        : null;
    log("dailyWorkData.month!=${dailyWorkData.month!}");
    monthController = dailyWorkData.month != null
        ? getMonthName(dailyWorkData.month! - 1)
        : null;
    typeController = dailyWorkData.type;
    workTiming = dailyWorkData.workTiming;

    switch (dailyWorkData.type) {
      case WorkType.dua:
        for (var element
            in context.read<DuaCubit>().state.info.documentEntity!.dua!) {
          if (element.path == dailyWorkData.path) {
            pathController = element.title;
          }
        }

        break;
      default:
    }
  }
}
