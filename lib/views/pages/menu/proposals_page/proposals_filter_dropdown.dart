import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/proposals_page/proposals_filter_options.dart';
import 'package:miro/shared/models/proposals/proposal_model.dart';
import 'package:miro/views/widgets/kira/kira_list/components/filter_dropdown/filter_dropdown.dart';
import 'package:miro/views/widgets/kira/kira_list/models/filter_option_model.dart';

class ProposalsFilterDropdown extends StatelessWidget {
  final double width;
  final MainAxisAlignment mainAxisAlignment;

  const ProposalsFilterDropdown({
    this.width = 100,
    this.mainAxisAlignment = MainAxisAlignment.start,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterDropdown<ProposalModel>(
      width: width,
      mainAxisAlignment: mainAxisAlignment,
      title: S.of(context).proposalsStatus,
      filterOptionModels: <FilterOptionModel<ProposalModel>>[
        FilterOptionModel<ProposalModel>(
          title: S.of(context).proposalStatusTypeUnknown,
          filterOption: ProposalsFilterOptions.filterByStatusUnknown,
        ),
        FilterOptionModel<ProposalModel>(
          title: S.of(context).proposalStatusTypePassed,
          filterOption: ProposalsFilterOptions.filterByStatusPassed,
        ),
        FilterOptionModel<ProposalModel>(
          title: S.of(context).proposalStatusTypeRejected,
          filterOption: ProposalsFilterOptions.filterByStatusRejected,
        ),
        FilterOptionModel<ProposalModel>(
          title: S.of(context).proposalStatusTypeRejectedWithVeto,
          filterOption: ProposalsFilterOptions.filterByStatusRejectedWithVeto,
        ),
        FilterOptionModel<ProposalModel>(
          title: S.of(context).proposalStatusTypePending,
          filterOption: ProposalsFilterOptions.filterByStatusPending,
        ),
        FilterOptionModel<ProposalModel>(
          title: S.of(context).proposalStatusTypeQuorumNotReached,
          filterOption: ProposalsFilterOptions.filterByStatusQuorumNotReached,
        ),
        FilterOptionModel<ProposalModel>(
          title: S.of(context).proposalStatusTypeEnactment,
          filterOption: ProposalsFilterOptions.filterByStatusEnactment,
        ),
        FilterOptionModel<ProposalModel>(
          title: S.of(context).proposalStatusTypePassedWithExecFail,
          filterOption: ProposalsFilterOptions.filterByStatusPassedWithExecFail,
        ),
      ],
    );
  }
}
