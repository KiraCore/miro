import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';
import 'package:miro/shared/models/staking_pool/staking_pool_model.dart';

abstract class AValidatorDrawerPageState extends Equatable {
  final StakingPoolModel? stakingPoolModel;
  final IRModel? irModel;

  const AValidatorDrawerPageState({this.stakingPoolModel, this.irModel});

  @override
  List<Object> get props => <Object>[];
}
