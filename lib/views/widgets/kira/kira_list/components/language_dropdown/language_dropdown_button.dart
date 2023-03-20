import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class LanguageDropdownButton extends StatelessWidget {
  const LanguageDropdownButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const ResponsiveValue<EdgeInsets>(
        largeScreen: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        smallScreen: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      ).get(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.language, color: DesignColors.white2),
          const SizedBox(width: 6),
          Text(
            S.of(context).language,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: textTheme.bodySmall!.copyWith(
              color: DesignColors.white2,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (ResponsiveWidget.isSmallScreen(context) == false) ...<Widget>[
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              color: DesignColors.white2,
              size: 15,
            ),
          ],
        ],
      ),
    );
  }
}
