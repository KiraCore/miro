import 'package:flutter/material.dart';
import 'package:miro/config/theme/content/fonts.dart';
import 'package:miro/config/theme/design_colors.dart';

ColorScheme _kColorSchemeDark = ColorScheme.dark(
  primary: DesignColors.blue1_100,
  primaryVariant: Colors.grey[300]!,
  secondary: const Color(0xffbbbbbb),
  background: const Color(0xff2E2E2E),
  onPrimary: Colors.black,
);

TextTheme _buildDarkTextTheme(TextTheme? base, String? lang) {
  final TextTheme textTheme = kTextTheme(base, lang);
  return textTheme.copyWith(
    headline1: textTheme.headline1!.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 24,
    ),
    headline2: textTheme.headline2!.copyWith(
      color: DesignColors.gray2_100,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
  );
}

ThemeData buildDarkTheme(String? lang) {
  InputBorder defaultInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color(0xFF6F6C99),
    ),
    borderRadius: BorderRadius.circular(4),
  );

  final ThemeData baseDark = ThemeData.dark();
  return baseDark.copyWith(
    textTheme: _buildDarkTextTheme(baseDark.textTheme, lang),
    scaffoldBackgroundColor: DesignColors.gray1_100,
    backgroundColor: DesignColors.gray1_100,
    canvasColor: DesignColors.gray1_100,
    colorScheme: _kColorSchemeDark,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Color(0xFF6F6C99),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(foregroundColor: MaterialStateProperty.resolveWith(_getTextButtonFontColor)),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith(_getOutlinedButtonFontColor),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 12,
            color: DesignColors.white_100,
          ),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(10.0),
        ),
        shape: MaterialStateProperty.resolveWith(_getOutlinedButtonShape),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(const Color(0xFFFFFFFF)),
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(10.0),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
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
    ),
  );
}

OutlinedBorder _getOutlinedButtonShape(Set<MaterialState> states) {
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

Color _getOutlinedButtonFontColor(Set<MaterialState> states) {
  Color fontColor = DesignColors.white_100;
  if (states.contains(MaterialState.disabled)) {
    fontColor = const Color(0xFF50525C);
  }
  return fontColor;
}

Color _getTextButtonFontColor(Set<MaterialState> states) {
  Color fontColor = DesignColors.gray2_100;
  if (states.contains(MaterialState.disabled)) {
    fontColor = const Color(0xFF50525C);
  }
  if (states.contains(MaterialState.hovered)) {
    fontColor = DesignColors.white_100;
  }
  return fontColor;
}

Color _getIconButtonColor(Set<MaterialState> states) {
  Color fontColor = DesignColors.gray2_100;
  if (states.contains(MaterialState.disabled)) {
    fontColor = const Color(0xFF50525C);
  }
  if (states.contains(MaterialState.hovered)) {
    fontColor = DesignColors.white_100;
  }
  return fontColor;
}
