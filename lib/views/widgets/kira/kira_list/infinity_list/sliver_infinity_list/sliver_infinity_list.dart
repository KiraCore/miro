import 'package:flutter/material.dart';
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
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/reload_notifier/reload_notifier_model.dart';
import 'package:miro/views/widgets/kira/kira_list/infinity_list/sliver_infinity_list/sliver_infinity_list_content.dart';
import 'package:miro/views/widgets/kira/kira_list/list_error_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/list_loading_widget.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverInfinityList<T extends AListItem> extends StatefulWidget {
  final SortOption<T> defaultSortOption;
  final Widget Function(T item) itemBuilder;
  final IListController<T> listController;
  final SearchComparator<T> searchComparator;
  final ScrollController scrollController;
  final int singlePageSize;
  final bool hasBackground;
  final Widget? listHeaderWidget;
  final Widget? title;
  final ReloadNotifierModel? reloadNotifierModel;

  SliverInfinityList({
    required this.defaultSortOption,
    required this.itemBuilder,
    required this.listController,
    required this.searchComparator,
    ScrollController? scrollController,
    this.singlePageSize = 20,
    this.hasBackground = true,
    this.listHeaderWidget,
    this.title,
    this.reloadNotifierModel,
    Key? key,
  })  : scrollController = scrollController ?? ScrollController(),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _SliverInfinityList<T>();
}

class _SliverInfinityList<T extends AListItem> extends State<SliverInfinityList<T>> {
  late FavouritesBloc<T> favouritesBloc = FavouritesBloc<T>(listController: widget.listController);
  late FiltersBloc<T> filtersBloc = FiltersBloc<T>(searchComparator: widget.searchComparator);
  late SortBloc<T> sortBloc = SortBloc<T>(defaultSortOption: widget.defaultSortOption);
  late InfinityListBloc<T> infinityListBloc = InfinityListBloc<T>(
    listController: widget.listController,
    singlePageSize: widget.singlePageSize,
    favouritesBloc: favouritesBloc,
    filterBloc: filtersBloc,
    sortBloc: sortBloc,
    reloadNotifierModel: widget.reloadNotifierModel,
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
          return SliverOpacity(
            opacity: showLoadingOverlay ? 0.5 : 1,
            sliver: BlocBuilder<InfinityListBloc<T>, AListState>(
              bloc: infinityListBloc,
              builder: (BuildContext context, AListState state) {
                return MultiSliver(
                  children: <Widget>[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 32),
                        child: Opacity(
                          opacity: state is ListLoadedState ? 1 : 0.5,
                          child: state is ListLoadedState ? widget.title : IgnorePointer(child: widget.title),
                        ),
                      ),
                    ),
                    if (state is ListLoadingState)
                      const SliverFillRemaining(
                        hasScrollBody: false,
                        child: ListLoadingWidget(),
                      )
                    else if (state is ListLoadedState<T>)
                      SliverInfinityListContent<T>(
                        isLastPage: state.lastPage,
                        hasBackground: widget.hasBackground,
                        items: state.listItems,
                        itemBuilder: widget.itemBuilder,
                        scrollController: widget.scrollController,
                        listHeaderWidget: widget.listHeaderWidget,
                      )
                    else if (state is ListErrorState)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: ListErrorWidget(errorMessage: S.of(context).errorCannotFetchData),
                      )
                    else
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: ListErrorWidget(errorMessage: S.of(context).errorUnknown),
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
