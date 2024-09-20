import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_undelegations/request/query_undelegations_req.dart';
import 'package:miro/infra/services/api_kira/query_undelegations_service.dart';
import 'package:miro/infra/services/cache/favourites_cache_service.dart';
import 'package:miro/shared/models/list/pagination_details_model.dart';
import 'package:miro/shared/models/undelegations/undelegation_model.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';

class UndelegationListController implements IListController<UndelegationModel> {
  final FavouritesCacheService _favouritesCacheService = FavouritesCacheService(domainName: 'undelegations');
  final QueryUndelegationsService _queryUndelegationsService = globalLocator<QueryUndelegationsService>();
  final AWalletAddress walletAddress;

  UndelegationListController({
    required this.walletAddress,
  });

  @override
  FavouritesCacheService getFavouritesCacheService() {
    return _favouritesCacheService;
  }

  @override
  Future<List<UndelegationModel>> getFavouritesData({bool forceRequestBool = false}) async {
    return List<UndelegationModel>.empty(growable: true);
  }

  @override
  Future<PageData<UndelegationModel>> getPageData(PaginationDetailsModel paginationDetailsModel, {bool forceRequestBool = false}) async {
    PageData<UndelegationModel> undelegationPageData = await _queryUndelegationsService.getUndelegationModelList(
      QueryUndelegationsReq(
        undelegatorAddress: walletAddress.address,
        offset: paginationDetailsModel.offset,
        limit: paginationDetailsModel.limit,
      ),
      forceRequestBool: forceRequestBool,
    );
    return undelegationPageData;
  }
}
