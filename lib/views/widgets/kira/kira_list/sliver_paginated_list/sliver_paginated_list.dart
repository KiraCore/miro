import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/a_list_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/events/list_reload_event.dart';
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
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/sliver_list_background.dart';
import 'package:miro/views/widgets/kira/kira_list/sliver_list_layout.dart';
import 'package:miro/views/widgets/kira/kira_list/sliver_paginated_list/pagination_bar.dart';
import 'package:miro/views/widgets/kira/kira_list/sliver_paginated_list/sliver_paginated_list_content.dart';

class SliverPaginatedList<T extends AListItem> extends StatefulWidget {
  final int desktopItemHeight;
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
    required this.desktopItemHeight,
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
      paginatedListBloc.close();
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
    TextTheme textTheme = Theme.of(context).textTheme;

    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        if (widget.filtersBloc != null) BlocProvider<FiltersBloc<T>>.value(value: widget.filtersBloc!),
        if (widget.sortBloc != null) BlocProvider<SortBloc<T>>.value(value: widget.sortBloc!),
        if (widget.favouritesBloc != null) BlocProvider<FavouritesBloc<T>>.value(value: widget.favouritesBloc!),
        BlocProvider<PaginatedListBloc<T>>.value(value: paginatedListBloc),
      ],
      child: ValueListenableBuilder<bool>(
        valueListenable: paginatedListBloc.showLoadingOverlay,
        builder: (_, bool loadingOverlayVisibleBool, __) {
          return BlocBuilder<PaginatedListBloc<T>, AListState>(
            bloc: paginatedListBloc,
            builder: (BuildContext context, AListState state) {
              return BlocBuilder<PaginatedListBloc<T>, AListState>(
                bloc: paginatedListBloc,
                builder: (BuildContext context, AListState state) {
                  int visibleElements = MediaQuery.of(context).size.height ~/ widget.desktopItemHeight;
                  bool staticLoadingIndicatorBool = state is ListLoadedState<T> && state.listItems.length > visibleElements;

                  return SliverListLayout(
                    staticLoadingIndicatorBool: staticLoadingIndicatorBool || ResponsiveWidget.isLargeScreen(context) == false,
                    loadingOverlayVisibleBool: loadingOverlayVisibleBool || state is ListLoadingState,
                    titleBuilder: widget.titleBuilder,
                    lastBlockDateTime: state is ListLoadedState<T> ? state.blockDateTime : null,
                    cacheExpirationDateTime: state is ListLoadedState<T> ? state.cacheExpirationDateTime : null,
                    onRefresh: () => paginatedListBloc.add(const ListReloadEvent(forceRequestBool: true, listContentVisibleBool: true)),
                    content: <Widget>[
                      if (state is ListLoadingState)
                        const SliverListBackground()
                      else if (state is PaginatedListLoadedState<T> && state.listItems.isEmpty)
                        SliverListBackground(
                          child: Center(
                            child: Text(
                              S.of(context).errorNoResults,
                              style: textTheme.bodySmall?.copyWith(color: DesignColors.white2),
                            ),
                          ),
                        )
                      else if (state is PaginatedListLoadedState<T>) ...<Widget>[
                        SliverPaginatedListContent<T>(
                          hasBackground: widget.hasBackgroundBool,
                          items: state.listItems,
                          itemBuilder: widget.itemBuilder,
                          listHeaderWidget: widget.listHeaderWidget,
                        ),
                        SliverPadding(
                          padding: const ResponsiveValue<EdgeInsets>(
                            largeScreen: EdgeInsets.only(bottom: 30, top: 20),
                            smallScreen: EdgeInsets.only(bottom: 30, top: 5),
                          ).get(context),
                          sliver: SliverToBoxAdapter(
                            child: IgnorePointer(
                              ignoring: loadingOverlayVisibleBool,
                              child: PaginationBar(
                                lastPageBool: state.lastPage,
                                pageIndex: state.pageIndex,
                                onNextPageSelected: () => paginatedListBloc.add(PaginatedListNextPageEvent()),
                                onPreviousPageSelected: () => paginatedListBloc.add(PaginatedListPreviousPageEvent()),
                              ),
                            ),
                          ),
                        ),
                      ] else if (state is ListErrorState)
                        SliverListBackground(
                          child: Center(
                            child: Text(
                              S.of(context).errorCannotFetchData,
                              style: textTheme.bodySmall?.copyWith(color: DesignColors.redStatus1),
                            ),
                          ),
                        )
                      else
                        SliverListBackground(
                          child: Center(
                            child: Text(
                              S.of(context).errorUnknown,
                              style: textTheme.bodySmall?.copyWith(color: DesignColors.redStatus1),
                            ),
                          ),
                        )
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
