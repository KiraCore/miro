import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/proposals/proposal_status.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/views/pages/menu/proposals_page/proposal_status_chip/proposal_status_chip_model.dart';

class ProposalStatusChip extends StatelessWidget {
  final ProposalStatus proposalStatus;

  const ProposalStatusChip({
    required this.proposalStatus,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ProposalStatusChipModel proposalStatusChipModel = _assignProposalStatusChipModel(context);

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: proposalStatusChipModel.color.withAlpha(20),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          proposalStatusChipModel.title,
          style: textTheme.bodySmall!.copyWith(
            color: proposalStatusChipModel.color,
          ),
        ),
      ),
    );
  }

  ProposalStatusChipModel _assignProposalStatusChipModel(BuildContext context) {
    switch (proposalStatus) {
      case ProposalStatus.enactment:
        return ProposalStatusChipModel(color: DesignColors.greenStatus1, title: S.of(context).proposalStatusTypeEnactment);
      case ProposalStatus.passed:
        return ProposalStatusChipModel(color: DesignColors.greenStatus1, title: S.of(context).proposalStatusTypePassed);
      case ProposalStatus.passedWithExecFail:
        return ProposalStatusChipModel(color: DesignColors.redStatus1, title: S.of(context).proposalStatusTypePassedWithExecFail);
      case ProposalStatus.pending:
        return ProposalStatusChipModel(color: DesignColors.yellowStatus1, title: S.of(context).proposalStatusTypePending);
      case ProposalStatus.quorumNotReached:
        return ProposalStatusChipModel(color: DesignColors.redStatus1, title: S.of(context).proposalStatusTypeQuorumNotReached);
      case ProposalStatus.rejected:
        return ProposalStatusChipModel(color: DesignColors.redStatus1, title: S.of(context).proposalStatusTypeRejected);
      case ProposalStatus.rejectedWithVeto:
        return ProposalStatusChipModel(color: DesignColors.redStatus1, title: S.of(context).proposalStatusTypeRejectedWithVeto);
      case ProposalStatus.unknown:
        return ProposalStatusChipModel(color: DesignColors.white1, title: S.of(context).proposalStatusTypeUnknown);
      default:
        AppLogger().log(message: 'Unknown proposal status: $proposalStatus');
        return ProposalStatusChipModel(color: DesignColors.white2, title: S.of(context).proposalStatusTypeUnknownProposalException);
    }
  }
}
