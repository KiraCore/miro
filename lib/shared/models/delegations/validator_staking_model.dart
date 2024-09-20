import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/infra/dto/api_kira/query_delegations/response/delegation.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/validators/staking_pool_status.dart';
import 'package:miro/shared/models/validators/validator_simplified_model.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';

class ValidatorStakingModel extends AListItem {
  final String commission;
  final StakingPoolStatus stakingPoolStatus;
  final List<TokenAliasModel> tokens;
  final ValidatorSimplifiedModel validatorSimplifiedModel;

  ValidatorStakingModel({
    required this.commission,
    required this.stakingPoolStatus,
    required this.tokens,
    required this.validatorSimplifiedModel,
  });

  factory ValidatorStakingModel.fromDto(Delegation delegation) {
    return ValidatorStakingModel(
      commission: '${(double.parse(delegation.poolInfo.commission) * 100).toString()}%',
      stakingPoolStatus: StakingPoolStatus.fromString(delegation.poolInfo.status),
      tokens: delegation.poolInfo.tokens.map(TokenAliasModel.local).toList(),
      validatorSimplifiedModel: ValidatorSimplifiedModel(
        walletAddress: AWalletAddress.fromAddress(delegation.validatorInfo.address),
        moniker: delegation.validatorInfo.moniker,
        logo: delegation.validatorInfo.logo,
        valkey: delegation.validatorInfo.valkey,
      ),
    );
  }

  @override
  String get cacheId => validatorSimplifiedModel.walletAddress.address;

  @override
  bool get isFavourite => false;

  @override
  set favourite(bool value) => false;

  List<String> get tokenNames => tokens.map((TokenAliasModel e) => e.name).toList();
}
