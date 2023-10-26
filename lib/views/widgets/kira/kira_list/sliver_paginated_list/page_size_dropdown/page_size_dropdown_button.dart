import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class PageSizeDropdownButton extends StatelessWidget {
  final int selectedPageSize;
  final VoidCallback onTap;

  const PageSizeDropdownButton({
    required this.selectedPageSize,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          '${S.of(context).paginatedListPageSize}: ',
          style: ResponsiveValue<TextStyle>(
            largeScreen: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
            smallScreen: textTheme.bodySmall!.copyWith(color: DesignColors.white2),
          ).get(context),
        ),
        const ResponsiveWidget(
          largeScreen: SizedBox(width: 10),
          mediumScreen: SizedBox(width: 10),
          smallScreen: SizedBox(width: 8),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 30,
            constraints: const BoxConstraints(
              minWidth: 50,
              maxWidth: 80,
            ),
            padding: const ResponsiveValue<EdgeInsets>(
              largeScreen: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              smallScreen: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            ).get(context),
            decoration: BoxDecoration(
              border: Border.all(
                color: DesignColors.greyOutline,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  selectedPageSize.toString(),
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: textTheme.bodySmall!.copyWith(color: DesignColors.white1),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: DesignColors.white1,
                  size: 15,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
