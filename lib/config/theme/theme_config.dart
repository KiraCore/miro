import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class ThemeConfig {
  static ThemeData buildTheme({required bool isSmallScreen}) {
    final ThemeData themeData = ThemeData.dark();

    return themeData.copyWith(
      colorScheme: const ColorScheme.dark(background: DesignColors.background),
      canvasColor: DesignColors.background,
      scaffoldBackgroundColor: DesignColors.background,
      elevatedButtonTheme: _buildElevatedButtonThemeData(themeData.elevatedButtonTheme),
      outlinedButtonTheme: _buildOutlinedButtonThemeData(themeData.outlinedButtonTheme),
      textButtonTheme: _buildTextButtonThemeData(themeData.textButtonTheme),
      iconTheme: _buildIconThemeData(themeData.iconTheme),
      inputDecorationTheme: _buildInputDecorationTheme(themeData.inputDecorationTheme),
      textSelectionTheme: _buildTextSelectionThemeData(themeData.textSelectionTheme),
      textTheme: isSmallScreen ? _buildSmallScreenTextTheme(themeData.textTheme) : _buildLargeScreenTextTheme(themeData.textTheme),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonThemeData(ElevatedButtonThemeData elevatedButtonThemeData) {
    return ElevatedButtonThemeData(
      style: (elevatedButtonThemeData.style ?? const ButtonStyle()).copyWith(
        foregroundColor: MaterialStateProperty.all(DesignColors.white1),
        backgroundColor: MaterialStateProperty.all(DesignColors.grey3),
        padding: MaterialStateProperty.all(const EdgeInsets.all(10.0)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonThemeData(OutlinedButtonThemeData baseOutlinedButtonThemeData) {
    return OutlinedButtonThemeData(
      style: (baseOutlinedButtonThemeData.style ?? const ButtonStyle()).copyWith(
        foregroundColor: MaterialStateProperty.resolveWith(_selectOutlinedButtonFontColor),
        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 12, color: DesignColors.white1)),
        padding: MaterialStateProperty.all(const EdgeInsets.all(10.0)),
        shape: MaterialStateProperty.resolveWith(_selectOutlinedButtonShape),
      ),
    );
  }

  static Color _selectOutlinedButtonFontColor(Set<MaterialState> states) {
    Color fontColor = DesignColors.white1;
    if (states.contains(MaterialState.disabled)) {
      fontColor = DesignColors.grey2;
    }
    return fontColor;
  }

  static OutlinedBorder _selectOutlinedButtonShape(Set<MaterialState> states) {
    Color borderColor = DesignColors.white1;
    if (states.contains(MaterialState.hovered) || states.contains(MaterialState.pressed)) {
      borderColor = DesignColors.white2;
    }
    return RoundedRectangleBorder(
      side: BorderSide(
        color: borderColor,
      ),
      borderRadius: BorderRadius.circular(4),
    );
  }

  static TextButtonThemeData _buildTextButtonThemeData(TextButtonThemeData baseTextButtonThemeData) {
    return TextButtonThemeData(
      style: (baseTextButtonThemeData.style ?? const ButtonStyle()).copyWith(
        foregroundColor: MaterialStateProperty.resolveWith(_selectTextButtonFontColor),
      ),
    );
  }

  static Color _selectTextButtonFontColor(Set<MaterialState> states) {
    Color fontColor = DesignColors.white1;
    if (states.contains(MaterialState.disabled)) {
      fontColor = DesignColors.grey2;
    }
    if (states.contains(MaterialState.hovered)) {
      fontColor = DesignColors.white1;
    }
    return fontColor;
  }

  static IconThemeData _buildIconThemeData(IconThemeData baseIconThemeData) {
    return baseIconThemeData.copyWith(
      color: DesignColors.white1,
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme(InputDecorationTheme baseInputDecorationTheme) {
    InputBorder defaultInputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: DesignColors.accent),
      borderRadius: BorderRadius.circular(4),
    );

    return baseInputDecorationTheme.copyWith(
      border: defaultInputBorder,
      errorBorder: defaultInputBorder,
      focusedBorder: defaultInputBorder,
      focusedErrorBorder: defaultInputBorder,
      disabledBorder: defaultInputBorder,
      enabledBorder: defaultInputBorder,
      contentPadding: const EdgeInsets.all(10.0),
      suffixStyle: const TextStyle(fontWeight: FontWeight.w400, color: DesignColors.accent),
      prefixStyle: const TextStyle(fontWeight: FontWeight.w400, color: DesignColors.accent),
      labelStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: DesignColors.accent),
      hintStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: DesignColors.accent),
    );
  }

  static TextSelectionThemeData _buildTextSelectionThemeData(TextSelectionThemeData baseTextSelectionThemeData) {
    return baseTextSelectionThemeData.copyWith(
      cursorColor: DesignColors.white2,
      selectionColor: DesignColors.grey2,
    );
  }

  static TextTheme _buildSmallScreenTextTheme(TextTheme baseTextTheme) {
    final TextTheme textTheme = baseTextTheme.apply(fontFamily: 'Inter');

    return textTheme.copyWith(
      displayLarge: textTheme.displayLarge!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 25,
      ),
      displayMedium: textTheme.displayMedium!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 23,
      ),
      displaySmall: textTheme.displaySmall!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 20,
        letterSpacing: 0.5,
      ),
      headlineMedium: textTheme.headlineMedium!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        letterSpacing: 0.5,
      ),
      titleMedium: textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        letterSpacing: 0.5,
      ),
      titleSmall: textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      bodyLarge: textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      bodyMedium: textTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 13,
      ),
      bodySmall: textTheme.bodySmall!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 11,
      ),
      labelLarge: textTheme.labelLarge!.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 11,
        letterSpacing: 0.4,
      ),
    );
  }

  static TextTheme _buildLargeScreenTextTheme(TextTheme baseTextTheme) {
    final TextTheme textTheme = baseTextTheme.apply(fontFamily: 'Inter');

    return textTheme.copyWith(
      displayLarge: textTheme.displayLarge!.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 32,
      ),
      displayMedium: textTheme.displayMedium!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 26,
      ),
      displaySmall: textTheme.displaySmall!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 24,
        letterSpacing: 0.5,
      ),
      headlineMedium: textTheme.headlineMedium!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 22,
        letterSpacing: 0.5,
      ),
      titleMedium: textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        letterSpacing: 0.5,
      ),
      titleSmall: textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        letterSpacing: 0.5,
      ),
      bodyLarge: textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      bodyMedium: textTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      bodySmall: textTheme.bodySmall!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
      labelLarge: textTheme.labelLarge!.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 12,
        letterSpacing: 0.4,
      ),
    );
  }
}
