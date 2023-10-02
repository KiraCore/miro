import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/shared/models/identity_registrar/ir_inbound_verification_request_model.dart';

class VerificationRequestsFilterOptions {
  static FilterComparator<IRInboundVerificationRequestModel> search(String searchText) {
    String pattern = searchText.toLowerCase();

    return (IRInboundVerificationRequestModel item) {
      bool tipMatch = item.tipTokenAmountModel.toString().toLowerCase().contains(pattern);
      bool addressMatch = item.requesterIrUserProfileModel.walletAddress.bech32Address.toLowerCase().contains(pattern);
      bool usernameMatch = item.requesterIrUserProfileModel.username?.toLowerCase().contains(pattern) ?? false;
      bool keyMatch = item.records.keys.join(' ').toLowerCase().contains(pattern);
      bool valueMatch = item.records.values.join(' ').toLowerCase().contains(pattern);
      return tipMatch | addressMatch | usernameMatch | keyMatch | valueMatch;
    };
  }
}
