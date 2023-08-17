import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/shared/models/staking_pool/staking_pool_model.dart';
import 'package:miro/shared/models/validators/validator_model.dart';

class StakingModel extends AListItem{
  final ValidatorModel validatorModel;
  final StakingPoolModel stakingPoolModel;
  bool _favourite = false;

  StakingModel({required this.validatorModel, required this.stakingPoolModel});

  @override
  String get cacheId => validatorModel.walletAddress.bech32Address;

  @override
  bool get isFavourite => _favourite;

  @override
  set favourite(bool value) => _favourite = value;
}
