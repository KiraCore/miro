import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class DetailTitle extends StatelessWidget {
  const DetailTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle headerStyle = textTheme.bodySmall!.copyWith(color: DesignColors.white1);

    return Text('${title}:', style: headerStyle);
  }
}
