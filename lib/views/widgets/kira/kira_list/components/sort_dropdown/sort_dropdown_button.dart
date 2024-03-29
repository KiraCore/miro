import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/models/sort_option_model.dart';

class SortDropdownButton<T extends AListItem> extends StatelessWidget {
  final SortOptionModel<T> sortOptionModel;

  const SortDropdownButton({
    required this.sortOptionModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      height: 30,
      constraints: const BoxConstraints(
        minWidth: 50,
        maxWidth: 200,
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
            sortOptionModel.title,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: textTheme.bodySmall!.copyWith(
              color: DesignColors.white1,
            ),
          ),
          if (ResponsiveWidget.isSmallScreen(context) == false) ...<Widget>[
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              color: DesignColors.white1,
              size: 15,
            ),
          ],
        ],
      ),
    );
  }
}
