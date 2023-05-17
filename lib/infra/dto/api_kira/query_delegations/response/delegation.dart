import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_delegations/response/pool_info.dart';
import 'package:miro/infra/dto/shared/validator_info.dart';

class Delegation extends Equatable {
  final ValidatorInfo validatorInfo;
  final PoolInfo poolInfo;

  const Delegation({
    required this.validatorInfo,
    required this.poolInfo,
  });

  factory Delegation.fromJson(Map<String, dynamic> json) {
    return Delegation(
      validatorInfo: ValidatorInfo.fromJson(json['validator_info'] as Map<String, dynamic>),
      poolInfo: PoolInfo.fromJson(json['pool_info'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => <Object?>[validatorInfo, poolInfo];
}
