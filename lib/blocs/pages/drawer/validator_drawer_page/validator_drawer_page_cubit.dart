import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/pages/drawer/validator_drawer_page/a_validator_drawer_page_state.dart';
import 'package:miro/blocs/pages/drawer/validator_drawer_page/states/validator_drawer_page_error_state.dart';
import 'package:miro/blocs/pages/drawer/validator_drawer_page/states/validator_drawer_page_loaded_state.dart';
import 'package:miro/blocs/pages/drawer/validator_drawer_page/states/validator_drawer_page_loading_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api_kira/query_staking_pool_service.dart';
import 'package:miro/shared/models/staking_pool/staking_pool_model.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';

class ValidatorDrawerPageCubit extends Cubit<AValidatorDrawerPageState> {
  final QueryStakingPoolService _queryStakingPoolService = globalLocator<QueryStakingPoolService>();

  ValidatorDrawerPageCubit() : super(const ValidatorDrawerPageLoadingState());

  Future<void> init(String validatorAddress) async {
    try {
      emit(const ValidatorDrawerPageLoadingState());
      StakingPoolModel stakingPoolModel = await _queryStakingPoolService.getStakingPoolModel(AWalletAddress.fromAddress(validatorAddress));
      emit(ValidatorDrawerPageLoadedState(stakingPoolModel: stakingPoolModel));
    } catch (e) {
      emit(const ValidatorDrawerPageErrorState());
    }
  }
}
