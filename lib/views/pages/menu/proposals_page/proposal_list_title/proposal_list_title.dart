import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/events/filters_add_option_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/events/filters_remove_option_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/filters_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_mode.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/shared/controllers/menu/proposals_page/proposals_filter_options.dart';
import 'package:miro/shared/controllers/menu/proposals_page/proposals_list_controller.dart';
import 'package:miro/shared/models/proposals/proposal_model.dart';
import 'package:miro/views/pages/menu/proposals_page/proposal_list_title/proposal_list_title_desktop.dart';
import 'package:miro/views/pages/menu/proposals_page/proposal_list_title/proposal_list_title_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class ProposalListTitle extends StatelessWidget {
  final int pageSize;
  final FiltersBloc<ProposalModel> filtersBloc;
  final ValueChanged<int> pageSizeValueChanged;
  final ProposalsListController proposalsListController;
  final TextEditingController searchBarTextEditingController;

  const ProposalListTitle({
    required this.pageSize,
    required this.filtersBloc,
    required this.pageSizeValueChanged,
    required this.proposalsListController,
    required this.searchBarTextEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: ProposalListTitleDesktop(
        pageSize: pageSize,
        filtersBloc: filtersBloc,
        pageSizeValueChanged: pageSizeValueChanged,
        updateFiltersByDate: _updateFiltersByDate,
        searchBarTextEditingController: searchBarTextEditingController,
      ),
      mediumScreen: ProposalListTitleMobile(
        pageSize: pageSize,
        pageSizeValueChanged: pageSizeValueChanged,
        searchBarTextEditingController: searchBarTextEditingController,
      ),
    );
  }

  void _updateFiltersByDate(DateTime? startDateTime, DateTime? endDateTime) {
    if (proposalsListController.filteringByStartDate != null) {
      _removeFilterByStartDate();
    }
    if (proposalsListController.filteringByEndDate != null) {
      _removeFilterByEndDate();
    }
    if (startDateTime != null) {
      _addFilterByStartDate(startDateTime);
    }
    if (endDateTime != null) {
      _addFilterByEndDate(endDateTime);
    }
  }

  void _addFilterByStartDate(DateTime startDateTime) {
    proposalsListController.filteringByStartDate = FilterOption<ProposalModel>(
      id: 'byStartDate',
      filterComparator: ProposalsFilterOptions.isAfter(startDateTime),
      filterMode: FilterMode.and,
    );
    filtersBloc.add(
      FiltersAddOptionEvent<ProposalModel>(proposalsListController.filteringByStartDate!),
    );
  }

  void _addFilterByEndDate(DateTime endDateTime) {
    proposalsListController.filteringByEndDate = FilterOption<ProposalModel>(
      id: 'byEndDate',
      filterComparator: ProposalsFilterOptions.isBefore(endDateTime),
      filterMode: FilterMode.and,
    );
    filtersBloc.add(
      FiltersAddOptionEvent<ProposalModel>(proposalsListController.filteringByEndDate!),
    );
  }

  void _removeFilterByStartDate() {
    filtersBloc.add(FiltersRemoveOptionEvent<ProposalModel>(proposalsListController.filteringByStartDate!));
  }

  void _removeFilterByEndDate() {
    filtersBloc.add(FiltersRemoveOptionEvent<ProposalModel>(proposalsListController.filteringByEndDate!));
  }
}
