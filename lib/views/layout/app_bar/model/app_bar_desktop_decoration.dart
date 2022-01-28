import 'package:flutter/material.dart';

class AppBarDesktopDecoration {
  final Widget sidebar;
  final Border? border;
  final Color? backgroundColor;

  AppBarDesktopDecoration({
    required this.sidebar,
    this.backgroundColor,
    this.border,
  });
}