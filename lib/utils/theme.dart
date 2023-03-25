import 'package:flutter/material.dart';
import 'package:ramadan/utils/utils.dart';

getTheme(String fontfamily, bool isDarkMode) {
  final theme = ThemeData(
    primarySwatch: createMaterialColor(jbPrimaryColor),
    fontFamily: fontfamily,
  );

  return isDarkMode
      ? theme.copyWith(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(),
          cardTheme: CardTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kDefaultBorderRadius),
              ),
              color: Color(0xff0c0c0c)),
          scaffoldBackgroundColor: scaffoldColorD,
          brightness: Brightness.dark,
          disabledColor: jbUnselectColor,
          colorScheme: const ColorScheme.dark(
              secondary: jbSecondaryD,
              primary: jbPrimaryColorD,
              outline: jbBorderColorD,
              tertiary: Colors.red,
              onSecondary: jbAccentSecondary,
              onPrimary: jbAccesntPrimaryColorD),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
                fontSize: 22,
                color: jbFontColorD,
                fontWeight: FontWeight.w500,
                fontFamily: 'Somar'),
          ),
          cardColor: Colors.black,
          dialogTheme: DialogTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kDefaultBorderRadius),
            ),
          ),
          iconTheme: const IconThemeData(color: jbFontColor),
          textTheme: theme.textTheme.copyWith(
            titleLarge: theme.textTheme.titleLarge?.copyWith(
                fontSize: 22, color: jbFontColorD, fontWeight: FontWeight.w500),
            titleMedium: theme.textTheme.titleMedium
                ?.copyWith(color: jbFontColorD, fontSize: 18),
            titleSmall: theme.textTheme.titleSmall
                ?.copyWith(color: jbFontColorD, fontSize: 16),
            bodyLarge: theme.textTheme.bodyLarge?.copyWith(
                color: jbFontColor2D,
                fontSize: 16,
                fontWeight: FontWeight.w600),
            bodyMedium: theme.textTheme.bodyMedium
                ?.copyWith(color: jbFontColorD, fontSize: 14),
            bodySmall: theme.textTheme.bodySmall
                ?.copyWith(color: jbFontColor2D, fontSize: 14),
            displaySmall: theme.textTheme.displaySmall
                ?.copyWith(color: jbDisableTextColorD, fontSize: 12),
            displayLarge: theme.textTheme.displayLarge?.copyWith(
              color: jbFontColorD,
              fontSize: 28,
              fontFamily: 'Am',
            ),
            displayMedium: theme.textTheme.displayLarge?.copyWith(
              color: jbFontColorD,
              fontSize: 60,
              fontFamily: 'Kufy',
            ),
          ),
          splashColor: Colors.transparent,
          highlightColor: const Color(0x11440099),
        )
      // theme style if light mode

      : theme.copyWith(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(),
          cardTheme: CardTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kDefaultBorderRadius),
            ),
            color: Colors.white,
          ),
          scaffoldBackgroundColor: scaffoldColor,
          brightness: Brightness.light,
          colorScheme: const ColorScheme.dark(
              secondary: jbSecondary,
              primary: jbPrimaryColor,
              outline: jbBorderColor,
              tertiary: Colors.red,
              onSecondary: jbAccentSecondary,
              onPrimary: jbAccesntPrimaryColor),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
                fontSize: 22,
                color: jbFontColor,
                fontWeight: FontWeight.w500,
                fontFamily: 'Somar'),
          ),
          cardColor: Colors.white,
          dialogTheme: DialogTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kDefaultBorderRadius),
            ),
          ),
          iconTheme: const IconThemeData(color: jbFontColor),
          textTheme: theme.textTheme.copyWith(
            titleLarge: theme.textTheme.titleLarge?.copyWith(
                fontSize: 22, color: jbFontColor, fontWeight: FontWeight.w500),
            titleMedium: theme.textTheme.titleMedium
                ?.copyWith(color: jbFontColor, fontSize: 18),
            titleSmall: theme.textTheme.titleSmall
                ?.copyWith(color: jbFontColor, fontSize: 16),
            bodyLarge: theme.textTheme.bodyLarge?.copyWith(
                color: jbFontColor2, fontSize: 16, fontWeight: FontWeight.w600),
            bodyMedium: theme.textTheme.bodyMedium
                ?.copyWith(color: jbFontColor, fontSize: 14),
            bodySmall: theme.textTheme.bodySmall
                ?.copyWith(color: jbFontColor2, fontSize: 14),
            displaySmall: theme.textTheme.displaySmall
                ?.copyWith(color: jbDisableTextColor, fontSize: 12),
            displayLarge: theme.textTheme.displayLarge?.copyWith(
              color: jbFontColor,
              fontSize: 28,
              fontFamily: 'Am',
            ),
            displayMedium: theme.textTheme.displayLarge?.copyWith(
              color: jbFontColor,
              fontSize: 60,
              fontFamily: 'Kufy',
            ),
          ),
          splashColor: Colors.transparent,
          highlightColor: const Color(0x11440099),
        );
}
