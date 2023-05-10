import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/widgets/kira/kira_list/infinity_list/infinity_list_bloc.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/kira/kira_list/infinity_list/infinity_list_controller.dart';
import 'package:miro/views/widgets/kira/kira_list/infinity_list/infinity_list_load_indicator.dart';
import 'package:miro/views/widgets/kira/kira_list/list_no_results_widget.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverInfinityListContent<T extends AListItem> extends StatefulWidget {
  final bool isLastPage;
  final bool hasBackground;
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final ScrollController scrollController;
  final Widget? listHeaderWidget;

  const SliverInfinityListContent({
    required this.isLastPage,
    required this.hasBackground,
    required this.items,
    required this.itemBuilder,
    required this.scrollController,
    this.listHeaderWidget,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SliverInfinityListContent<T>();
}

class _SliverInfinityListContent<T extends AListItem> extends State<SliverInfinityListContent<T>> {
  late InfinityListController<T> infinityListController = InfinityListController<T>(
    infinityListBloc: BlocProvider.of<InfinityListBloc<T>>(context),
    nextPageActivatorOffset: 200,
    scrollController: widget.scrollController,
    items: widget.items,
  );

  @override
  void didUpdateWidget(covariant SliverInfinityListContent<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    infinityListController.updateItems(widget.items);
  }

  @override
  void initState() {
    super.initState();
    infinityListController.init();
  }

  @override
  void dispose() {
    infinityListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: <Widget>[
        if (widget.items.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: ListNoResultsWidget(),
          )
        else
          SliverStack(
            insetOnOverlap: false,
            children: <Widget>[
              SliverPositioned.fill(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: widget.hasBackground ? DesignColors.black : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 40),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: _listLength,
                    (_, int index) {
                      if (widget.isLastPage == false && index == _listLength - 1) {
                        return const InfinityListLoadIndicator();
                      } else if (index == 0 && widget.listHeaderWidget != null) {
                        return SizedBox(
                          width: double.infinity,
                          child: widget.listHeaderWidget!,
                        );
                      } else {
                        T item = widget.items[index - _additionalStartItemsCount];
                        return widget.itemBuilder(item);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  int get _listLength {
    int length = widget.items.length + _additionalStartItemsCount;
    if (widget.isLastPage == false) {
      length += 1;
    }
    return length;
  }

  int get _additionalStartItemsCount {
    int additionalItemsCount = 0;
    if (widget.listHeaderWidget != null) {
      additionalItemsCount += 1;
    }
    if (widget.items.isEmpty) {
      additionalItemsCount += 1;
    }
    return additionalItemsCount;
  }
}
