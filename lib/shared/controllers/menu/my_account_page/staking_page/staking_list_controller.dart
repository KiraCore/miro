import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_validators/request/query_validators_req.dart';
import 'package:miro/infra/services/api/query_validators_service.dart';
import 'package:miro/infra/services/api_kira/query_staking_pool_service.dart';
import 'package:miro/infra/services/cache/favourites_cache_service.dart';
import 'package:miro/shared/controllers/menu/my_account_page/staking_page/staking_model.dart';
import 'package:miro/shared/models/staking_pool/staking_pool_model.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class StakingListController implements IListController<StakingModel> {
  final FavouritesCacheService favouritesCacheService = FavouritesCacheService(domainName: 'staking');
  final QueryValidatorsService _queryValidatorsService = globalLocator<QueryValidatorsService>();
  final QueryStakingPoolService _queryStakingPoolService = globalLocator<QueryStakingPoolService>();

  @override
  FavouritesCacheService getFavouritesCacheService() {
    return favouritesCacheService;
  }

  @override
  Future<List<StakingModel>> getFavouritesData() async {
    List<ValidatorModel> validatorModelList = await getFavouritesValidatorsData();
    return getStakingModelList(validatorModelList);
  }

  @override
  Future<List<StakingModel>> getPageData(int pageIndex, int offset, int limit) async {
    List<ValidatorModel> validatorModelList = await getValidatorPageData(pageIndex, offset, limit);
    return getStakingModelList(validatorModelList);
  }

  Future<List<StakingModel>> getStakingModelList(List<ValidatorModel> validatorModelList) async {
    List<StakingModel> stakingModelList = <StakingModel>[];
    for (ValidatorModel validatorModel in validatorModelList) {
      StakingPoolModel stakingPoolModel = await _queryStakingPoolService.getStakingPoolModel(WalletAddress.fromBech32(validatorModel.address));
      stakingModelList.add(StakingModel(validatorModel: validatorModel, stakingPoolModel: stakingPoolModel));
    }
    return stakingModelList;
  }

  Future<List<ValidatorModel>> getFavouritesValidatorsData() async {
    Set<String> favouriteAddresses = favouritesCacheService.getAll();
    if (favouriteAddresses.isNotEmpty) {
      List<ValidatorModel> remoteFavourites = await _queryValidatorsService.getValidatorsByAddresses(favouriteAddresses.toList());
      return remoteFavourites;
    }
    return List<ValidatorModel>.empty(growable: true);
  }

  Future<List<ValidatorModel>> getValidatorPageData(int pageIndex, int offset, int limit) async {
    List<ValidatorModel> validatorList = await _queryValidatorsService.getValidatorsList(
      QueryValidatorsReq(
        offset: '$offset',
        limit: '$limit',
      ),
    );
    return validatorList.toList();
  }
}
