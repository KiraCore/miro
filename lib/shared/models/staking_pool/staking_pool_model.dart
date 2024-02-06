import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_staking_pool/response/query_staking_pool_resp.dart';
import 'package:miro/infra/dto/shared/coin.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';

class StakingPoolModel extends Equatable {
  final int totalDelegators;
  final String slashed;
  final List<TokenAmountModel> votingPower;
  final String commission;
  final List<TokenAliasModel> tokens;

  const StakingPoolModel({
    required this.totalDelegators,
    required this.slashed,
    required this.votingPower,
    required this.commission,
    required this.tokens,
  });

  factory StakingPoolModel.fromDto(QueryStakingPoolResp queryStakingPoolResp) {
    return StakingPoolModel(
      totalDelegators: queryStakingPoolResp.totalDelegators,
      slashed: '${(double.parse(queryStakingPoolResp.slashed) * 100).toString()}%',
      votingPower: queryStakingPoolResp.votingPower
          .map((Coin e) => TokenAmountModel(defaultDenominationAmount: Decimal.parse(e.amount), tokenAliasModel: TokenAliasModel.local(e.denom)))
          .toList(),
      commission: '${(double.parse(queryStakingPoolResp.commission) * 100).toString()}%',
      tokens: queryStakingPoolResp.tokens.map(TokenAliasModel.local).toList(),
    );
  }

  StakingPoolModel copyWith({
    List<TokenAmountModel>? votingPower,
    List<TokenAliasModel>? tokens,
  }) {
    return StakingPoolModel(
      totalDelegators: totalDelegators,
      slashed: slashed,
      votingPower: votingPower ?? this.votingPower,
      commission: commission,
      tokens: tokens ?? this.tokens,
    );
  }

  StakingPoolModel fillTokenAliases(List<TokenAliasModel> tokenAliasModels) {
    List<TokenAmountModel> filledVotingPower = votingPower.map((TokenAmountModel e) {
      return e.copyWith(
        tokenAliasModel: tokenAliasModels.firstWhere(
          (TokenAliasModel tokenAliasModel) => tokenAliasModel.defaultTokenDenominationModel.name == e.tokenAliasModel.defaultTokenDenominationModel.name,
          orElse: () => e.tokenAliasModel,
        ),
      );
    }).toList();

    List<TokenAliasModel> filledTokenAliases = tokens.map((TokenAliasModel e) {
      return tokenAliasModels.firstWhere(
        (TokenAliasModel tokenAliasModel) => tokenAliasModel.defaultTokenDenominationModel.name == e.defaultTokenDenominationModel.name,
        orElse: () => e,
      );
    }).toList();

    return copyWith(votingPower: filledVotingPower, tokens: filledTokenAliases);
  }

  List<String> get defaultDenomNames {
    List<TokenAliasModel> votingPowerAliases = votingPower.map((TokenAmountModel e) => e.tokenAliasModel).toList();

    return <String>[
      ...votingPowerAliases.map((TokenAliasModel e) => e.defaultTokenDenominationModel.name),
      ...tokens.map((TokenAliasModel e) => e.defaultTokenDenominationModel.name),
    ];
  }

  @override
  List<Object?> get props => <Object?>[totalDelegators, slashed, votingPower, commission, tokens];
}
