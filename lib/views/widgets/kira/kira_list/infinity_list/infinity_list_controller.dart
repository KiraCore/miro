import 'package:flutter/cupertino.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/specific_blocs/list/infinity_list/events/infinity_list_reached_bottom_event.dart';
import 'package:miro/blocs/specific_blocs/list/infinity_list/infinity_list_bloc.dart';

class InfinityListController<T extends AListItem> {
  final double nextPageActivatorOffset;
  final InfinityListBloc<T> infinityListBloc;
  final ScrollController scrollController;

  List<T> items;
  double previousMaxScrollOffset = 0;

  InfinityListController({
    required this.nextPageActivatorOffset,
    required this.infinityListBloc,
    required this.scrollController,
    required this.items,
  });

  void init() {
    scrollController.addListener(_fetchDataAfterReachedMax);
  }

  void dispose() {
    scrollController.removeListener(_fetchDataAfterReachedMax);
  }

  void updateItems(List<T> newItems) {
    if (items.length != newItems.length) {
      items = newItems;
      previousMaxScrollOffset = scrollController.position.maxScrollExtent;
    }
  }

  void _fetchDataAfterReachedMax() {
    double currentOffset = scrollController.offset;
    double maxOffset = scrollController.position.maxScrollExtent - nextPageActivatorOffset;
    bool reachedMax = currentOffset >= maxOffset;
    if (reachedMax && previousMaxScrollOffset != maxOffset) {
      previousMaxScrollOffset = maxOffset;
      infinityListBloc.add(InfinityListReachedBottomEvent());
    }
  }
}
