import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/infinity_list_bloc/infinity_list_bloc.dart';
import 'package:miro/blocs/abstract_blocs/infinity_list_bloc/infinity_list_event/updated_favourite_list_event.dart';
import 'package:miro/blocs/abstract_blocs/infinity_list_bloc/infinity_list_state/infinity_list_state.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/list_state.dart';
import 'package:miro/blocs/specific_blocs/lists/validators_list_bloc/validators_filter_options.dart';
import 'package:miro/blocs/specific_blocs/lists/validators_list_bloc/validators_sort_options.dart';
import 'package:miro/infra/cache/favourite_cache.dart';
import 'package:miro/infra/dto/api/query_validators/request/query_validators_req.dart';
import 'package:miro/infra/services/api/query_validators_service.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/shared/models/list/filter_option.dart';
import 'package:miro/shared/models/list/sort_option.dart';
import 'package:miro/shared/models/validators/validator_model.dart';

class ValidatorsListBloc extends InfinityListBloc<ValidatorModel> {
  static String favouriteCacheKey = 'validators';
  final QueryValidatorsService queryValidatorsService;
  @override
  final int pageSize;

  ValidatorsListBloc.init({
    required NetworkProvider networkProvider,
    required this.queryValidatorsService,
    this.pageSize = 20,
  }) : super.init(networkProvider: networkProvider) {
    on<UpdatedFavouriteListEvent>(_mapUpdatedFavouriteListEventEventToState);
  }

  @override
  SortOption<ValidatorModel> get defaultSortOption => ValidatorsSortOptions.sortByTop;

  FavouriteCache favouriteCache = FavouriteCache(key: favouriteCacheKey);
  Set<ValidatorModel> favouriteValidators = <ValidatorModel>{};

  void _mapUpdatedFavouriteListEventEventToState(UpdatedFavouriteListEvent event, Emitter<ListState> emit) {
    scrolledIndex = 1;
    if (state is InfinityListLoadedState) {
      notifyListUpdated(emit);
    }
  }

  @override
  Future<void> onListInitialized() async {
    await _setupFavouriteValidators();
  }

  @override
  Future<List<ValidatorModel>> fetchPageData(int pageIndex, int offset, int limit) async {
    List<ValidatorModel> validatorList = await queryValidatorsService.getValidatorsList(
      QueryValidatorsReq(
        offset: '$offset',
        limit: '$limit',
      ),
    );
    return validatorList.toList();
  }

  @override
  FilterComparator<ValidatorModel>? getSearchComparator(String searchText) {
    return ValidatorsFilterOptions.search(searchText);
  }

  @override
  List<ValidatorModel> getSortedList(List<ValidatorModel> listItems) {
    Set<ValidatorModel> uniqueItems = <ValidatorModel>{
      ...activeSortOption.sort(getFilteredList(favouriteValidators.toList())),
      ...activeSortOption.sort(listItems),
    };
    return uniqueItems.toList();
  }

  void addFavourite(ValidatorModel validator) {
    validator.favourite = true;
    favouriteValidators.add(validator);
    favouriteCache.add(validator.address);
    add(UpdatedFavouriteListEvent());
  }

  void removeFavourite(ValidatorModel validator) {
    validator.favourite = false;
    favouriteValidators.remove(validator);
    favouriteCache.delete(validator.address);
    add(UpdatedFavouriteListEvent());
  }

  Future<void> _setupFavouriteValidators() async {
    List<String> favouriteAddresses = favouriteCache.getAll();
    if (favouriteAddresses.isNotEmpty) {
      List<ValidatorModel> remoteFavourites = await queryValidatorsService.getValidatorsByAddresses(favouriteAddresses);
      for (ValidatorModel validatorModel in remoteFavourites) {
        validatorModel.favourite = true;
      }
      favouriteValidators = remoteFavourites.toSet();
    }
  }
}
