import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/a_list_state.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/states/list_error_state.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/states/list_loaded_state.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/states/list_loading_state.dart';
import 'package:miro/blocs/specific_blocs/list/favourites/favourites_bloc.dart';
import 'package:miro/blocs/specific_blocs/list/filters/filters_bloc.dart';
import 'package:miro/blocs/specific_blocs/list/infinity_list/infinity_list_bloc.dart';
import 'package:miro/blocs/specific_blocs/list/sort/models/sort_option.dart';
import 'package:miro/blocs/specific_blocs/list/sort/sort_bloc.dart';
import 'package:miro/shared/controllers/reload_notifier/reload_notifier_model.dart';
import 'package:miro/views/widgets/kira/kira_list/kira_infinity_list/kira_infinity_list_content.dart';
import 'package:miro/views/widgets/kira/kira_list/kira_list_layout.dart';
import 'package:miro/views/widgets/kira/kira_list/list_error_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/list_loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class KiraInfinityList<T extends AListItem> extends StatelessWidget {
  final SortOption<T> defaultSortOption;
  final Widget Function(T item) itemBuilder;
  final IListController<T> listController;
  final SearchComparator<T> searchComparator;
  final ScrollController scrollController;
  final int singlePageSize;
  final double? minHeight;
  final bool hasBackground;
  final Widget? listHeader;
  final Widget? title;
  final ReloadNotifierModel? reloadNotifierModel;

  KiraInfinityList({
    required this.defaultSortOption,
    required this.itemBuilder,
    required this.listController,
    required this.searchComparator,
    ScrollController? scrollController,
    this.singlePageSize = 20,
    this.minHeight,
    this.hasBackground = true,
    this.listHeader,
    this.title,
    this.reloadNotifierModel,
    Key? key,
  })  : scrollController = scrollController ?? ScrollController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        BlocProvider<FiltersBloc<T>>(
          lazy: false,
          create: (BuildContext context) => FiltersBloc<T>(
            searchComparator: searchComparator,
          ),
        ),
        BlocProvider<SortBloc<T>>(
          lazy: false,
          create: (BuildContext context) => SortBloc<T>(
            defaultSortOption: defaultSortOption,
          ),
        ),
        BlocProvider<FavouritesBloc<T>>(
          lazy: false,
          create: (BuildContext context) => FavouritesBloc<T>(
            listController: listController,
          ),
        ),
        BlocProvider<InfinityListBloc<T>>(
          lazy: false,
          create: (BuildContext context) => InfinityListBloc<T>(
            listController: listController,
            filterBloc: context.read<FiltersBloc<T>>(),
            sortBloc: context.read<SortBloc<T>>(),
            favouritesBloc: context.read<FavouritesBloc<T>>(),
            singlePageSize: singlePageSize,
            reloadNotifierModel: reloadNotifierModel,
          ),
        ),
      ],
      child: KiraListLayout<T, InfinityListBloc<T>>(
        title: title,
        child: Container(
          constraints: BoxConstraints(
            minHeight: minHeight ?? double.infinity,
          ),
          child: BlocBuilder<InfinityListBloc<T>, AListState>(
            builder: (BuildContext context, AListState state) {
              if (state is ListLoadingState) {
                return ListLoadingWidget(minHeight: minHeight);
              } else if (state is ListLoadedState<T>) {
                return KiraInfinityListContent<T>(
                  scrollController: scrollController,
                  itemBuilder: itemBuilder,
                  hasBackground: hasBackground,
                  items: state.listItems.toList(),
                  lastPage: state.lastPage,
                  listHeader: listHeader,
                  minHeight: minHeight,
                );
              } else if (state is ListErrorState) {
                return ListErrorWidget(
                  errorMessage: 'Cannot fetch data',
                  minHeight: minHeight,
                );
              }
              return ListErrorWidget(
                errorMessage: 'Unknown error',
                minHeight: minHeight,
              );
            },
          ),
        ),
      ),
    );
  }
}
