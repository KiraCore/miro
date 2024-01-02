import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/shared/models/proposals/proposal_model.dart';
import 'package:miro/shared/models/proposals/proposal_status.dart';

class ProposalsFilterOptions {
  static FilterOption<ProposalModel> filterByStatusUnknown = FilterOption<ProposalModel>(
    id: ProposalStatus.unknown.toString(),
    filterComparator: (ProposalModel a) => a.proposalStatus == ProposalStatus.unknown,
  );
  static FilterOption<ProposalModel> filterByStatusPassed = FilterOption<ProposalModel>(
    id: ProposalStatus.passed.toString(),
    filterComparator: (ProposalModel a) => a.proposalStatus == ProposalStatus.passed,
  );
  static FilterOption<ProposalModel> filterByStatusRejected = FilterOption<ProposalModel>(
    id: ProposalStatus.rejected.toString(),
    filterComparator: (ProposalModel a) => a.proposalStatus == ProposalStatus.rejected,
  );
  static FilterOption<ProposalModel> filterByStatusRejectedWithVeto = FilterOption<ProposalModel>(
    id: ProposalStatus.rejectedWithVeto.toString(),
    filterComparator: (ProposalModel a) => a.proposalStatus == ProposalStatus.rejectedWithVeto,
  );
  static FilterOption<ProposalModel> filterByStatusPending = FilterOption<ProposalModel>(
    id: ProposalStatus.pending.toString(),
    filterComparator: (ProposalModel a) => a.proposalStatus == ProposalStatus.pending,
  );
  static FilterOption<ProposalModel> filterByStatusQuorumNotReached = FilterOption<ProposalModel>(
    id: ProposalStatus.quorumNotReached.toString(),
    filterComparator: (ProposalModel a) => a.proposalStatus == ProposalStatus.quorumNotReached,
  );
  static FilterOption<ProposalModel> filterByStatusEnactment = FilterOption<ProposalModel>(
    id: ProposalStatus.enactment.toString(),
    filterComparator: (ProposalModel a) => a.proposalStatus == ProposalStatus.enactment,
  );
  static FilterOption<ProposalModel> filterByStatusPassedWithExecFail = FilterOption<ProposalModel>(
    id: ProposalStatus.passedWithExecFail.toString(),
    filterComparator: (ProposalModel a) => a.proposalStatus == ProposalStatus.passedWithExecFail,
  );
  static FilterComparator<ProposalModel> search(String searchText) {
    return (ProposalModel item) {
      bool titleMatchBool = item.title.replaceAll(' ', '').toLowerCase().contains(searchText.replaceAll(' ', '').toLowerCase());
      bool proposalTypeMatchBool = item.proposalTypeContentModel.proposalType.toString().toLowerCase().replaceAll(' ', '').contains(searchText.replaceAll(' ', '').toLowerCase());
      return titleMatchBool || proposalTypeMatchBool;
    };
  }
}
