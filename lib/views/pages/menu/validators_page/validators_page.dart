import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/infinity_list_bloc/infinity_list_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_data_cubit/list_data_cubit.dart';
import 'package:miro/blocs/specific_blocs/lists/filter_options_bloc/filter_options_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/list_favourites_bloc/list_favourites_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/sort_options_bloc/sort_option_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/validators_list_bloc/validators_filter_options.dart';
import 'package:miro/blocs/specific_blocs/lists/validators_list_bloc/validators_list_cubit.dart';
import 'package:miro/blocs/specific_blocs/lists/validators_list_bloc/validators_sort_options.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api/query_validators_service.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/views/layout/footer/footer.dart';
import 'package:miro/views/pages/menu/validators_page/validators_list_item.dart';
import 'package:miro/views/pages/menu/validators_page/validators_list_item_layout.dart';
import 'package:miro/views/pages/menu/validators_page/validators_page_list_title.dart';
import 'package:miro/views/widgets/kira/kira_list/kira_infinity_list.dart';
import 'package:miro/views/widgets/kira/kira_list/sortable_title/sortable_title.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ValidatorsPage extends StatefulWidget {
  const ValidatorsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ValidatorsPage();
}

class _ValidatorsPage extends State<ValidatorsPage> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: AppSizes.defaultDesktopPageMargin,
          child: MultiProvider(
            providers: <SingleChildWidget>[
              BlocProvider<FilterOptionsBloc<ValidatorModel>>(
                lazy: false,
                create: (BuildContext context) => FilterOptionsBloc<ValidatorModel>(
                  searchComparator: ValidatorsFilterOptions.search,
                ),
              ),
              BlocProvider<SortOptionBloc<ValidatorModel>>(
                lazy: false,
                create: (BuildContext context) => SortOptionBloc<ValidatorModel>(
                  defaultSortOption: ValidatorsSortOptions.sortByTop,
                ),
              ),
              BlocProvider<ListDataCubit<ValidatorModel>>(
                lazy: false,
                create: (BuildContext context) => ValidatorsListCubit(
                  queryValidatorsService: globalLocator<QueryValidatorsService>(),
                ),
              ),
              BlocProvider<ListFavouritesBloc<ValidatorModel>>(
                lazy: false,
                create: (BuildContext context) => ListFavouritesBloc<ValidatorModel>(
                  listDataCubit: context.read<ListDataCubit<ValidatorModel>>(),
                ),
              ),
              BlocProvider<InfinityListBloc<ValidatorModel>>(
                lazy: false,
                create: (BuildContext context) => InfinityListBloc<ValidatorModel>(
                  networkProvider: globalLocator<NetworkProvider>(),
                  listDataCubit: context.read<ListDataCubit<ValidatorModel>>(),
                  filterOptionsBloc: context.read<FilterOptionsBloc<ValidatorModel>>(),
                  sortOptionBloc: context.read<SortOptionBloc<ValidatorModel>>(),
                  listFavouritesBloc: context.read<ListFavouritesBloc<ValidatorModel>>(),
                  pageSize: 20,
                ),
              ),
            ],
            child: Column(
              children: <Widget>[
                KiraInfinityList<ValidatorModel>(
                  scrollController: scrollController,
                  minHeight: MediaQuery.of(context).size.height - 300,
                  title: const ValidatorsPageListTitle(),
                  listHeader: ValidatorsListItemLayout(
                    favouriteButtonSection: const SizedBox(width: 25),
                    topSection: SortableTitle<ValidatorModel, InfinityListBloc<ValidatorModel>>(
                      label: const Text('Top'),
                      sortOption: ValidatorsSortOptions.sortByTop,
                    ),
                    monikerSection: SortableTitle<ValidatorModel, InfinityListBloc<ValidatorModel>>(
                      label: const Text('Moniker'),
                      sortOption: ValidatorsSortOptions.sortByMoniker,
                    ),
                    statusSection: SortableTitle<ValidatorModel, InfinityListBloc<ValidatorModel>>(
                      label: const Text('Status'),
                      sortOption: ValidatorsSortOptions.sortByStatus,
                    ),
                  ),
                  itemBuilder: (ValidatorModel item) => ValidatorsListItem(
                    key: Key(item.address),
                    scrollController: scrollController,
                    validatorModel: item,
                  ),
                ),
                const SizedBox(height: 50),
                const Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
