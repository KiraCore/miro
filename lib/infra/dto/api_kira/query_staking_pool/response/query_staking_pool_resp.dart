import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/shared/coin.dart';

class QueryStakingPoolResp extends Equatable {
  final int id;
  final int totalDelegators;
  final String commission;
  final String slashed;
  final List<String> tokens;
  final List<Coin> votingPower;

  const QueryStakingPoolResp({
    required this.id,
    required this.totalDelegators,
    required this.commission,
    required this.slashed,
    required this.tokens,
    required this.votingPower,
  });

  factory QueryStakingPoolResp.fromJson(Map<String, dynamic> json) {
    List<dynamic> coinList = json['voting_power'] != null ? json['voting_power'] as List<dynamic> : List<dynamic>.empty();

    return QueryStakingPoolResp(
      id: json['id'] as int,
      totalDelegators: json['total_delegators'] as int,
      commission: json['commission'] as String,
      slashed: json['slashed'] as String,
      tokens: (json['tokens'] as List<dynamic>).map((dynamic e) => e as String).toList(),
      votingPower: coinList.map((dynamic e) => Coin.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  List<Object?> get props => <Object?>[id, totalDelegators, commission, slashed, tokens, votingPower];
}
