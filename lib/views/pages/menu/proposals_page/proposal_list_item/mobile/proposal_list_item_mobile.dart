import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/proposals/proposal_model.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/proposal_drawer_page/proposal_drawer_page.dart';
import 'package:miro/views/pages/menu/proposals_page/proposal_status_chip/proposal_status_chip.dart';
import 'package:miro/views/pages/menu/proposals_page/proposal_type_chip/proposal_type_chip.dart';

class ProposalListItemMobile extends StatelessWidget {
  final ProposalModel proposalModel;

  const ProposalListItemMobile({
    required this.proposalModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 26),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: DesignColors.black,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 30,
                child: Text(
                  proposalModel.proposalId.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyText2!.copyWith(
                    color: DesignColors.white2,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  proposalModel.title,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyText2!.copyWith(
                    color: DesignColors.white2,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.info_outline,
                  color: DesignColors.accent,
                  size: 17,
                ),
                tooltip: S.of(context).proposalsToolTip,
                onPressed: () => KiraScaffold.of(context).navigateEndDrawerRoute(
                  ProposalDrawerPage(proposalModel: proposalModel),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(color: DesignColors.grey2),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(width: 30),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      S.of(context).proposalsStatus,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyText2!.copyWith(
                        color: DesignColors.white2,
                      ),
                    ),
                    const SizedBox(width: 10),
                    ProposalStatusChip(proposalStatus: proposalModel.proposalStatus),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(width: 30),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      S.of(context).proposalsTypes,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyText2!.copyWith(
                        color: DesignColors.white2,
                      ),
                    ),
                    const SizedBox(width: 10),
                    ProposalTypeChip(proposalModel: proposalModel)
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(width: 30),
              Text(
                S.of(context).proposalsVotingEndTime,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyText2!.copyWith(
                  color: DesignColors.white2,
                ),
              ),
              const SizedBox(width: 10),
              Text(DateFormat.yMMMEd().format(proposalModel.votingEndTime)),
            ],
          ),
        ],
      ),
    );
  }
}
