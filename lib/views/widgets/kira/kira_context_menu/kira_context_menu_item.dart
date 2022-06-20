import 'package:flutter/material.dart';

class KiraContextMenuItem {
  final IconData iconData;
  final String label;
  final VoidCallback onTap;

  KiraContextMenuItem({
    required this.iconData,
    required this.label,
    required this.onTap,
  });
}
