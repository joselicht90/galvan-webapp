
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'galvan_style_constants.dart';

ThemeData appTheme = ThemeData(
  visualDensity: VisualDensity.standard,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: GalvanColors.mainGreen,
    onPrimary: GalvanColors.mainGalvan,
    secondary: GalvanColors.mainPurple,
    onSecondary: GalvanColors.mainGalvan,
    error: GalvanColors.lightRed,
    onError: GalvanColors.black,
    surface: GalvanColors.lightGalvan,
    onSurface: GalvanColors.white,
    onSurfaceVariant: GalvanColors.mediumGray,
    surfaceTint: GalvanColors.transparent,
  ),
  cardTheme: CardThemeData(
    color: GalvanColors.darkGalvan,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(GalvanValues.cardBorderRadius),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: const WidgetStatePropertyAll(GalvanColors.mainGreen),
    checkColor: const WidgetStatePropertyAll(GalvanColors.mainGalvan),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(GalvanValues.checkBoxBorderRadius),
    ),
    side: const BorderSide(color: GalvanColors.mainGreen),
  ),
  scaffoldBackgroundColor: GalvanColors.mainGalvan,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: GalvanColors.mainGalvan,
    selectedItemColor: GalvanColors.galvanPlusPrimary,
    unselectedItemColor: GalvanColors.white,
    unselectedIconTheme: IconThemeData(color: GalvanColors.white),
    selectedIconTheme: IconThemeData(color: GalvanColors.galvanPlusPrimary),
    selectedLabelStyle: GoogleFonts.lato(),
    unselectedLabelStyle: GoogleFonts.lato(),
  ),
  appBarTheme: const AppBarTheme(backgroundColor: GalvanColors.transparent, elevation: 0),
  textTheme: GoogleFonts.latoTextTheme().copyWith(

    displayLarge: TextStyle(
      fontFamily: GalvanValues.appFontName,
      fontWeight: GalvanValues.boldFontWeight,
    ),
    displayMedium: TextStyle(
      fontFamily: GalvanValues.appFontName,
      fontWeight: GalvanValues.boldFontWeight,
    ),
    displaySmall: TextStyle(
      fontFamily: GalvanValues.appFontName,
      fontWeight: GalvanValues.boldFontWeight,
    ),
    headlineMedium: GoogleFonts.lato(
      fontWeight: GalvanValues.lightBoldFontWeight,
    ),
    headlineSmall: TextStyle(
      fontWeight: GalvanValues.lightFontWeight,
      fontFamily: GalvanValues.appFontName,
    ),
    titleLarge: GoogleFonts.lato(
      fontWeight: GalvanValues.normalFontWeight,
      color: GalvanColors.white,
    ),
    titleMedium: GoogleFonts.lato(
      fontWeight: GalvanValues.normalFontWeight,
      color: GalvanColors.white,
    ),
    bodyLarge: GoogleFonts.lato(
      fontWeight: GalvanValues.normalFontWeight,
    ),
    bodyMedium: GoogleFonts.lato(
      fontWeight: GalvanValues.normalFontWeight,
    ),
    bodySmall: GoogleFonts.lato(
      fontWeight: GalvanValues.normalFontWeight,
      color: GalvanColors.white,
    ),
    headlineLarge: TextStyle(
      fontFamily: GalvanFonts.gilroy,
      fontWeight: FontWeight.w300,
      color: GalvanColors.white,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: GalvanColors.mainTurqz),
  elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonStyle()),
  outlinedButtonTheme: OutlinedButtonThemeData(style: outlinedButtonStyle()),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: GalvanValues.inputHorizontalPadding,
      vertical: GalvanValues.inputVerticalPadding,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(GalvanValues.defaultBorderRadius),
      borderSide: const BorderSide(
        color: GalvanColors.white,
        width: GalvanValues.defaultBorderWidth,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(GalvanValues.defaultBorderRadius),
      borderSide: const BorderSide(
        color: GalvanColors.white,
        width: GalvanValues.defaultBorderWidth,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(GalvanValues.defaultBorderRadius),
      borderSide: const BorderSide(
        color: GalvanColors.mainGreen,
        width: GalvanValues.defaultBorderWidth,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(GalvanValues.defaultBorderRadius),
      borderSide: const BorderSide(
        color: GalvanColors.lightRed,
        width: GalvanValues.defaultBorderWidth,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStateProperty.all(
        GoogleFonts.lato().copyWith(
          fontWeight: GalvanValues.normalFontWeight,
        ),
      ),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return GalvanColors.mainGreen;
        }
        return GalvanColors.white;
      }),
    ),
  ),
  dividerTheme: DividerThemeData(color: GalvanColors.darkGalvan, thickness: 3), dialogTheme: DialogThemeData(backgroundColor: GalvanColors.darkGalvan),
);

ButtonStyle cupertinoTextButtonDoneStyle() {
  final style = TextButton.styleFrom(
    foregroundColor: GalvanColors.mainGreen,
    textStyle: GoogleFonts.lato().copyWith(
      fontWeight: GalvanValues.normalFontWeight,
    ),
  );

  return style;
}

ButtonStyle secondaryElevatedButtonStyle() {
  OutlinedBorder? getBorder(bool isDisabled) => isDisabled
      ? null
      : RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(GalvanValues.defaultBorderRadius),
    side: const BorderSide(
      color: GalvanColors.mainGreen,
      width: GalvanValues.defaultBorderWidth,
    ),
  );

  final style = ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(GalvanValues.elevatedButtonPadding),
    shape: getBorder(false),
    foregroundColor: GalvanColors.mainGreen,
    backgroundColor: GalvanColors.transparent,
    elevation: 0,
    textStyle: GoogleFonts.lato(
      textStyle: TextStyle(
        fontWeight: GalvanValues.lightBoldFontWeight,
      ),
    ),
  );

  return style.copyWith(
    shape: WidgetStateProperty.resolveWith<OutlinedBorder?>(
          (states) => getBorder(states.contains(WidgetState.disabled)),
    ),
  );
}

ButtonStyle linkDeviceButtonStyle() {
  OutlinedBorder? getBorder(bool isDisabled) => isDisabled
      ? null
      : RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(GalvanValues.defaultBorderRadius),
    side: BorderSide(
      color: GalvanColors.white.withValues(alpha: 0.15),
      width: GalvanValues.defaultBorderWidth,
    ),
  );

  final style = ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(GalvanValues.elevatedButtonPadding),
    shape: getBorder(false),
    foregroundColor: GalvanColors.lightRed,
    backgroundColor: GalvanColors.white.withValues(alpha: 0.15),
    visualDensity: VisualDensity.compact,
    elevation: 0,
    textStyle: GoogleFonts.lato(
      textStyle: TextStyle(
        fontWeight: GalvanValues.lightBoldFontWeight,
      ),
    ),
  );

  return style.copyWith(
    shape: WidgetStateProperty.resolveWith<OutlinedBorder?>(
          (states) => getBorder(states.contains(WidgetState.disabled)),
    ),
  );
}

ButtonStyle wellnessHomeButtonStyle() {
  OutlinedBorder? getBorder(bool isDisabled) => isDisabled
      ? null
      : RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(GalvanValues.defaultBorderRadius),
    side: BorderSide(
      color: GalvanColors.white.withValues(alpha: 0.15),
      width: GalvanValues.defaultBorderWidth,
    ),
  );

  final style = ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(GalvanValues.elevatedButtonPadding),
    shape: getBorder(false),
    foregroundColor: GalvanColors.lightTurqz,
    backgroundColor: GalvanColors.white.withValues(alpha: 0.15),
    visualDensity: VisualDensity.compact,
    elevation: 0,
    textStyle: GoogleFonts.lato(
      textStyle: TextStyle(
        fontWeight: GalvanValues.lightBoldFontWeight,
      ),
    ),
  );

  return style.copyWith(
    shape: WidgetStateProperty.resolveWith<OutlinedBorder?>(
          (states) => getBorder(states.contains(WidgetState.disabled)),
    ),
  );
}

ButtonStyle randomNowWhatButtonStyle() {
  OutlinedBorder? getBorder(bool isDisabled) => isDisabled
      ? RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(GalvanValues.defaultBorderRadius),
    side: BorderSide(
      color: GalvanColors.energyStart.withValues(alpha: 0.15),
      width: GalvanValues.defaultBorderWidth,
    ),
  )
      : RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(GalvanValues.defaultBorderRadius),
    side: BorderSide(color: GalvanColors.energyEnd, width: GalvanValues.defaultBorderWidth),
  );

  final style = ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(GalvanValues.elevatedButtonPadding),
    shape: getBorder(false),
    foregroundColor: GalvanColors.energyEnd,
    backgroundColor: GalvanColors.energyStart.withValues(alpha: 0.15),
    visualDensity: VisualDensity.compact,
    elevation: 0,
    disabledBackgroundColor: GalvanColors.energyStart.withValues(alpha: 0.1),
    disabledForegroundColor: GalvanColors.energyEnd.withValues(alpha: 0.4),
    textStyle: GoogleFonts.lato(
      textStyle: TextStyle(
        fontWeight: GalvanValues.lightBoldFontWeight,
      ),
    ),
  );

  return style.copyWith(
    shape: WidgetStateProperty.resolveWith<OutlinedBorder?>(
          (states) => getBorder(states.contains(WidgetState.disabled)),
    ),
  );
}

ButtonStyle randomNowWhatButtonStyleSecondary() {
  OutlinedBorder? getBorder(bool isDisabled) => isDisabled
      ? RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(GalvanValues.defaultBorderRadius),
    side: BorderSide(
      color: GalvanColors.moodStart.withValues(alpha: 0.15),
      width: GalvanValues.defaultBorderWidth,
    ),
  )
      : RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(GalvanValues.defaultBorderRadius),
    side: BorderSide(color: GalvanColors.moodEnd, width: GalvanValues.defaultBorderWidth),
  );

  final style = ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(GalvanValues.elevatedButtonPadding),
    shape: getBorder(false),
    foregroundColor: GalvanColors.moodEnd,
    backgroundColor: GalvanColors.moodStart.withValues(alpha: 0.15),
    visualDensity: VisualDensity.compact,
    elevation: 0,
    disabledBackgroundColor: GalvanColors.moodStart.withValues(alpha: 0.1),
    disabledForegroundColor: GalvanColors.moodEnd.withValues(alpha: 0.4),
    textStyle: GoogleFonts.lato(
      textStyle: TextStyle(
        fontWeight: GalvanValues.lightBoldFontWeight,
      ),
    ),
  );

  return style.copyWith(
    shape: WidgetStateProperty.resolveWith<OutlinedBorder?>(
          (states) => getBorder(states.contains(WidgetState.disabled)),
    ),
  );
}

ButtonStyle randomNowWhatButtonStyleTerciary() {
  OutlinedBorder? getBorder(bool isDisabled) => isDisabled
      ? RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(GalvanValues.defaultBorderRadius),
    side: BorderSide(
      color: GalvanColors.stressStart.withValues(alpha: 0.15),
      width: GalvanValues.defaultBorderWidth,
    ),
  )
      : RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(GalvanValues.defaultBorderRadius),
    side: BorderSide(color: GalvanColors.stressEnd, width: GalvanValues.defaultBorderWidth),
  );

  final style = ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(GalvanValues.elevatedButtonPadding),
    shape: getBorder(false),
    foregroundColor: GalvanColors.stressEnd,
    backgroundColor: GalvanColors.stressStart.withValues(alpha: 0.15),
    visualDensity: VisualDensity.compact,
    elevation: 0,
    disabledBackgroundColor: GalvanColors.stressStart.withValues(alpha: 0.1),
    disabledForegroundColor: GalvanColors.stressEnd.withValues(alpha: 0.4),
    textStyle: GoogleFonts.lato(
      textStyle: TextStyle(
        fontWeight: GalvanValues.lightBoldFontWeight,
      ),
    ),
  );

  return style.copyWith(
    shape: WidgetStateProperty.resolveWith<OutlinedBorder?>(
          (states) => getBorder(states.contains(WidgetState.disabled)),
    ),
  );
}

ButtonStyle elevatedButtonStyle() {
  OutlinedBorder? getBorder(bool isDisabled) => isDisabled
      ? null
      : RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(GalvanValues.defaultBorderRadius),
    side: const BorderSide(color: Colors.transparent, width: GalvanValues.defaultBorderWidth),
  );

  final style = ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(GalvanValues.elevatedButtonPadding),
    backgroundColor: GalvanColors.mainGreen,
    foregroundColor: GalvanColors.mainGalvan,
    surfaceTintColor: GalvanColors.transparent,
    textStyle: GoogleFonts.lato(
      textStyle: TextStyle(
        fontWeight: GalvanValues.lightBoldFontWeight,
      ),
    ),
  );

  return style.copyWith(
    shape: WidgetStateProperty.resolveWith<OutlinedBorder?>(
          (states) => getBorder(states.contains(WidgetState.disabled)),
    ),
  );
}

ButtonStyle outlinedButtonStyle() {
  return ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(GalvanValues.elevatedButtonPadding),
    foregroundColor: GalvanColors.mainGreen,
    side: const BorderSide(color: GalvanColors.mainGreen),
    textStyle: GoogleFonts.lato(
      textStyle: TextStyle(
        fontWeight: GalvanValues.lightBoldFontWeight,
      ),
    ),
  );
}

ButtonStyle outlinedCanaryButtonStyle() {
  return ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(GalvanValues.elevatedButtonPadding),
    foregroundColor: GalvanColors.lightTurqz,
    backgroundColor: GalvanColors.transparent,
    elevation: 0,
    side: const BorderSide(color: GalvanColors.lightTurqz),
    textStyle: GoogleFonts.lato(
      textStyle: TextStyle(
        fontWeight: GalvanValues.lightBoldFontWeight,
      ),
    ),
  );
}

ButtonStyle outlinedChallengesButtonStyle() {
  return ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(GalvanValues.elevatedButtonPadding),
    foregroundColor: GalvanColors.lightestGalvan,
    backgroundColor: GalvanColors.transparent,
    elevation: 0,
    side: const BorderSide(color: GalvanColors.lightestGalvan),
    textStyle: GoogleFonts.lato(
      textStyle: TextStyle(
        fontWeight: GalvanValues.lightBoldFontWeight,
      ),
    ),
  );
}

ButtonStyle challengesButtonPrimaryStyle() {
  OutlinedBorder? getBorder(bool isDisabled) => isDisabled
      ? null
      : RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(GalvanValues.defaultBorderRadius),
    side: const BorderSide(
      color: GalvanColors.transparent,
      width: GalvanValues.defaultBorderWidth,
    ),
  );

  final style = ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(GalvanValues.elevatedButtonPadding),
    shape: getBorder(false),
    foregroundColor: GalvanColors.white,
    backgroundColor: GalvanColors.lightestGalvan,
    elevation: 0,
    textStyle: GoogleFonts.lato(
      textStyle: TextStyle(
        fontWeight: GalvanValues.lightBoldFontWeight,
      ),
    ),
  );

  return style.copyWith(
    shape: WidgetStateProperty.resolveWith<OutlinedBorder?>(
          (states) => getBorder(states.contains(WidgetState.disabled)),
    ),
  );
}

InputDecoration vitalsDropdownDecoration(BuildContext context, String label, Color color) {
  return InputDecoration(
    iconColor: GalvanColors.white,
    suffixIconColor: GalvanColors.white,
    isDense: true,
    fillColor: color.withValues(alpha: 0.4),
    filled: true,
    //hintText: label,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.transparent, width: 0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.transparent, width: 0),
    ),
    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: GalvanColors.mainRed, width: 1)),
  );
}

InputDecorationTheme vitalsDropdownDecorationThemData(
    BuildContext context,
    String label,
    Color color,
    ) {
  return InputDecorationTheme(
    iconColor: GalvanColors.white,
    suffixIconColor: GalvanColors.white,
    //labelText: label,
    labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: GalvanColors.mediumGray),
    //hintText: label,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color, width: 1),
    ),
    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: GalvanColors.mainRed, width: 1)),
  );
}

CheckboxThemeData checkboxThemeData = CheckboxThemeData(
  fillColor: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return GalvanColors.white;
    }
    if (states.contains(WidgetState.selected)) {
      return GalvanColors.mainGreen;
    }
    return GalvanColors.transparent;
  }),
  // ignore: deprecated_member_use
  checkColor: const MaterialStatePropertyAll(GalvanColors.mainGalvan),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(GalvanValues.checkBoxBorderRadius),
  ),
  side: const BorderSide(color: GalvanColors.mainGreen),
);

CheckboxThemeData turqzCheckboxThemeData = CheckboxThemeData(
  fillColor: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return GalvanColors.white;
    }
    if (states.contains(WidgetState.selected)) {
      return GalvanColors.mainTurqz;
    }
    return GalvanColors.transparent;
  }),
  checkColor: const WidgetStatePropertyAll(GalvanColors.mainGalvan),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(GalvanValues.checkBoxBorderRadius),
  ),
  side: const BorderSide(color: GalvanColors.mainTurqz),
);
