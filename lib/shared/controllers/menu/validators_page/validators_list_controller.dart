import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_validators/request/query_validators_req.dart';
import 'package:miro/infra/services/api/query_validators_service.dart';
import 'package:miro/infra/services/cache/favourites_cache_service.dart';
import 'package:miro/shared/models/validators/validator_model.dart';

class ValidatorsListController implements IListController<ValidatorModel> {
  final FavouritesCacheService favouritesCacheService = FavouritesCacheService(domainName: 'validators');
  final QueryValidatorsService queryValidatorsService = globalLocator<QueryValidatorsService>();

  @override
  FavouritesCacheService getFavouritesCacheService() {
    return favouritesCacheService;
  }

  @override
  Future<List<ValidatorModel>> getFavouritesData() async {
    Set<String> favouriteAddresses = favouritesCacheService.getAll();
    if (favouriteAddresses.isNotEmpty) {
      List<ValidatorModel> remoteFavourites = await queryValidatorsService.getValidatorsByAddresses(favouriteAddresses.toList());
      return remoteFavourites;
    }
    return List<ValidatorModel>.empty(growable: true);
  }

  @override
  Future<List<ValidatorModel>> getPageData(int pageIndex, int offset, int limit) async {
    List<ValidatorModel> validatorList = await queryValidatorsService.getValidatorsList(
      QueryValidatorsReq(
        offset: '$offset',
        limit: '$limit',
      ),
    );
    return validatorList.toList();
  }
}
