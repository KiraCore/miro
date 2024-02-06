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
      commission: '${(double.parse(delegation.poolInfo.commission) * 100).toString()}%',
      stakingPoolStatus: StakingPoolStatus.fromString(delegation.poolInfo.status),
      tokens: delegation.poolInfo.tokens.map(TokenAliasModel.local).toList(),
      validatorSimplifiedModel: ValidatorSimplifiedModel(
        walletAddress: WalletAddress.fromBech32(delegation.validatorInfo.address),
        moniker: delegation.validatorInfo.moniker,
        logo: delegation.validatorInfo.logo,
        valkey: delegation.validatorInfo.valkey,
      ),
    );
  }

  ValidatorStakingModel copyWith({
    List<TokenAliasModel>? tokens,
  }) {
    return ValidatorStakingModel(
      commission: commission,
      tokens: tokens ?? this.tokens,
      stakingPoolStatus: stakingPoolStatus,
      validatorSimplifiedModel: validatorSimplifiedModel,
    );
  }

  ValidatorStakingModel fillTokenAliases(List<TokenAliasModel> tokenAliasModels) {
    List<TokenAliasModel> filledTokenAliases = tokens.map((TokenAliasModel e) {
      return tokenAliasModels.firstWhere(
        (TokenAliasModel tokenAliasModel) => tokenAliasModel.defaultTokenDenominationModel.name == e.defaultTokenDenominationModel.name,
        orElse: () => e,
      );
    }).toList();

    return copyWith(tokens: filledTokenAliases);
  }

  List<String> get defaultDenomNames => tokens.map((TokenAliasModel e) => e.defaultTokenDenominationModel.name).toList();

  List<String> get networkDenomNames => tokens.map((TokenAliasModel e) => e.networkTokenDenominationModel.name).toList();

  @override
  String get cacheId => validatorSimplifiedModel.walletAddress.bech32Address;

  @override
  bool get isFavourite => false;

  @override
  set favourite(bool value) => false;
}
