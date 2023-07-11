import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/events/list_reload_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/paginated_list/paginated_list_bloc.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/proposals_page/proposals_list_controller.dart';
import 'package:miro/shared/models/proposals/proposal_model.dart';
import 'package:miro/shared/models/proposals/proposal_status.dart';
import 'package:miro/views/pages/menu/proposals_page/proposals_filter_dropdown.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_search_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/sliver_paginated_list/page_size_dropdown/page_size_dropdown.dart';

class ProposalListTitleMobile extends StatefulWidget {
  final int pageSize;
  final ValueChanged<int> pageSizeValueChanged;
  final ProposalsListController proposalsListController;
  final TextEditingController searchBarTextEditingController;

  const ProposalListTitleMobile({
    required this.pageSize,
    required this.pageSizeValueChanged,
    required this.proposalsListController,
    required this.searchBarTextEditingController,
    Key? key,
  }) : super(key: key);

  @override
  State<ProposalListTitleMobile> createState() => _ProposalListTitleMobileState();
}

class _ProposalListTitleMobileState extends State<ProposalListTitleMobile> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    List<dynamic> activeFilters = <dynamic>[
      ...widget.proposalsListController.statusFilters ?? <ProposalStatus>[],
    ];

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
              selectedPageSize: widget.pageSize,
              availablePageSizes: const <int>[10, 25, 50, 100],
              onPageSizeChanged: widget.pageSizeValueChanged,
            ),
          ],
        ),
        const SizedBox(height: 12),
        ListSearchWidget<ProposalModel>(
          textEditingController: widget.searchBarTextEditingController,
          hint: S.of(context).proposalsHintSearch,
        ),
        const SizedBox(height: 12),
        ProposalsFilterDropdown(
          mainAxisAlignment: MainAxisAlignment.end,
          activeFilters: activeFilters,
          onFiltersChanged: _updateFilters,
        ),
      ],
    );
  }

  void _updateFilters(List<dynamic> activeFilters) {
    widget.proposalsListController.statusFilters = activeFilters.whereType<ProposalStatus>().toList();
    BlocProvider.of<PaginatedListBloc<ProposalModel>>(context).add(const ListReloadEvent());
  }
}
