import 'package:miro/blocs/abstract_blocs/list_data_cubit/list_data_cubit.dart';
import 'package:miro/infra/cache/favourite_cache.dart';
import 'package:miro/infra/dto/api/query_validators/request/query_validators_req.dart';
import 'package:miro/infra/services/api/query_validators_service.dart';
import 'package:miro/shared/models/validators/validator_model.dart';

class ValidatorsListCubit extends ListDataCubit<ValidatorModel> {
  final QueryValidatorsService queryValidatorsService;

  final FavouriteCache favouriteCache = FavouriteCache(key: 'validators');

  ValidatorsListCubit({
    required this.queryValidatorsService,
  });

  @override
  FavouriteCache getFavouriteCache() {
    return favouriteCache;
  }

  @override
  Future<List<ValidatorModel>> getFavouritesData() async {
    List<String> favouriteAddresses = favouriteCache.getAll();
    if (favouriteAddresses.isNotEmpty) {
      List<ValidatorModel> remoteFavourites = await queryValidatorsService.getValidatorsByAddresses(favouriteAddresses);
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
