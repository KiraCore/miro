import 'package:miro/blocs/pages/drawer/validator_drawer_page/a_validator_drawer_page_state.dart';
import 'package:miro/shared/models/staking_pool/staking_pool_model.dart';

class ValidatorDrawerPageLoadedState extends AValidatorDrawerPageState {
  const ValidatorDrawerPageLoadedState({
    required StakingPoolModel stakingPoolModel,
  }) : super(stakingPoolModel: stakingPoolModel);
}
