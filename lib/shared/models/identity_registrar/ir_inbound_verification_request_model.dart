import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/shared/models/identity_registrar/ir_user_profile_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';

class IRInboundVerificationRequestModel extends AListItem {
  final String id;
  final DateTime dateTime;
  final IRUserProfileModel requesterIrUserProfileModel;
  final Map<String, String> records;
  final TokenAmountModel tipTokenAmountModel;

  IRInboundVerificationRequestModel({
    required this.id,
    required this.dateTime,
    required this.requesterIrUserProfileModel,
    required this.records,
    required this.tipTokenAmountModel,
  });

  @override
  String get cacheId => id;

  @override
  bool get isFavourite => false;

  @override
  set favourite(bool value) {}
}
