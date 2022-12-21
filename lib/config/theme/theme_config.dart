import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class ThemeConfig {
  static ThemeData buildTheme({required bool isSmallScreen}) {
    final ThemeData themeData = ThemeData.dark();

    return themeData.copyWith(
      colorScheme: const ColorScheme.dark(),
      backgroundColor: DesignColors.gray1_100,
      canvasColor: DesignColors.gray1_100,
      scaffoldBackgroundColor: DesignColors.gray1_100,
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
        foregroundColor: MaterialStateProperty.all(const Color(0xFFFFFFFF)),
        padding: MaterialStateProperty.all(const EdgeInsets.all(10.0)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonThemeData(OutlinedButtonThemeData baseOutlinedButtonThemeData) {
    return OutlinedButtonThemeData(
      style: (baseOutlinedButtonThemeData.style ?? const ButtonStyle()).copyWith(
        foregroundColor: MaterialStateProperty.resolveWith(_selectOutlinedButtonFontColor),
        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 12, color: DesignColors.white_100)),
        padding: MaterialStateProperty.all(const EdgeInsets.all(10.0)),
        shape: MaterialStateProperty.resolveWith(_selectOutlinedButtonShape),
      ),
    );
  }

  static Color _selectOutlinedButtonFontColor(Set<MaterialState> states) {
    Color fontColor = DesignColors.white_100;
    if (states.contains(MaterialState.disabled)) {
      fontColor = const Color(0xFF50525C);
    }
    return fontColor;
  }

  static OutlinedBorder _selectOutlinedButtonShape(Set<MaterialState> states) {
    Color borderColor = DesignColors.gray2_100;
    if (states.contains(MaterialState.hovered) || states.contains(MaterialState.pressed)) {
      borderColor = DesignColors.gray3_100;
    }
    if (states.contains(MaterialState.disabled)) {
      borderColor = const Color(0xFF222F46);
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
    Color fontColor = DesignColors.gray2_100;
    if (states.contains(MaterialState.disabled)) {
      fontColor = const Color(0xFF50525C);
    }
    if (states.contains(MaterialState.hovered)) {
      fontColor = DesignColors.white_100;
    }
    return fontColor;
  }

  static IconThemeData _buildIconThemeData(IconThemeData baseIconThemeData) {
    return baseIconThemeData.copyWith(
      color: Colors.white,
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme(InputDecorationTheme baseInputDecorationTheme) {
    InputBorder defaultInputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF6F6C99)),
      borderRadius: BorderRadius.circular(4),
    );

    return baseInputDecorationTheme.copyWith(
      border: defaultInputBorder,
      errorBorder: defaultInputBorder,
      focusedBorder: defaultInputBorder,
      focusedErrorBorder: defaultInputBorder,
      disabledBorder: defaultInputBorder,
      enabledBorder: defaultInputBorder,
      focusColor: const Color(0xFF121958),
      contentPadding: const EdgeInsets.all(10.0),
      suffixStyle: const TextStyle(fontWeight: FontWeight.w400, color: Color(0xFF6F6C99)),
      prefixStyle: const TextStyle(fontWeight: FontWeight.w400, color: Color(0xFF6F6C99)),
      labelStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF6F6C99)),
      hintStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF6F6C99)),
    );
  }

  static TextSelectionThemeData _buildTextSelectionThemeData(TextSelectionThemeData baseTextSelectionThemeData) {
    return baseTextSelectionThemeData.copyWith(
      cursorColor: const Color(0xFF6F6C99),
    );
  }

  static TextTheme _buildSmallScreenTextTheme(TextTheme baseTextTheme) {
    final TextTheme textTheme = baseTextTheme.apply(fontFamily: 'Inter');

    return textTheme.copyWith(
      headline1: textTheme.headline1!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 25,
      ),
      headline2: textTheme.headline2!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 23,
      ),
      headline3: textTheme.headline3!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 20,
        letterSpacing: 0.5,
      ),
      headline4: textTheme.headline4!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        letterSpacing: 0.5,
      ),
      subtitle1: textTheme.subtitle1!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        letterSpacing: 0.5,
      ),
      subtitle2: textTheme.subtitle2!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      bodyText1: textTheme.bodyText1!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      bodyText2: textTheme.bodyText2!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 13,
      ),
      caption: textTheme.caption!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 11,
      ),
      button: textTheme.button!.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 11,
        letterSpacing: 0.4,
      ),
    );
  }

  static TextTheme _buildLargeScreenTextTheme(TextTheme baseTextTheme) {
    final TextTheme textTheme = baseTextTheme.apply(fontFamily: 'Inter');

    return textTheme.copyWith(
      headline1: textTheme.headline1!.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 32,
      ),
      headline2: textTheme.headline2!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 26,
      ),
      headline3: textTheme.headline3!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 24,
        letterSpacing: 0.5,
      ),
      headline4: textTheme.headline4!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 22,
        letterSpacing: 0.5,
      ),
      subtitle1: textTheme.subtitle1!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        letterSpacing: 0.5,
      ),
      subtitle2: textTheme.subtitle2!.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        letterSpacing: 0.5,
      ),
      bodyText1: textTheme.bodyText1!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      bodyText2: textTheme.bodyText2!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      caption: textTheme.caption!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
      button: textTheme.button!.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 12,
        letterSpacing: 0.4,
      ),
    );
  }
}
