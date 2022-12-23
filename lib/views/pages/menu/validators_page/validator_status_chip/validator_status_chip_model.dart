import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ValidatorStatusChipModel extends Equatable {
  final String title;
  final Color color;

  const ValidatorStatusChipModel({
    required this.title,
    required this.color,
  });

  @override
  List<Object?> get props => <Object>[title, color];
}
