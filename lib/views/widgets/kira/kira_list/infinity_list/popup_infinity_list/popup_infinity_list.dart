import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/a_list_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/states/list_error_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/states/list_loaded_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/states/list_loading_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/favourites/favourites_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/filters_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/infinity_list/infinity_list_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/models/sort_option.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/sort_bloc.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_search_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/infinity_list/popup_infinity_list/popup_infinity_list_content.dart';

class PopupInfinityList<T extends AListItem> extends StatefulWidget {
  final SortOption<T> defaultSortOption;
  final Widget Function(T item) itemBuilder;
  final IListController<T> listController;
  final SearchComparator<T> searchComparator;
  final int singlePageSize;
  final String? searchBarTitle;

  const PopupInfinityList({
    required this.defaultSortOption,
    required this.itemBuilder,
    required this.listController,
    required this.searchComparator,
    this.singlePageSize = 20,
    this.searchBarTitle,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopupInfinityList<T>();
}

class _PopupInfinityList<T extends AListItem> extends State<PopupInfinityList<T>> {
  late FavouritesBloc<T> favouritesBloc = FavouritesBloc<T>(listController: widget.listController);
  late FiltersBloc<T> filtersBloc = FiltersBloc<T>(searchComparator: widget.searchComparator);
  late SortBloc<T> sortBloc = SortBloc<T>(defaultSortOption: widget.defaultSortOption);
  late InfinityListBloc<T> infinityListBloc = InfinityListBloc<T>(
    listController: widget.listController,
    singlePageSize: widget.singlePageSize,
    favouritesBloc: favouritesBloc,
    filterBloc: filtersBloc,
    sortBloc: sortBloc,
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<FiltersBloc<T>>(lazy: false, create: (BuildContext context) => filtersBloc),
        BlocProvider<SortBloc<T>>(lazy: false, create: (BuildContext context) => sortBloc),
        BlocProvider<FavouritesBloc<T>>(lazy: false, create: (BuildContext context) => favouritesBloc),
        BlocProvider<InfinityListBloc<T>>(lazy: false, create: (BuildContext context) => infinityListBloc),
      ],
      child: ValueListenableBuilder<bool>(
        valueListenable: infinityListBloc.showLoadingOverlay,
        builder: (_, bool showLoadingOverlay, __) {
          return Opacity(
            opacity: showLoadingOverlay ? 0.3 : 1,
            child: BlocBuilder<InfinityListBloc<T>, AListState>(
              bloc: infinityListBloc,
              builder: (BuildContext context, AListState state) {
                return Column(
                  children: <Widget>[
                    ListSearchWidget<T>(
                      width: double.infinity,
                      hint: widget.searchBarTitle,
                      enabled: state is ListLoadedState<T>,
                    ),
                    const SizedBox(height: 8),
                    if (state is ListLoadingState)
                      const Expanded(child: CenterLoadSpinner())
                    else if (state is ListLoadedState<T>)
                      Expanded(
                        child: PopupInfinityListContent<T>(
                          isLastPage: state.lastPage,
                          itemBuilder: widget.itemBuilder,
                          items: state.listItems.toList(),
                        ),
                      )
                    else if (state is ListErrorState)
                      Expanded(
                        child: Center(
                          child: Text(S.of(context).errorCannotFetchData),
                        ),
                      ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
