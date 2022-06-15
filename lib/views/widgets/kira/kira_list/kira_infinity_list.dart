import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/infinity_list_bloc/infinity_list_bloc.dart';
import 'package:miro/blocs/abstract_blocs/infinity_list_bloc/infinity_list_event/reached_bottom_infinity_list_event.dart';
import 'package:miro/blocs/abstract_blocs/infinity_list_bloc/infinity_list_state/infinity_list_state.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/list_loading_state.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/list_state.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/no_interx_connection_state.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/kira/kira_list/kira_list_layout.dart';
import 'package:miro/views/widgets/kira/kira_list/list_error_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/list_loading_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/loading_more_widget.dart';

const double kReachedBottomOffset = 200;

class KiraInfinityList<ItemType, ListBlocType extends InfinityListBloc<ItemType>> extends StatelessWidget {
  final Widget Function(ItemType item) itemBuilder;
  final ScrollController scrollController;
  final Widget? title;
  final Widget? listHeader;
  final double? minHeight;

  KiraInfinityList({
    required this.itemBuilder,
    ScrollController? scrollController,
    this.title,
    this.listHeader,
    this.minHeight,
    Key? key,
  })  : scrollController = scrollController ?? ScrollController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return KiraListLayout<ItemType, ListBlocType>(
      title: title,
      child: Container(
        constraints: BoxConstraints(
          minHeight: minHeight ?? double.infinity,
        ),
        child: BlocBuilder<ListBlocType, ListState>(
          builder: (BuildContext context, ListState state) {
            if (state is ListLoadingState) {
              return const ListLoadingWidget();
            } else if (state is InfinityListLoadedState) {
              return _KiraInfinityListContent<ItemType, ListBlocType>(
                scrollController: scrollController,
                itemBuilder: itemBuilder,
                items: state.data.toList() as List<ItemType>,
                lastPage: state.lastPage,
                listHeader: listHeader,
              );
            } else if (state is NoInterxConnectionState) {
              return const ListErrorWidget(errorMessage: 'No interx connection');
            }
            return const ListErrorWidget(errorMessage: 'Unknown error');
          },
        ),
      ),
    );
  }
}

class _KiraInfinityListContent<ItemType, ListBlocType extends InfinityListBloc<ItemType>> extends StatefulWidget {
  final ScrollController scrollController;
  final Widget Function(ItemType item) itemBuilder;
  final List<ItemType> items;
  final bool lastPage;
  final Widget? listHeader;

  const _KiraInfinityListContent({
    required this.scrollController,
    required this.itemBuilder,
    required this.items,
    required this.lastPage,
    required this.listHeader,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KiraInfinityListContentState<ItemType, ListBlocType>();
}

class _KiraInfinityListContentState<ItemType, ListBlocType extends InfinityListBloc<ItemType>>
    extends State<_KiraInfinityListContent<ItemType, ListBlocType>> {
  @override
  void initState() {
    widget.scrollController.addListener(_fetchDataAfterReachedMax);
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_fetchDataAfterReachedMax);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: BlocProvider.of<ListBlocType>(context).showLoadingOverlay,
      builder: (_, bool showLoadingOverlay, __) {
        return Opacity(
          opacity: showLoadingOverlay ? 0.3 : 1,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: DesignColors.blue1_10,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listLength,
              itemBuilder: (BuildContext context, int index) {
                if (!widget.lastPage && index == listLength - 1) {
                  return const LoadingMoreWidget();
                }
                if (index == 0 && widget.listHeader != null) {
                  return SizedBox(
                    width: double.infinity,
                    child: widget.listHeader!,
                  );
                }
                if (widget.items.isEmpty) {
                  return const SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: Center(
                      child: Text('No results'),
                    ),
                  );
                }
                ItemType item = widget.items[index - additionalStartItemsCount];
                return widget.itemBuilder(item);
              },
            ),
          ),
        );
      },
    );
  }

  void _fetchDataAfterReachedMax() {
    if (mounted) {
      double currentOffset = widget.scrollController.offset;
      double maxOffset = widget.scrollController.position.maxScrollExtent - kReachedBottomOffset;
      bool reachedMax = currentOffset >= maxOffset;
      if (reachedMax) {
        BlocProvider.of<ListBlocType>(context).add(ReachedBottomInfinityListEvent());
      }
    }
  }

  int get listLength {
    int length = widget.items.length + additionalStartItemsCount;
    if (!widget.lastPage) {
      length += 1;
    }
    return length;
  }

  int get additionalStartItemsCount {
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
