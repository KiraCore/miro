import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/proposals/proposal_model.dart';
import 'package:miro/shared/models/proposals/proposal_status.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/proposal_drawer_page/proposal_drawer_page.dart';
import 'package:miro/views/pages/menu/proposals_page/proposal_list_item/desktop/proposal_list_item_desktop_layout.dart';
import 'package:miro/views/pages/menu/proposals_page/proposal_status_chip/proposal_status_chip.dart';
import 'package:miro/views/pages/menu/proposals_page/proposal_type_chip/proposal_type_chip.dart';

class ProposalListItemDesktop extends StatelessWidget {
  static const double height = 64;
  final ProposalModel proposalModel;

  const ProposalListItemDesktop({
    required this.proposalModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return ProposalListItemDesktopLayout(
      height: height,
      tooltipWidget: IconButton(
        icon: const Icon(
          Icons.info_outline,
          color: DesignColors.white2,
          size: 24,
        ),
        tooltip: S.of(context).proposalsToolTip,
        onPressed: () => KiraScaffold.of(context).navigateEndDrawerRoute(ProposalDrawerPage(
          proposalModel: proposalModel,
        )),
      ),
      idWidget: Text(
        proposalModel.id.toString(),
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyLarge!.copyWith(
          color: DesignColors.white2,
        ),
      ),
      titleWidget: Text(
        proposalModel.title,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyMedium!.copyWith(
          color: DesignColors.white2,
        ),
      ),
      statusWidget: ProposalStatusChip(proposalStatus: proposalModel.proposalStatus ?? ProposalStatus.unknown),
      typesWidget: ProposalTypeChip(proposalModel: proposalModel),
      votingEndWidget: Text(DateFormat('d MMM y, HH:mm').format(proposalModel.votingEndTime)),
    );
  }
}
