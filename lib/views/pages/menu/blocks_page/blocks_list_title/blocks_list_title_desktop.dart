import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/blocks/block_model.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_search_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/sliver_paginated_list/page_size_dropdown/page_size_dropdown.dart';

class BlockListTitleDesktop extends StatelessWidget {
  final int pageSize;
  final ValueChanged<int> pageSizeValueChanged;
  final TextEditingController searchBarTextEditingController;

  const BlockListTitleDesktop({
    required this.pageSize,
    required this.pageSizeValueChanged,
    required this.searchBarTextEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                S.of(context).blocksPageTitle,
                style: textTheme.bodyMedium!.copyWith(
                  color: DesignColors.white1,
                ),
              ),
              PageSizeDropdown(
                selectedPageSize: pageSize,
                availablePageSizes: const <int>[10, 25, 50, 100],
                onPageSizeChanged: pageSizeValueChanged,
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 700),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    const SizedBox(
                      width: 340,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          //ValidatorsFilterDropdown(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: ListSearchWidget<BlockModel>(
                        textEditingController: searchBarTextEditingController,
                        hint: S.of(context).blocksHintSearch,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
