import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class ValidatorDrawerMultipleValuesWidget extends StatelessWidget {
  final List<String>? values;

  const ValidatorDrawerMultipleValuesWidget({
    this.values,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    if (values == null) {
      return Text(
        '---',
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyText2!.copyWith(
          color: DesignColors.white1,
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (String value in values!)
            Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyText2!.copyWith(
                color: DesignColors.white1,
              ),
            ),
        ],
      );
    }
  }
}
