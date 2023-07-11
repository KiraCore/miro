import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/shared/models/proposals/proposal_model.dart';

class ProposalsFilterOptions {
  static FilterComparator<ProposalModel> search(String searchText) {
    return (ProposalModel item) {
      bool titleMatchBool = item.title.replaceAll(' ', '').toLowerCase().contains(searchText.replaceAll(' ', '').toLowerCase());
      bool proposalTypeMatchBool =
          item.proposalTitle.toString().toLowerCase().replaceAll(' ', '').contains(searchText.replaceAll(' ', '').toLowerCase());
      return titleMatchBool || proposalTypeMatchBool;
    };
  }
}
