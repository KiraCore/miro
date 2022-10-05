import 'package:flutter/material.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/config/theme/design_colors.dart';
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
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: DesignColors.gray2_100,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              sortOptionModel.title,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: ResponsiveWidget.isSmallScreen(context) ? 12 : 13,
                fontWeight: FontWeight.w500,
                color: DesignColors.gray2_100,
              ),
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.keyboard_arrow_down,
            color: DesignColors.gray2_100,
            size: 15,
          ),
        ],
      ),
    );
  }
}
