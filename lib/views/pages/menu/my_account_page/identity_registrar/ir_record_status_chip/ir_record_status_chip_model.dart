import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class IRRecordStatusChipModel extends Equatable {
  final String title;
  final Color color;
  final Icon? icon;

  const IRRecordStatusChipModel({
    required this.title,
    required this.color,
    this.icon,
  });

  @override
  List<Object?> get props => <Object?>[title, color, icon];
}
