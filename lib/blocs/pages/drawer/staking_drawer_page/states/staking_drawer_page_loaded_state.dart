import 'package:miro/blocs/pages/drawer/staking_drawer_page/a_staking_drawer_page_state.dart';
import 'package:miro/shared/models/staking_pool/staking_pool_model.dart';

class StakingDrawerPageLoadedState extends AStakingDrawerPageState {
  const StakingDrawerPageLoadedState({
    required StakingPoolModel stakingPoolModel,
  }) : super(stakingPoolModel: stakingPoolModel);
}
