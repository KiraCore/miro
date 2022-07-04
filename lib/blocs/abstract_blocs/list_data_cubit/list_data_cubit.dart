import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_data_cubit/list_data_state.dart';
import 'package:miro/infra/cache/favourite_cache.dart';
import 'package:miro/shared/utils/list/i_list_item.dart';

abstract class ListDataCubit<T extends IListItem> extends Cubit<ListDataState> {
  ListDataCubit() : super(const ListDataState());

  FavouriteCache getFavouriteCache();

  Future<List<T>> getFavouritesData();

  Future<List<T>> getPageData(int pageIndex, int offset, int limit);
}
