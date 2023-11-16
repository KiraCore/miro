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
import 'package:miro/blocs/widgets/kira/kira_list/infinity_list/infinity_list_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/sort_bloc.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/infinity_list/sliver_infinity_list/sliver_infinity_list_content.dart';
import 'package:miro/views/widgets/kira/kira_list/sliver_list_background.dart';
import 'package:miro/views/widgets/kira/kira_list/sliver_list_layout.dart';

class SliverInfinityList<T extends AListItem> extends StatefulWidget {
  final Widget Function(T item) itemBuilder;
  final IListController<T> listController;
  final ScrollController scrollController;
  final int singlePageSize;
  final bool hasBackgroundBool;
  final Widget? listHeaderWidget;
  final Widget? title;
  final FavouritesBloc<T>? favouritesBloc;
  final FiltersBloc<T>? filtersBloc;
  final SortBloc<T>? sortBloc;

  SliverInfinityList({
    required this.itemBuilder,
    required this.listController,
    ScrollController? scrollController,
    this.singlePageSize = 20,
    this.hasBackgroundBool = true,
    this.listHeaderWidget,
    this.title,
    this.favouritesBloc,
    this.filtersBloc,
    this.sortBloc,
    Key? key,
  })  : scrollController = scrollController ?? ScrollController(),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _SliverInfinityList<T>();
}

class _SliverInfinityList<T extends AListItem> extends State<SliverInfinityList<T>> {
  late InfinityListBloc<T> infinityListBloc = InfinityListBloc<T>(
    listController: widget.listController,
    singlePageSize: widget.singlePageSize,
    favouritesBloc: widget.favouritesBloc,
    filterBloc: widget.filtersBloc,
    sortBloc: widget.sortBloc,
  );

  @override
  void dispose() {
    infinityListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        if (widget.filtersBloc != null) BlocProvider<FiltersBloc<T>>.value(value: widget.filtersBloc!),
        if (widget.sortBloc != null) BlocProvider<SortBloc<T>>.value(value: widget.sortBloc!),
        if (widget.favouritesBloc != null) BlocProvider<FavouritesBloc<T>>.value(value: widget.favouritesBloc!),
        BlocProvider<InfinityListBloc<T>>.value(value: infinityListBloc),
      ],
      child: ValueListenableBuilder<bool>(
        valueListenable: infinityListBloc.showLoadingOverlay,
        builder: (_, bool loadingOverlayVisibleBool, __) {
          return BlocBuilder<InfinityListBloc<T>, AListState>(
            bloc: infinityListBloc,
            builder: (BuildContext context, AListState state) {
              bool staticLoadingIndicatorBool = state is ListLoadedState<T> && state.listItems.length > widget.singlePageSize;

              return SliverListLayout(
                staticLoadingIndicatorBool: staticLoadingIndicatorBool || ResponsiveWidget.isLargeScreen(context) == false,
                loadingOverlayVisibleBool: loadingOverlayVisibleBool || state is ListLoadingState,
                titleBuilder: widget.title != null ? (_) => widget.title! : null,
                lastBlockDateTime: state is ListLoadedState<T> ? state.blockDateTime : null,
                cacheExpirationDateTime: state is ListLoadedState<T> ? state.cacheExpirationDateTime : null,
                onRefresh: () => infinityListBloc.add(const ListReloadEvent(forceRequestBool: true, listContentVisibleBool: true)),
                content: <Widget>[
                  if (state is ListLoadingState)
                    const SliverListBackground()
                  else if (state is ListLoadedState<T> && state.listItems.isEmpty)
                    SliverListBackground(
                      child: Center(
                        child: Text(
                          S.of(context).errorNoResults,
                          style: textTheme.bodySmall?.copyWith(color: DesignColors.white2),
                        ),
                      ),
                    )
                  else if (state is ListLoadedState<T>)
                    SliverInfinityListContent<T>(
                      isLastPage: state.lastPage,
                      hasBackground: widget.hasBackgroundBool,
                      items: state.listItems,
                      itemBuilder: widget.itemBuilder,
                      scrollController: widget.scrollController,
                      listHeaderWidget: widget.listHeaderWidget,
                    )
                  else if (state is ListErrorState)
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
      ),
    );
  }
}
