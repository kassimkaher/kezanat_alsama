import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan/model/ramadan_dua.dart';
import 'package:ramadan/src/core/functions/load_resource.dart';
import 'package:ramadan/utils/utils.dart';
import 'package:sizer/sizer.dart';

class WorkDisplayText extends StatefulWidget {
  const WorkDisplayText({
    super.key,
    required this.data,
  });
  final DuaEntity data;

  @override
  State<WorkDisplayText> createState() => _WorkDisplayTextState();
}

class _WorkDisplayTextState extends State<WorkDisplayText> {
  late DuaEntity duaEntity;
  @override
  void initState() {
    super.initState();
    duaEntity = widget.data;
    if (widget.data.path != null) {
      loadContent(widget.data.path!, (value) {
        if (value != null) {
          setState(() {
            duaEntity.text = value;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final query = MediaQuery.of(context);

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
                      widget.data.title!,
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
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                  color: theme.scaffoldBackgroundColor),
              child: SingleChildScrollView(
                padding: SizerUtil.deviceType == DeviceType.tablet
                    ? const EdgeInsets.all(34)
                    : const EdgeInsets.symmetric(horizontal: kDefaultPadding)
                        .copyWith(bottom: 30, top: kDefaultSpacing),
                child: Column(
                  children: [
                    widget.data.desc != null
                        ? Column(
                            children: [
                              Text(
                                widget.data.desc ?? "",
                                style: theme.textTheme.displayLarge!.copyWith(
                                    fontSize: theme
                                            .textTheme.displayLarge!.fontSize! -
                                        4,
                                    color: theme.textTheme.displaySmall!.color),
                              ),
                              const SizedBox(
                                height: kDefaultSpacing,
                              ),
                            ],
                          )
                        : const SizedBox(),
                    Text(
                      widget.data.text ?? "",
                      style: theme.textTheme.displayLarge!
                          .copyWith(fontWeight: FontWeight.w400, height: 1.8),
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
