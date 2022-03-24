import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/shared/models/list/filter_option.dart';
import 'package:miro/shared/models/list/sort_option.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';
import 'package:miro/views/widgets/generic/pagination_toolbar.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/date_range_picker_dropdown.dart';
import 'package:miro/views/widgets/kira/kira_list/filter_dropdown.dart';
import 'package:miro/views/widgets/kira/kira_list/list_search_bar.dart';
import 'package:miro/views/widgets/kira/kira_list/sort_dropdown.dart';
import 'package:provider/provider.dart';

typedef ListItemBuilder<E> = Widget Function(E item);

enum KiraListType {
  paginated,
  infinity,
}

class ListActions<E> {
  final bool sortWidgetEnabled;
  final bool filterWidgetEnabled;
  final bool searchWidgetEnabled;
  final bool dateFilterWidgetEnabled;

  final List<SortOption<E>>? sortOptions;
  final List<FilterOption<E>>? filterOptions;
  final SearchCallback<E>? searchCallback;
  final DatePickedCallback? onDatePicked;

  final Widget? customWidget;

  bool get hasActions {
    return sortWidgetEnabled ||
        filterWidgetEnabled ||
        searchWidgetEnabled ||
        dateFilterWidgetEnabled ||
        customWidget != null;
  }

  bool get hasDatePicker {
    return dateFilterWidgetEnabled && onDatePicked != null;
  }

  bool get hasSortDropdown {
    return sortWidgetEnabled && sortOptions != null;
  }

  bool get hasFilterDropdown {
    return filterWidgetEnabled && sortOptions != null;
  }

  bool get hasSearchBar {
    return searchWidgetEnabled && searchCallback != null;
  }

  const ListActions({
    this.searchCallback,
    this.customWidget,
    this.sortOptions,
    this.filterOptions,
    this.onDatePicked,
    this.sortWidgetEnabled = false,
    this.searchWidgetEnabled = false,
    this.filterWidgetEnabled = false,
    this.dateFilterWidgetEnabled = false,
  })  : assert(
          !sortWidgetEnabled || (sortWidgetEnabled && sortOptions != null),
          'If sort widget is enabled, sort options must be provided',
        ),
        assert(
          !filterWidgetEnabled || (filterWidgetEnabled && filterOptions != null),
          'If filter widget is enabled, filter options must be provided',
        ),
        assert(
          !searchWidgetEnabled || (searchWidgetEnabled && searchCallback != null),
          'If search widget is enabled, search callback must be provided',
        ),
        assert(
          !dateFilterWidgetEnabled || (dateFilterWidgetEnabled && onDatePicked != null),
          'If date filter widget is enabled, date picked callback must be provided',
        );
}

class KiraList<E, T extends ListBloc<E>> extends StatelessWidget {
  final ListItemBuilder<E> itemBuilder;
  final Color? backgroundColor;
  final bool shrinkWrap;
  final ScrollController scrollController;
  final Widget? columnHeadersWidget;
  final KiraListType listType;
  final ListActions<E> listActions;

  const KiraList({
    required this.scrollController,
    required this.listType,
    required this.itemBuilder,
    required this.listActions,
    this.columnHeadersWidget,
    this.backgroundColor,
    this.shrinkWrap = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _KiraListLayout(
      header: listActions.hasActions
          ? _KiraListHeader<E, T>(
              listActions: listActions,
            )
          : null,
      body: BlocBuilder<T, ListState>(builder: (_, ListState state) {
        if (state is ListEmptyState<E>) {
          return const _ListEmptyWidget();
        } else if (state is ListLoadedState<E>) {
          if (listType == KiraListType.paginated) {
            return _PaginatedListContent<E, T>(
              scrollController: scrollController,
              items: state.pageListItems,
              itemBuilder: itemBuilder,
              backgroundColor: backgroundColor,
              currentPageIndex: state.currentPageIndex,
              maxPageIndex: state.maxPagesIndex,
              columnHeadersWidget: columnHeadersWidget,
            );
          } else {
            return _InfinityListContent<E, T>(
              scrollController: scrollController,
              items: state.itemsFromStart,
              itemBuilder: itemBuilder,
              backgroundColor: backgroundColor,
              listEndStatus: state.listEndStatus,
            );
          }
        } else if (state is ListErrorState) {
          return const _ListErrorWidget();
        } else {
          return const _ListLoadingWidget();
        }
      }),
    );
  }
}

class _KiraListHeader<E, T extends ListBloc<E>> extends StatelessWidget {
  final ListActions<E> listActions;

  const _KiraListHeader({
    required this.listActions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: _KiraListHeaderDesktop<E, T>(
        listActions: listActions,
      ),
      mediumScreen: _KiraListHeaderMobile<E, T>(
        listActions: listActions,
      ),
    );
  }
}

class _KiraListHeaderDesktop<E, T extends ListBloc<E>> extends StatelessWidget {
  final ListActions<E> listActions;

  const _KiraListHeaderDesktop({
    required this.listActions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (listActions.hasDatePicker)
          DateRangePickerDropdown(
            onDatePicked: listActions.onDatePicked!,
          ),
        if (listActions.hasSortDropdown)
          SortDropdown<E, T>(
            sortOptions: listActions.sortOptions!,
          ),
        if (listActions.customWidget != null)
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                listActions.customWidget!,
                const SizedBox(width: 15),
              ],
            ),
          )
        else
          const Spacer(),
        if (listActions.hasFilterDropdown)
          FilterDropdown<E, T>(
            filterOptions: listActions.filterOptions!,
          ),
        if (listActions.hasSearchBar) ListSearchBar<E, T>(searchCallback: listActions.searchCallback!),
      ],
    );
  }
}

class _KiraListHeaderMobile<E, T extends ListBloc<E>> extends StatelessWidget {
  final ListActions<E> listActions;

  const _KiraListHeaderMobile({
    required this.listActions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (listActions.hasSearchBar)
          SizedBox(
            width: double.infinity,
            child: ListSearchBar<E, T>(searchCallback: listActions.searchCallback!),
          ),
        if (listActions.hasDatePicker) ...<Widget>[
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: DateRangePickerDropdown(
              onDatePicked: listActions.onDatePicked!,
            ),
          ),
        ],
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (listActions.hasSortDropdown)
              SortDropdown<E, T>(
                sortOptions: listActions.sortOptions!,
              ),
            if (listActions.customWidget != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  listActions.customWidget!,
                ],
              ),
            if (listActions.hasFilterDropdown)
              FilterDropdown<E, T>(
                filterOptions: listActions.filterOptions!,
              ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _KiraListLayout extends StatelessWidget {
  final Widget body;
  final Widget? header;

  const _KiraListLayout({
    required this.body,
    this.header,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (header != null) header!,
        const SizedBox(height: 15),
        _LastUpdateInfoWidget(),
        const SizedBox(height: 10),
        Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 440,
          ),
          child: body, // your column
        ),
      ],
    );
  }
}

class _LastUpdateInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
      builder: (_, __, ___) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Last updated:',
              style: TextStyle(
                fontSize: 13,
                color: DesignColors.gray2_100,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _getLastUpdateTime(),
              style: const TextStyle(
                fontSize: 12,
                color: DesignColors.white_100,
              ),
            ),
          ],
        );
      },
    );
  }

  String _getLastUpdateTime() {
    NetworkProvider networkProvider = globalLocator<NetworkProvider>();
    String? latestBlockTimeString = networkProvider.networkModel?.queryInterxStatus?.syncInfo.latestBlockTime;
    if (latestBlockTimeString != null) {
      try {
        DateTime latestBlockTime = DateTime.parse(latestBlockTimeString).toLocal();
        String formattedDate = DateFormat('HH:mm dd.MM.yyyy').format(latestBlockTime);
        return formattedDate;
      } catch (_) {
        AppLogger().log(message: 'Error while parsing latest bloc time: $latestBlockTimeString');
      }
    }
    return '---';
  }
}

class _PaginatedListContent<E, T extends ListBloc<E>> extends StatelessWidget {
  final Set<E> items;
  final Color? backgroundColor;
  final ListItemBuilder<E> itemBuilder;
  final int currentPageIndex;
  final int maxPageIndex;
  final ScrollController scrollController;
  final Widget? columnHeadersWidget;

  const _PaginatedListContent({
    required this.items,
    required this.itemBuilder,
    required this.backgroundColor,
    required this.currentPageIndex,
    required this.maxPageIndex,
    required this.scrollController,
    this.columnHeadersWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int additionalItemsBefore = 0;
    int itemsLength = items.length;
    if (columnHeadersWidget != null) {
      itemsLength += 1;
      additionalItemsBefore += 1;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
                itemCount: itemsLength,
                padding: const EdgeInsets.only(bottom: 10),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, int index) {
                  if (index == 0 && columnHeadersWidget != null) {
                    return columnHeadersWidget!;
                  }
                  return itemBuilder(items.elementAt(index - additionalItemsBefore));
                }),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        PaginationToolbar(
          onPageChanged: (int index) {
            scrollController.jumpTo(0);
            BlocProvider.of<T>(context).add(GoToPageEvent(index - 1));
          },
          currentPage: currentPageIndex + 1,
          totalPage: maxPageIndex + 1,
        ),
      ],
    );
  }
}

class _InfinityListContent<E, T extends ListBloc<E>> extends StatefulWidget {
  final Set<E> items;
  final Color? backgroundColor;
  final bool listEndStatus;
  final ListItemBuilder<E> itemBuilder;
  final ScrollController scrollController;

  const _InfinityListContent({
    required this.items,
    required this.listEndStatus,
    required this.itemBuilder,
    required this.scrollController,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InfinityListContentState<E, T>();
}

class _InfinityListContentState<E, T extends ListBloc<E>> extends State<_InfinityListContent<E, T>> {
  bool downloadingPageStatus = false;

  @override
  void initState() {
    widget.scrollController.addListener(_fetchDataAfterReachedMax);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int finalListLength = widget.items.length;
    if (!widget.listEndStatus) {
      finalListLength += 1;
    }
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.builder(
        controller: ScrollController(),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: finalListLength,
        itemBuilder: (BuildContext context, int index) {
          if (!widget.listEndStatus && index == finalListLength - 1) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: SpinKitThreeBounce(
                size: 15,
                color: Colors.white,
              ),
            );
          }
          E item = widget.items.elementAt(index);
          return widget.itemBuilder(item);
        },
      ),
    );
  }

  Future<void> _fetchDataAfterReachedMax() async {
    if (!mounted) {
      return;
    }
    T listBloc = BlocProvider.of<T>(context);
    if (downloadingPageStatus) {
      return;
    }
    bool reachedMax = widget.scrollController.offset > widget.scrollController.position.maxScrollExtent - 100;
    if (reachedMax) {
      ListState listState = BlocProvider.of<T>(context).state;
      if (listState is ListLoadedState && listBloc.currentPage < listState.maxPagesIndex) {
        downloadingPageStatus = true;
        listBloc.currentPage++;
        BlocProvider.of<T>(context).add(GoToPageEvent(listBloc.currentPage));
        await Future<void>.delayed(const Duration(milliseconds: 500));
        downloadingPageStatus = false;
      }
    }
  }
}

class _ListEmptyWidget extends StatelessWidget {
  const _ListEmptyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No results'),
    );
  }
}

class _ListErrorWidget extends StatelessWidget {
  const _ListErrorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Icon(
          Icons.wifi_off,
          size: 40,
          color: DesignColors.red_100,
        ),
        SizedBox(height: 20),
        Text(
          'No interx connection specified',
          style: TextStyle(
            color: DesignColors.red_100,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _ListLoadingWidget extends StatelessWidget {
  const _ListLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CenterLoadSpinner();
  }
}
