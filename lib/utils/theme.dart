import 'package:ramadan/utils/utils.dart';

getTheme(String fontfamily, bool isDarkMode) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarBrightness: !isDarkMode ? Brightness.light : Brightness.dark,
    statusBarColor: !isDarkMode ? scaffoldColor : scaffoldColorD,
    systemNavigationBarColor: isDarkMode ? cardColorD : cardColor,
    systemNavigationBarIconBrightness:
        isDarkMode ? Brightness.light : Brightness.dark,
  ));
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //     overlays: [SystemUiOverlay.top]);
  final theme = ThemeData(
    useMaterial3: false,
    primarySwatch:
        createMaterialColor(isDarkMode ? jbPrimaryColor : jbPrimaryColor),
    fontFamily: fontfamily,
  );

  return isDarkMode
      ? theme.copyWith(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
          cardTheme: CardTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                  side: const BorderSide(color: alqadrAccesntColor)),
              color: scaffoldColorD,
              elevation: 0),
          scaffoldBackgroundColor: scaffoldColorD,
          primaryColorDark: Colors.white70,
          brightness: Brightness.dark,
          disabledColor: jbUnselectColorD,
          canvasColor: cardColorD,
          colorScheme: const ColorScheme.dark(
              secondary: jbSecondaryD,
              primary: jbPrimaryColorD,
              outline: jbBorderColorD,
              tertiary: Color(0xff4f6d7a),
              tertiaryContainer: alqadrAccesntColor,
              onTertiary: alqadrColor,
              onSecondary: jbAccentSecondary,
              onPrimary: jbAccesntPrimaryColorD),
          appBarTheme: const AppBarTheme(
            backgroundColor: cardColorD,
            elevation: 0,
            titleTextStyle: TextStyle(
                fontSize: 22,
                color: jbAccesntPrimaryColorD,
                fontWeight: FontWeight.w500,
                fontFamily: 'Somar'),
          ),
          cardColor: cardColorD,
          dialogTheme: DialogTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kDefaultBorderRadius),
            ),
          ),
          iconTheme: const IconThemeData(color: jbAccesntPrimaryColorD),
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
                fontWeight: FontWeight.w500),
            bodyMedium: theme.textTheme.bodyMedium
                ?.copyWith(color: jbFontColor2D, fontSize: 14),
            bodySmall: theme.textTheme.bodySmall
                ?.copyWith(color: jbFontColor2D, fontSize: 14),
            displaySmall: theme.textTheme.displaySmall
                ?.copyWith(color: jbDisableTextColorD, fontSize: 12),
            displayLarge: theme.textTheme.displayLarge?.copyWith(
                color: jbFontColorD,
                fontSize: 28,
                fontFamily: 'Am',
                wordSpacing: 0.6,
                letterSpacing: 0.4),
            displayMedium: theme.textTheme.displayLarge?.copyWith(
              color: jbAccesntPrimaryColorD,
              fontSize: 60,
              fontFamily: 'Kufy',
            ),
          ),
          splashColor: Colors.transparent,
          highlightColor: const Color(0x11440099),
        )
      : theme.copyWith(
          cardTheme: CardTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                side: BorderSide(color: Colors.grey.shade400),
              ),
              color: Colors.white,
              elevation: 0),
          scaffoldBackgroundColor: scaffoldColor,
          primaryColorDark: jbAccesntPrimaryColor,
          brightness: Brightness.light,
          colorScheme: const ColorScheme.dark(
              secondary: jbSecondary,
              primary: jbPrimaryColor,
              outline: jbGary2,
              tertiary: Color(0xff4f6d7a),
              tertiaryContainer: jbPrimaryColor,
              onTertiary: Color(0xff0C7E82),
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
          disabledColor: jbUnselectColor,
          cardColor: cardColor,
          canvasColor: Colors.white,
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
                color: jbFontColor2, fontSize: 16, fontWeight: FontWeight.w500),
            bodyMedium: theme.textTheme.bodyMedium
                ?.copyWith(color: jbFontColor, fontSize: 14),
            bodySmall: theme.textTheme.bodySmall
                ?.copyWith(color: jbFontColor2, fontSize: 14),
            displaySmall: theme.textTheme.displaySmall
                ?.copyWith(color: jbDisableTextColor, fontSize: 12),
            displayLarge: theme.textTheme.displayLarge?.copyWith(
                color: jbFontColor,
                fontSize: 26,
                fontFamily: 'Am',
                wordSpacing: 0.6,
                letterSpacing: 0.2),
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
