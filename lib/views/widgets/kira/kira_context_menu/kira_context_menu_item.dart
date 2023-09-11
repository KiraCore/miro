import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class KiraContextMenuItem extends Equatable {
  final String label;
  final IconData iconData;
  final VoidCallback onTap;

  const KiraContextMenuItem({
    required this.label,
    required this.iconData,
    required this.onTap,
  });

  @override
  List<Object?> get props => <Object>[label, iconData, onTap];
}
