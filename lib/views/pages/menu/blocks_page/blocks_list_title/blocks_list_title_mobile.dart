import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/blocks_page/blocks_list_controller.dart';
import 'package:miro/shared/models/blocks/block_model.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_search_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/sliver_paginated_list/page_size_dropdown/page_size_dropdown.dart';

class BlockListTitleMobile extends StatelessWidget {
  final int pageSize;
  final ValueChanged<int> pageSizeValueChanged;
  final TextEditingController searchBarTextEditingController;
  final BlocksListController blocksListController;

  const BlockListTitleMobile({
    required this.pageSize,
    required this.pageSizeValueChanged,
    required this.searchBarTextEditingController,
    required this.blocksListController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          S.of(context).blocksPageTitle,
          style: textTheme.displaySmall!.copyWith(
            color: DesignColors.white1,
          ),
        ),
        const SizedBox(height: 16),
        ListSearchWidget<BlockModel>(
          textEditingController: searchBarTextEditingController,
          hint: S.of(context).blocksHintSearch,
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            // TODO: #33 not supported by new Interx
            // DateRangeDropdown(
            //   initialStartDateTime: blocksListController.startDateTime,
            //   initialEndDateTime: blocksListController.endDateTime,
            //   onDateTimeChanged: (DateTime? startDateTime, DateTime? endDateTime) {
            //     blocksListController
            //       ..startDateTime = startDateTime
            //       ..endDateTime = endDateTime;
            //     BlocProvider.of<PaginatedListBloc<BlockModel>>(context).add(const ListReloadEvent());
            //   },
            // ),
            // const SizedBox(width: 24),
            PageSizeDropdown(
              selectedPageSize: pageSize,
              availablePageSizes: const <int>[10, 25, 50, 100],
              onPageSizeChanged: pageSizeValueChanged,
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
