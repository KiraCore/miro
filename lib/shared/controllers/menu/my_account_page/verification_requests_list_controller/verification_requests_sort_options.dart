import 'package:miro/blocs/widgets/kira/kira_list/sort/models/sort_option.dart';
import 'package:miro/shared/models/identity_registrar/ir_inbound_verification_request_model.dart';

class VerificationRequestsSortOptions {
  static SortOption<IRInboundVerificationRequestModel> get sortByDate {
    return SortOption<IRInboundVerificationRequestModel>.asc(
      id: 'creation_date',
      comparator: (IRInboundVerificationRequestModel a, IRInboundVerificationRequestModel b) => a.dateTime.compareTo(b.dateTime),
    );
  }

  static SortOption<IRInboundVerificationRequestModel> get sortByTip {
    return SortOption<IRInboundVerificationRequestModel>.asc(
      id: 'tip',
      comparator: (IRInboundVerificationRequestModel a, IRInboundVerificationRequestModel b) =>
          a.tipTokenAmountModel.getAmountInLowestDenomination().compareTo(b.tipTokenAmountModel.getAmountInLowestDenomination()),
    );
  }
}
