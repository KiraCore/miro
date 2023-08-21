import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_staking_pool/response/query_staking_pool_resp.dart';
import 'package:miro/infra/dto/shared/coin.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';

class StakingPoolModel extends Equatable {
  final int id;
  final int totalDelegators;
  final String commission;
  final String slashed;
  final List<String> tokens;
  final List<TokenAmountModel> votingPower;

  const StakingPoolModel({
    required this.id,
    required this.totalDelegators,
    required this.commission,
    required this.slashed,
    required this.tokens,
    required this.votingPower,
  });

  factory StakingPoolModel.fromDto(QueryStakingPoolResp queryStakingPoolResp) {
    return StakingPoolModel(
      id: queryStakingPoolResp.id,
      totalDelegators: queryStakingPoolResp.totalDelegators,
      commission: '${(double.parse(queryStakingPoolResp.commission) * 100).toString()}%',
      slashed: '${(double.parse(queryStakingPoolResp.slashed) * 100).toString()}%',
      tokens: queryStakingPoolResp.tokens,
      votingPower: queryStakingPoolResp.votingPower
          .map((Coin e) => TokenAmountModel(lowestDenominationAmount: Decimal.parse(e.amount), tokenAliasModel: TokenAliasModel.local(e.denom)))
          .toList(),
    );
  }

  @override
  List<Object?> get props => <Object?>[commission, slashed, tokens, votingPower];
}
