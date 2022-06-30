import 'package:flutter/material.dart';

class AppBarMobileDecoration {
  final Duration backdropDuration;
  final Widget? trailing;
  final Widget? leading;
  final Widget? title;
  final Color? backgroundColor;
  final Color? backdropColor;

  AppBarMobileDecoration({
    this.backdropDuration = const Duration(milliseconds: 150),
    this.trailing,
    this.leading,
    this.title,
    this.backgroundColor,
    this.backdropColor,
  });
}
