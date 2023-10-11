import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/infra/dto/api_kira/query_delegations/response/delegation.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/validators/staking_pool_status.dart';
import 'package:miro/shared/models/validators/validator_simplified_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

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
      commission: delegation.poolInfo.commission,
      stakingPoolStatus: StakingPoolStatus.fromString(delegation.poolInfo.status),
      tokens: delegation.poolInfo.tokens.map(TokenAliasModel.local).toList(),
      validatorSimplifiedModel: ValidatorSimplifiedModel(
        walletAddress: WalletAddress.fromBech32(delegation.validatorInfo.address),
        valkeyWalletAddress: WalletAddress.fromBech32(delegation.validatorInfo.valkey),
        moniker: delegation.validatorInfo.moniker,
        logo: delegation.validatorInfo.logo,
      ),
    );
  }

  @override
  String get cacheId => validatorSimplifiedModel.walletAddress.bech32Address;

  @override
  bool get isFavourite => false;

  @override
  set favourite(bool value) => false;
}
