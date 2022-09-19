import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/a_list_state.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/states/list_error_state.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/states/list_loaded_state.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/states/list_loading_state.dart';
import 'package:miro/blocs/specific_blocs/list/favourites/favourites_bloc.dart';
import 'package:miro/blocs/specific_blocs/list/filters/filters_bloc.dart';
import 'package:miro/blocs/specific_blocs/list/infinity_list/infinity_list_bloc.dart';
import 'package:miro/blocs/specific_blocs/list/sort/models/sort_option.dart';
import 'package:miro/blocs/specific_blocs/list/sort/sort_bloc.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_search_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/kira_popup_infinity_list/kira_popup_infinity_list_content.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class KiraPopupInfinityList<T extends AListItem> extends StatelessWidget {
  final SortOption<T> defaultSortOption;
  final Widget Function(T item) itemBuilder;
  final IListController<T> listController;
  final SearchComparator<T> searchComparator;
  final int singlePageSize;
  final String? searchBarTitle;

  const KiraPopupInfinityList({
    required this.defaultSortOption,
    required this.itemBuilder,
    required this.listController,
    required this.searchComparator,
    this.searchBarTitle,
    this.singlePageSize = 20,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        BlocProvider<FiltersBloc<T>>(
          lazy: false,
          create: (BuildContext context) => FiltersBloc<T>(
            searchComparator: searchComparator,
          ),
        ),
        BlocProvider<SortBloc<T>>(
          lazy: false,
          create: (BuildContext context) => SortBloc<T>(
            defaultSortOption: defaultSortOption,
          ),
        ),
        BlocProvider<FavouritesBloc<T>>(
          lazy: false,
          create: (BuildContext context) => FavouritesBloc<T>(
            listController: listController,
          ),
        ),
        BlocProvider<InfinityListBloc<T>>(
          lazy: false,
          create: (BuildContext context) => InfinityListBloc<T>(
            listController: listController,
            filterBloc: context.read<FiltersBloc<T>>(),
            sortBloc: context.read<SortBloc<T>>(),
            favouritesBloc: context.read<FavouritesBloc<T>>(),
            singlePageSize: singlePageSize,
          ),
        ),
      ],
      child: BlocBuilder<InfinityListBloc<T>, AListState>(
        builder: (BuildContext context, AListState state) {
          return Column(
            children: <Widget>[
              ListSearchWidget<T>(
                width: double.infinity,
                hint: searchBarTitle,
                enabled: state is ListLoadedState<T>,
              ),
              const SizedBox(height: 8),
              if (state is ListLoadingState)
                const Expanded(child: CenterLoadSpinner())
              else if (state is ListLoadedState<T>)
                Expanded(
                    child: KiraPopupInfinityListContent<T>(
                  searchBarTitle: searchBarTitle,
                  itemBuilder: itemBuilder,
                  items: state.listItems.toList(),
                  lastPage: state.lastPage,
                ))
              else if (state is ListErrorState)
                const Expanded(child: Center(child: Text('Cannot fetch data'))),
            ],
          );
        },
      ),
    );
  }
}
