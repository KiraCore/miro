import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/filters_bloc.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/proposals/proposal_model.dart';
import 'package:miro/views/pages/menu/proposals_page/proposals_filter_dropdown.dart';
import 'package:miro/views/widgets/generic/date_range_dropdown/date_range_dropdown.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_search_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/sliver_paginated_list/page_size_dropdown/page_size_dropdown.dart';

class ProposalListTitleDesktop extends StatelessWidget {
  final int pageSize;
  final FiltersBloc<ProposalModel> filtersBloc;
  final ValueChanged<int> pageSizeValueChanged;
  final void Function(DateTime?, DateTime?) updateFiltersByDate;
  final TextEditingController searchBarTextEditingController;

  const ProposalListTitleDesktop({
    required this.pageSize,
    required this.filtersBloc,
    required this.pageSizeValueChanged,
    required this.updateFiltersByDate,
    required this.searchBarTextEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      child: Row(
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: PageSizeDropdown(
                  selectedPageSize: pageSize,
                  availablePageSizes: const <int>[10, 25, 50, 100],
                  onPageSizeChanged: pageSizeValueChanged,
                ),
              ),
              DateRangeDropdown(
                onDateTimeChanged: updateFiltersByDate,
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const Expanded(
                  child: ProposalsFilterDropdown(
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                ),
                const SizedBox(width: 24),
                SizedBox(
                  width: 300,
                  child: ListSearchWidget<ProposalModel>(
                    textEditingController: searchBarTextEditingController,
                    hint: S.of(context).proposalsHintSearch,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
