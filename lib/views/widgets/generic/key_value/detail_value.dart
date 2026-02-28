import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class DetailValue extends StatelessWidget {
  const DetailValue(this.value, {super.key});

  final String value;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle valueStyle = textTheme.bodyMedium!.copyWith(color: DesignColors.white2);

    return Text(value, overflow: TextOverflow.ellipsis, style: valueStyle);
  }
}
