import 'package:flutter/material.dart';
import 'package:ramadan/utils/utils.dart';

String priceF(String price) {
  if (price.length > 2) {
    var value = price;
    value = value.replaceAll(RegExp(r'\D'), '');
    value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
    return value;
  }
  return price;
}

showDateChooser(
    BuildContext context, Function(DateTime? dateTime) onSelect) async {
  final date = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1999),
    lastDate: DateTime.now(),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: jbPrimaryColor, // header background color
            onPrimary: Colors.white, // header text color
            onSurface: jbPrimaryColor, // body text color
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: jbSecondary, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  );

  onSelect(date);
}

showTimeChooser(
    BuildContext context, Function(TimeOfDay? dateTime) onSelect) async {
  final date = await showTimePicker(
    context: context,
    initialTime: const TimeOfDay(hour: 8, minute: 0),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: jbPrimaryColor, // header background color
            onPrimary: Colors.white, // header text color
            onSurface: jbPrimaryColor, // body text color
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: jbSecondary, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  );

  onSelect(date);
}

showDateExpireChooser(
  BuildContext context,
  Function(DateTime? dateTime) onSelect,
) async {
  final date = await showDatePicker(
    context: context,
    initialDate: DateTime.now().add(const Duration(days: 1)),
    firstDate: DateTime.now().add(const Duration(days: 1)),
    lastDate: DateTime(
        DateTime.now().year, DateTime.now().month + 2, DateTime.now().day),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: jbPrimaryColor, // header background color
            onPrimary: Colors.white, // header text color
            onSurface: jbPrimaryColor, // body text color
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: jbSecondary, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  );

  onSelect(date);
}
