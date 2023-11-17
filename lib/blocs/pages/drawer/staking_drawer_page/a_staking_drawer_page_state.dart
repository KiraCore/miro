import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/staking_pool/staking_pool_model.dart';

abstract class AStakingDrawerPageState extends Equatable {
  final StakingPoolModel? stakingPoolModel;

  const AStakingDrawerPageState({this.stakingPoolModel});

  @override
  List<Object?> get props => <Object?>[stakingPoolModel];
}
