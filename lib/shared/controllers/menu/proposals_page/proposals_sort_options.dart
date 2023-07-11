import 'package:miro/blocs/widgets/kira/kira_list/sort/models/sort_option.dart';
import 'package:miro/shared/models/proposals/proposal_model.dart';

class ProposalsSortOptions {
  static SortOption<ProposalModel> get sortById {
    return SortOption<ProposalModel>.asc(
      id: 'id',
      comparator: (ProposalModel a, ProposalModel b) => a.id.compareTo(b.id),
    );
  }
}
