import 'package:flutter/material.dart';
import 'package:miro/views/pages/menu/proposals_page/proposal_list_title/proposal_list_title_desktop.dart';
import 'package:miro/views/pages/menu/proposals_page/proposal_list_title/proposal_list_title_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class ProposalListTitle extends StatelessWidget {
  final int pageSize;
  final ValueChanged<int> pageSizeValueChanged;
  final TextEditingController searchBarTextEditingController;

  const ProposalListTitle({
    required this.pageSize,
    required this.pageSizeValueChanged,
    required this.searchBarTextEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: ProposalListTitleDesktop(
        pageSize: pageSize,
        pageSizeValueChanged: pageSizeValueChanged,
        searchBarTextEditingController: searchBarTextEditingController,
      ),
      mediumScreen: ProposalListTitleMobile(
        pageSize: pageSize,
        pageSizeValueChanged: pageSizeValueChanged,
        searchBarTextEditingController: searchBarTextEditingController,
      ),
    );
  }
}
