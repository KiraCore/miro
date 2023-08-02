import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/pages/drawer/validator_drawer_page/a_validator_drawer_page_state.dart';
import 'package:miro/blocs/pages/drawer/validator_drawer_page/states/validator_drawer_page_loaded_state.dart';
import 'package:miro/blocs/pages/drawer/validator_drawer_page/states/validator_drawer_page_loading_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api_kira/identity_records_service.dart';
import 'package:miro/infra/services/api_kira/query_staking_pool_service.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';
import 'package:miro/shared/models/staking_pool/staking_pool_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';

class ValidatorDrawerPageCubit extends Cubit<AValidatorDrawerPageState> {
  final IdentityRecordsService _identityRecordsService = globalLocator<IdentityRecordsService>();
  final QueryStakingPoolService _queryStakingPoolService = globalLocator<QueryStakingPoolService>();

  ValidatorDrawerPageCubit() : super(const ValidatorDrawerPageLoadingState());

  Future<void> loadStakingPoolByAddress(String validatorAddress) async {
    emit(const ValidatorDrawerPageLoadingState());

    StakingPoolModel? stakingPoolModel = await _fetchStakingPoolModel(validatorAddress);
    IRModel? irModel = await _fetchIRModel(validatorAddress);

    emit(ValidatorDrawerPageLoadedState(stakingPoolModel: stakingPoolModel, irModel: irModel));
  }

  Future<StakingPoolModel?> _fetchStakingPoolModel(String validatorAddress) async {
    try {
      StakingPoolModel? stakingPoolModel = await _queryStakingPoolService.getStakingPoolModel(WalletAddress.fromBech32(validatorAddress));
      return stakingPoolModel;
    } catch (e) {
      AppLogger().log(message: 'Cannot get stakingPoolModel');
      return null;
    }
  }

  Future<IRModel?> _fetchIRModel(String validatorAddress) async {
    try {
      IRModel? irModel = await _identityRecordsService.getIdentityRecordsByAddress(WalletAddress.fromBech32(validatorAddress));
      return irModel;
    } catch (e) {
      AppLogger().log(message: 'Cannot get IRModel');
      return null;
    }
  }
}
