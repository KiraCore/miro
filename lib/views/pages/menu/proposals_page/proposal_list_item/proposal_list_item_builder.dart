import 'package:flutter/material.dart';
import 'package:miro/shared/models/proposals/proposal_model.dart';
import 'package:miro/views/pages/menu/proposals_page/proposal_list_item/desktop/proposal_list_item_desktop.dart';
import 'package:miro/views/pages/menu/proposals_page/proposal_list_item/mobile/proposal_list_item_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class ProposalListItemBuilder extends StatefulWidget {
  final ProposalModel proposalModel;
  final ScrollController scrollController;

  const ProposalListItemBuilder({
    required this.proposalModel,
    required this.scrollController,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProposalListItemBuilder();
}

class _ProposalListItemBuilder extends State<ProposalListItemBuilder> {
  @override
  Widget build(BuildContext context) {
    Widget desktopListItem = ProposalListItemDesktop(
      proposalModel: widget.proposalModel,
    );

    Widget mobileListItem = ProposalListItemMobile(
      proposalModel: widget.proposalModel,
    );

    return ResponsiveWidget(
      largeScreen: desktopListItem,
      mediumScreen: mobileListItem,
      smallScreen: mobileListItem,
    );
  }
}
