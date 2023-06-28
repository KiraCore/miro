import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/kira/kira_list/list_no_results_widget.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverPaginatedListContent<T extends AListItem> extends StatefulWidget {
  final bool isLastPage;
  final bool hasBackground;
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final ScrollController scrollController;
  final Widget? listHeaderWidget;

  const SliverPaginatedListContent({
    required this.isLastPage,
    required this.hasBackground,
    required this.items,
    required this.itemBuilder,
    required this.scrollController,
    this.listHeaderWidget,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SliverPaginatedListContent<T>();
}

class _SliverPaginatedListContent<T extends AListItem> extends State<SliverPaginatedListContent<T>> {
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
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: widget.hasBackground ? DesignColors.black : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: widget.items.length + _additionalStartItemsCount,
                  (_, int index) {
                    if (index == 0 && widget.listHeaderWidget != null) {
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
            ],
          ),
      ],
    );
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
