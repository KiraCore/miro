import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/proposals/proposal_model.dart';
import 'package:miro/views/pages/menu/proposals_page/proposals_filter_dropdown.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_search_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/sliver_paginated_list/page_size_dropdown/page_size_dropdown.dart';

class ProposalListTitleMobile extends StatelessWidget {
  final int pageSize;
  final ValueChanged<int> pageSizeValueChanged;
  final TextEditingController searchBarTextEditingController;

  const ProposalListTitleMobile({
    required this.pageSize,
    required this.pageSizeValueChanged,
    required this.searchBarTextEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              S.of(context).proposalsList,
              style: textTheme.displaySmall!.copyWith(
                color: DesignColors.white1,
              ),
            ),
            const SizedBox(height: 12),
            PageSizeDropdown(
              selectedPageSize: pageSize,
              availablePageSizes: const <int>[10, 25, 50, 100],
              onPageSizeChanged: pageSizeValueChanged,
            ),
          ],
        ),
        const SizedBox(height: 12),
        ListSearchWidget<ProposalModel>(
          textEditingController: searchBarTextEditingController,
          hint: S.of(context).proposalsHintSearch,
        ),
        const SizedBox(height: 12),
        const ProposalsFilterDropdown(),
      ],
    );
  }
}
