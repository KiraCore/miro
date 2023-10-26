import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/a_list_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/states/list_error_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/states/list_loaded_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/states/list_loading_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/favourites/favourites_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/filters_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/paginated_list/events/paginated_list_next_page_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/paginated_list/events/paginated_list_previous_page_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/paginated_list/paginated_list_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/paginated_list/states/paginated_list_loaded_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/sort_bloc.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:miro/views/widgets/kira/kira_list/list_error_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/list_loading_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/sliver_paginated_list/pagination_bar.dart';
import 'package:miro/views/widgets/kira/kira_list/sliver_paginated_list/sliver_paginated_list_content.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverPaginatedList<T extends AListItem> extends StatefulWidget {
  final Widget Function(T item) itemBuilder;
  final IListController<T> listController;
  final ScrollController scrollController;
  final int singlePageSize;
  final bool hasBackgroundBool;
  final Widget? listHeaderWidget;
  final WidgetBuilder? titleBuilder;
  final FavouritesBloc<T>? favouritesBloc;
  final FiltersBloc<T>? filtersBloc;
  final SortBloc<T>? sortBloc;

  SliverPaginatedList({
    required this.itemBuilder,
    required this.listController,
    ScrollController? scrollController,
    this.singlePageSize = 20,
    this.hasBackgroundBool = true,
    this.listHeaderWidget,
    this.titleBuilder,
    this.favouritesBloc,
    this.filtersBloc,
    this.sortBloc,
    Key? key,
  })  : scrollController = scrollController ?? ScrollController(),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _SliverPaginatedList<T>();
}

class _SliverPaginatedList<T extends AListItem> extends State<SliverPaginatedList<T>> {
  late PaginatedListBloc<T> paginatedListBloc = PaginatedListBloc<T>(
    listController: widget.listController,
    singlePageSize: widget.singlePageSize,
    favouritesBloc: widget.favouritesBloc,
    filterBloc: widget.filtersBloc,
    sortBloc: widget.sortBloc,
  );

  @override
  void dispose() {
    paginatedListBloc.close();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SliverPaginatedList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.singlePageSize != widget.singlePageSize) {
      paginatedListBloc = PaginatedListBloc<T>(
        listController: widget.listController,
        singlePageSize: widget.singlePageSize,
        favouritesBloc: widget.favouritesBloc,
        filterBloc: widget.filtersBloc,
        sortBloc: widget.sortBloc,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        if (widget.filtersBloc != null) BlocProvider<FiltersBloc<T>>.value(value: widget.filtersBloc!),
        if (widget.sortBloc != null) BlocProvider<SortBloc<T>>.value(value: widget.sortBloc!),
        if (widget.favouritesBloc != null) BlocProvider<FavouritesBloc<T>>.value(value: widget.favouritesBloc!),
        BlocProvider<PaginatedListBloc<T>>.value(value: paginatedListBloc),
      ],
      child: ValueListenableBuilder<bool>(
        valueListenable: paginatedListBloc.showLoadingOverlay,
        builder: (_, bool showLoadingOverlay, __) {
          return SliverOpacity(
            opacity: showLoadingOverlay ? 0.5 : 1,
            sliver: BlocBuilder<PaginatedListBloc<T>, AListState>(
              bloc: paginatedListBloc,
              builder: (BuildContext context, AListState state) {
                return BlocBuilder<PaginatedListBloc<T>, AListState>(
                  bloc: paginatedListBloc,
                  builder: (BuildContext context, AListState state) {
                    return MultiSliver(
                      children: <Widget>[
                        if (widget.titleBuilder != null)
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 32),
                              child: Opacity(
                                opacity: state is ListLoadedState ? 1 : 0.5,
                                child: state is ListLoadedState ? widget.titleBuilder!(context) : IgnorePointer(child: widget.titleBuilder!(context)),
                              ),
                            ),
                          ),
                        if (state is ListLoadingState)
                          const SliverFillRemaining(
                            hasScrollBody: false,
                            child: ListLoadingWidget(),
                          )
                        else if (state is PaginatedListLoadedState<T>) ...<Widget>[
                          SliverPaginatedListContent<T>(
                            isLastPage: state.lastPage,
                            hasBackground: widget.hasBackgroundBool,
                            items: state.listItems,
                            itemBuilder: widget.itemBuilder,
                            scrollController: widget.scrollController,
                            listHeaderWidget: widget.listHeaderWidget,
                          ),
                          SliverPadding(
                            padding: const ResponsiveValue<EdgeInsets>(
                              largeScreen: EdgeInsets.only(bottom: 30, top: 20),
                              smallScreen: EdgeInsets.only(bottom: 30, top: 5),
                            ).get(context),
                            sliver: SliverToBoxAdapter(
                              child: PaginationBar(
                                lastPageBool: state.lastPage,
                                pageIndex: state.pageIndex,
                                onNextPageSelected: () => paginatedListBloc.add(PaginatedListNextPageEvent()),
                                onPreviousPageSelected: () => paginatedListBloc.add(PaginatedListPreviousPageEvent()),
                              ),
                            ),
                          ),
                        ] else if (state is ListErrorState)
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
                );
              },
            ),
          );
        },
      ),
    );
  }
}
