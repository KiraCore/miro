import 'package:flutter/material.dart';

class AppBarMobileDecoration {
  final Duration backdropDuration;
  final Widget? trailing;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? backdropColor;

  AppBarMobileDecoration({
    this.backdropDuration = const Duration(milliseconds: 150),
    this.trailing,
    this.leading,
    this.backgroundColor,
    this.backdropColor,
  });
}