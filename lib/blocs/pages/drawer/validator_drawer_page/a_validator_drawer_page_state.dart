import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/staking_pool/staking_pool_model.dart';

abstract class AValidatorDrawerPageState extends Equatable {
  final StakingPoolModel? stakingPoolModel;

  const AValidatorDrawerPageState({this.stakingPoolModel});

  @override
  List<Object?> get props => <Object?>[stakingPoolModel];
}
