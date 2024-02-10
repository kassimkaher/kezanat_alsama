import 'package:flutter/material.dart';
import 'package:ramadan/utils/utils.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton(
      {Key? key,
      this.selectOptional,
      required this.option1,
      required this.option2,
      this.title,
      this.errorMessage,
      required this.onChange,
      required this.isReadOnly,
      this.titleStyle,
      this.titlePadding,
      this.icon})
      : super(key: key);
  final Enum option1;
  final Enum option2;
  final Enum? selectOptional;
  final Function(Enum value) onChange;
  final String? title;
  final String? errorMessage;

  final bool isReadOnly;
  final TextStyle? titleStyle;
  final Widget? icon;
  final EdgeInsetsGeometry? titlePadding;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FormField<String>(
      enabled: isReadOnly,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: selectOptional?.name,
      validator: (value) {
        if ((value?.isNotEmpty ?? false)) {
          return null;
        }

        return errorMessage ?? "";
      },
      builder: (state) {
        if (selectOptional != null) {
          // ignore: invalid_use_of_protected_member
          state.setValue(selectOptional?.name);
          state.validate();
        }
        return ListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          title: title == null
              ? null
              : Padding(
                  padding: titlePadding ?? EdgeInsets.zero,
                  child: Row(
                    children: [
                      icon ?? const SizedBox(),
                      icon != null
                          ? const SizedBox(width: 5)
                          : const SizedBox(),
                      Text(
                        title ?? "",
                        style: titleStyle ?? theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: title != null ? 8 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: isReadOnly
                            ? null
                            : () {
                                state.didChange(option1.name);
                                state.validate();
                                onChange(option1);
                              },
                        child: Container(
                          height: 58,
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultSpacing),
                          decoration: BoxDecoration(
                            border: isReadOnly
                                ? Border.all(color: jbGary2)
                                : state.hasError
                                    ? Border.all(color: Colors.red)
                                    : null,
                            color: isReadOnly
                                ? Colors.transparent
                                : theme.scaffoldBackgroundColor,
                            borderRadius:
                                BorderRadius.circular(kDefaultBorderRadius),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                selectOptional == option1
                                    ? Icons.check_circle
                                    : Icons.circle_outlined,
                                color: selectOptional == option1
                                    ? isReadOnly
                                        ? jbBorderColor
                                        : Colors.green
                                    : theme.colorScheme.outline,
                              ),
                              const SizedBox(width: kDefaultSpacing),
                              Text(
                                option1.name.tr(),
                                style: theme.textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: kDefaultSpacing),
                    Expanded(
                      child: InkWell(
                        onTap: isReadOnly
                            ? null
                            : () {
                                state.didChange(option2.name);
                                state.validate();
                                onChange(option2);
                              },
                        child: Container(
                          height: 58,
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultSpacing),
                          decoration: BoxDecoration(
                            color: isReadOnly
                                ? Colors.transparent
                                : theme.scaffoldBackgroundColor,
                            borderRadius:
                                BorderRadius.circular(kDefaultBorderRadius),
                            border: isReadOnly
                                ? Border.all(color: jbGary2)
                                : state.hasError
                                    ? Border.all(color: Colors.red)
                                    : null,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                selectOptional != null &&
                                        selectOptional! == option2
                                    ? Icons.check_circle
                                    : Icons.circle_outlined,
                                color: selectOptional != null &&
                                        selectOptional! == option2
                                    ? isReadOnly
                                        ? jbBorderColor
                                        : Colors.green
                                    : theme.colorScheme.outline,
                              ),
                              const SizedBox(width: kDefaultSpacing),
                              Text(
                                option2.name.tr(),
                                style: theme.textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  child: !state.isValid && state.errorText != null
                      ? Padding(
                          padding: const EdgeInsets.only(
                              top: 8,
                              left: kDefaultPadding,
                              right: kDefaultPadding),
                          child: Text(
                            state.errorText ?? "",
                            style: theme.textTheme.bodySmall
                                ?.copyWith(color: Colors.red),
                            textAlign: TextAlign.start,
                          ),
                        )
                      : const SizedBox(),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
