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

  @override
  List<Object?> get props => <Object?>[totalDelegators, slashed, votingPower, commission, tokens];
}
