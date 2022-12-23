import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/specific_blocs/list/infinity_list/events/infinity_list_reached_bottom_event.dart';
import 'package:miro/blocs/specific_blocs/list/infinity_list/infinity_list_bloc.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/kira/kira_list/kira_infinity_list/infinity_list_load_indicator.dart';
import 'package:miro/views/widgets/kira/kira_list/list_no_results_widget.dart';

class KiraInfinityListContent<T extends AListItem> extends StatefulWidget {
  final ScrollController scrollController;
  final Widget Function(T item) itemBuilder;
  final List<T> items;
  final bool lastPage;
  final double? minHeight;
  final Widget? listHeader;

  const KiraInfinityListContent({
    required this.scrollController,
    required this.itemBuilder,
    required this.items,
    required this.lastPage,
    this.minHeight,
    this.listHeader,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KiraInfinityListContent<T>();
}

class _KiraInfinityListContent<T extends AListItem> extends State<KiraInfinityListContent<T>> {
  final double nextPageActivatorOffset = 200;
  double previousMaxScrollOffset = 0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_fetchDataAfterReachedMax);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_fetchDataAfterReachedMax);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: BlocProvider.of<InfinityListBloc<T>>(context).showLoadingOverlay,
      builder: (_, bool showLoadingOverlay, __) {
        return Opacity(
          opacity: showLoadingOverlay ? 0.3 : 1,
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: DesignColors.blue1_10,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _listLength,
                  itemBuilder: (BuildContext context, int index) {
                    if (!widget.lastPage && index == _listLength - 1) {
                      return const InfinityListLoadIndicator();
                    }
                    if (index == 0 && widget.listHeader != null) {
                      return SizedBox(
                        width: double.infinity,
                        child: widget.listHeader!,
                      );
                    }
                    if (widget.items.isEmpty) {
                      return ListNoResultsWidget(minHeight: widget.minHeight);
                    }
                    T item = widget.items[index - _additionalStartItemsCount];
                    return widget.itemBuilder(item);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  void _fetchDataAfterReachedMax() {
    if (mounted) {
      double currentOffset = widget.scrollController.offset;
      double maxOffset = widget.scrollController.position.maxScrollExtent - nextPageActivatorOffset;
      bool reachedMax = currentOffset >= maxOffset;
      if (reachedMax && previousMaxScrollOffset != maxOffset) {
        previousMaxScrollOffset = maxOffset;
        BlocProvider.of<InfinityListBloc<T>>(context).add(InfinityListReachedBottomEvent());
      }
    }
  }

  int get _listLength {
    int length = widget.items.length + _additionalStartItemsCount;
    if (!widget.lastPage) {
      length += 1;
    }
    return length;
  }

  int get _additionalStartItemsCount {
    int additionalItemsCount = 0;
    if (widget.listHeader != null) {
      additionalItemsCount += 1;
    }
    if (widget.items.isEmpty) {
      additionalItemsCount += 1;
    }
    return additionalItemsCount;
  }
}
