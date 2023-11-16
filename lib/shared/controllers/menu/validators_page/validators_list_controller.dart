import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_validators/request/query_validators_req.dart';
import 'package:miro/infra/services/api/query_validators_service.dart';
import 'package:miro/infra/services/cache/favourites_cache_service.dart';
import 'package:miro/shared/models/list/pagination_details_model.dart';
import 'package:miro/shared/models/validators/validator_model.dart';

class ValidatorsListController implements IListController<ValidatorModel> {
  final FavouritesCacheService favouritesCacheService = FavouritesCacheService(domainName: 'validators');
  final QueryValidatorsService queryValidatorsService = globalLocator<QueryValidatorsService>();

  @override
  FavouritesCacheService getFavouritesCacheService() {
    return favouritesCacheService;
  }

  @override
  Future<List<ValidatorModel>> getFavouritesData({bool forceRequestBool = false}) async {
    Set<String> favouriteAddresses = favouritesCacheService.getAll();
    if (favouriteAddresses.isNotEmpty) {
      List<ValidatorModel> remoteFavourites = await queryValidatorsService.getValidatorsByAddresses(
        favouriteAddresses.toList(),
        forceRequestBool: forceRequestBool,
      );
      return remoteFavourites;
    }
    return List<ValidatorModel>.empty(growable: true);
  }

  @override
  Future<PageData<ValidatorModel>> getPageData(PaginationDetailsModel paginationDetailsModel, {bool forceRequestBool = false}) async {
    PageData<ValidatorModel> validatorsPageData = await queryValidatorsService.getValidatorsList(
      QueryValidatorsReq(
        limit: paginationDetailsModel.limit,
        offset: paginationDetailsModel.offset,
      ),
      forceRequestBool: forceRequestBool,
    );
    return validatorsPageData;
  }
}
