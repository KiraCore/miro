import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/pages/drawer/staking_drawer_page/a_staking_drawer_page_state.dart';
import 'package:miro/blocs/pages/drawer/staking_drawer_page/states/staking_drawer_page_error_state.dart';
import 'package:miro/blocs/pages/drawer/staking_drawer_page/states/staking_drawer_page_loaded_state.dart';
import 'package:miro/blocs/pages/drawer/staking_drawer_page/states/staking_drawer_page_loading_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api_kira/query_staking_pool_service.dart';
import 'package:miro/shared/models/staking_pool/staking_pool_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class StakingDrawerPageCubit extends Cubit<AStakingDrawerPageState> {
  final QueryStakingPoolService _queryStakingPoolService = globalLocator<QueryStakingPoolService>();

  StakingDrawerPageCubit() : super(const StakingDrawerPageLoadingState());

  Future<void> init(WalletAddress validatorWalletAddress) async {
    emit(const StakingDrawerPageLoadingState());
    try {
      StakingPoolModel stakingPoolModel = await _queryStakingPoolService.getStakingPoolModel(validatorWalletAddress);
      emit(StakingDrawerPageLoadedState(stakingPoolModel: stakingPoolModel));
    } catch (e) {
      emit(const StakingDrawerPageErrorState());
    }
  }
}
