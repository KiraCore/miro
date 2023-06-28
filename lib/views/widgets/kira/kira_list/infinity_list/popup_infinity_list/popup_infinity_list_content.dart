import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/widgets/kira/kira_list/infinity_list/infinity_list_bloc.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/kira/kira_list/infinity_list/infinity_list_controller.dart';
import 'package:miro/views/widgets/kira/kira_list/infinity_list/infinity_list_load_indicator.dart';

class PopupInfinityListContent<T extends AListItem> extends StatefulWidget {
  final bool isLastPage;
  final Widget Function(T item) itemBuilder;
  final ScrollController scrollController;
  final List<T> items;
  final double nextPageActivatorOffset;

  const PopupInfinityListContent({
    required this.isLastPage,
    required this.itemBuilder,
    required this.scrollController,
    required this.items,
    this.nextPageActivatorOffset = 50,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopupInfinityListContent<T>();
}

class _PopupInfinityListContent<T extends AListItem> extends State<PopupInfinityListContent<T>> {
  late InfinityListController<T> infinityListController = InfinityListController<T>(
    infinityListBloc: BlocProvider.of<InfinityListBloc<T>>(context),
    nextPageActivatorOffset: widget.nextPageActivatorOffset,
    scrollController: widget.scrollController,
    items: widget.items,
  );

  @override
  void didUpdateWidget(covariant PopupInfinityListContent<T> oldWidget) {
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
    return ListView.builder(
      controller: widget.scrollController,
      itemCount: _listLength,
      itemBuilder: (BuildContext context, int index) {
        if (widget.isLastPage == false && index == _listLength - 1) {
          return const InfinityListLoadIndicator();
        }
        if (widget.items.isEmpty) {
          return Text(S.of(context).errorNoResults);
        }
        T item = widget.items[index - _additionalStartItemsCount];
        return widget.itemBuilder(item);
      },
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
    if (widget.items.isEmpty) {
      additionalItemsCount += 1;
    }
    return additionalItemsCount;
  }
}
