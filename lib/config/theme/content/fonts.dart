import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme kTextTheme(TextTheme? theme, String? language) {
  /// Please change the font you look according to the langage.
  switch (language) {
    case 'en':
      return GoogleFonts.interTextTheme(theme);
    case 'pl':
      return GoogleFonts.interTextTheme(theme);
    default:
      return GoogleFonts.interTextTheme(theme);
  }
}
