import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';

class ListPopMenuHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onClearPressed;

  const ListPopMenuHeader({
    required this.title,
    this.onClearPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const ResponsiveValue<EdgeInsets>(
        largeScreen: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        mediumScreen: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        smallScreen: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ).get(context),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: ResponsiveValue<TextStyle>(
                largeScreen: textTheme.bodyText2!.copyWith(color: DesignColors.white1),
                mediumScreen: textTheme.bodyText2!.copyWith(color: DesignColors.white1),
                smallScreen: textTheme.subtitle2!.copyWith(color: DesignColors.white1),
              ).get(context),
            ),
          ),
          if (onClearPressed != null)
            IconButton(
              icon: Text(
                S.of(context).txButtonClear,
                style: textTheme.bodyText2!.copyWith(color: DesignColors.white1),
              ),
              onPressed: onClearPressed,
            ),
        ],
      ),
    );
  }
}
