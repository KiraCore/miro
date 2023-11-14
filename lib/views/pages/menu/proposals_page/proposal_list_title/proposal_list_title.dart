import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/filters_bloc.dart';
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
        proposalsListController: proposalsListController,
        searchBarTextEditingController: searchBarTextEditingController,
      ),
      mediumScreen: ProposalListTitleMobile(
        pageSize: pageSize,
        pageSizeValueChanged: pageSizeValueChanged,
        proposalsListController: proposalsListController,
        searchBarTextEditingController: searchBarTextEditingController,
      ),
    );
  }
}
