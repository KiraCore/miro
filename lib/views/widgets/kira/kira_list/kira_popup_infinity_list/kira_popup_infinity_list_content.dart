import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/specific_blocs/list/infinity_list/events/infinity_list_reached_bottom_event.dart';
import 'package:miro/blocs/specific_blocs/list/infinity_list/infinity_list_bloc.dart';
import 'package:miro/views/widgets/kira/kira_list/kira_infinity_list/infinity_list_load_indicator.dart';

class KiraPopupInfinityListContent<T extends AListItem> extends StatefulWidget {
  final Widget Function(T item) itemBuilder;
  final List<T> items;
  final bool lastPage;
  final double reachedBottomOffset;
  final String? searchBarTitle;

  const KiraPopupInfinityListContent({
    required this.itemBuilder,
    required this.items,
    required this.lastPage,
    this.reachedBottomOffset = 50,
    this.searchBarTitle,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KiraPopupInfinityListContent<T>();
}

class _KiraPopupInfinityListContent<T extends AListItem> extends State<KiraPopupInfinityListContent<T>> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_fetchDataAfterReachedMax);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: BlocProvider.of<InfinityListBloc<T>>(context).showLoadingOverlay,
      builder: (_, bool showLoadingOverlay, __) {
        return Opacity(
          opacity: showLoadingOverlay ? 0.3 : 1,
          child: ListView.builder(
            itemCount: _listLength,
            itemBuilder: (BuildContext context, int index) {
              if (!widget.lastPage && index == _listLength - 1) {
                return const InfinityListLoadIndicator();
              }
              if (widget.items.isEmpty) {
                return const Text('No results');
              }
              T item = widget.items[index - _additionalStartItemsCount];
              return widget.itemBuilder(item);
            },
          ),
        );
      },
    );
  }

  void _fetchDataAfterReachedMax() {
    if (mounted) {
      double currentOffset = scrollController.offset;
      double maxOffset = scrollController.position.maxScrollExtent - widget.reachedBottomOffset;
      bool reachedMax = currentOffset >= maxOffset;
      if (reachedMax) {
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
    if (widget.items.isEmpty) {
      additionalItemsCount += 1;
    }
    return additionalItemsCount;
  }
}
