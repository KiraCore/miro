import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/events/list_reload_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/paginated_list/paginated_list_bloc.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/blocks_page/blocks_list_controller.dart';
import 'package:miro/shared/models/blocks/block_model.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_search_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/sliver_paginated_list/page_size_dropdown/page_size_dropdown.dart';

class BlockListTitleDesktop extends StatefulWidget {
  static double height = 54;

  final int pageSize;
  final ValueChanged<int> pageSizeValueChanged;
  final TextEditingController searchBarTextEditingController;
  final BlocksListController blocksListController;

  const BlockListTitleDesktop({
    required this.pageSize,
    required this.pageSizeValueChanged,
    required this.searchBarTextEditingController,
    required this.blocksListController,
    Key? key,
  }) : super(key: key);

  @override
  State<BlockListTitleDesktop> createState() => _BlockListTitleDesktopState();
}

class _BlockListTitleDesktopState extends State<BlockListTitleDesktop> {
  bool _hasTxsEnabled = false;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          S.of(context).blocksPageTitle,
          style: textTheme.displayMedium!.copyWith(
            color: DesignColors.white1,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: <Widget>[
            // TODO: #33 date is not supported by new Interx
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
            Row(
              children: <Widget>[
                Text(
                  'Only with txs',
                  style: textTheme.bodySmall!.copyWith(
                    color: DesignColors.white1,
                  ),
                ),
                const SizedBox(width: 8),
                Switch(
                  value: _hasTxsEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      _hasTxsEnabled = value;
                    });
                    widget.blocksListController.hasTxsBool = value ? true : null;
                    BlocProvider.of<PaginatedListBloc<BlockModel>>(context).add(const ListReloadEvent());
                  },
                ),
              ],
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 550),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      PageSizeDropdown(
                        selectedPageSize: widget.pageSize,
                        availablePageSizes: const <int>[10, 25, 50, 100],
                        onPageSizeChanged: widget.pageSizeValueChanged,
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: ListSearchWidget<BlockModel>(
                          textEditingController: widget.searchBarTextEditingController,
                          hint: S.of(context).blocksHintSearch,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
