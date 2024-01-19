import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_delegations/request/query_delegations_req.dart';
import 'package:miro/infra/services/api_kira/query_delegations_service.dart';
import 'package:miro/infra/services/cache/favourites_cache_service.dart';
import 'package:miro/shared/models/delegations/validator_staking_model.dart';
import 'package:miro/shared/models/list/pagination_details_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class StakingListController implements IListController<ValidatorStakingModel> {
  final FavouritesCacheService _favouritesCacheService = FavouritesCacheService(domainName: 'staking');
  final QueryDelegationsService _queryDelegationsService = globalLocator<QueryDelegationsService>();
  final WalletAddress walletAddress;

  StakingListController({
    required this.walletAddress,
  });

  @override
  FavouritesCacheService getFavouritesCacheService() {
    return _favouritesCacheService;
  }

  @override
  Future<List<ValidatorStakingModel>> getFavouritesData({bool forceRequestBool = false}) async {
    return List<ValidatorStakingModel>.empty(growable: true);
  }

  @override
  Future<PageData<ValidatorStakingModel>> getPageData(PaginationDetailsModel paginationDetailsModel, {bool forceRequestBool = false}) async {
    PageData<ValidatorStakingModel> stakingPageData = await _queryDelegationsService.getValidatorStakingModelList(
      QueryDelegationsReq(
        delegatorAddress: walletAddress.bech32Address,
        offset: paginationDetailsModel.offset,
        limit: paginationDetailsModel.limit,
      ),
      forceRequestBool: forceRequestBool,
    );
    return stakingPageData;
  }
}
