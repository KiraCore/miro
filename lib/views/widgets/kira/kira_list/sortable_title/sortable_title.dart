import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/list_state.dart';
import 'package:miro/blocs/specific_blocs/lists/sort_options_bloc/sort_option_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/sort_options_bloc/sort_option_event.dart';
import 'package:miro/shared/utils/list/i_list_item.dart';
import 'package:miro/shared/utils/list/sort_option.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';
import 'package:miro/views/widgets/kira/kira_list/sortable_title/sort_icon.dart';

class SortableTitle<T extends IListItem, B extends ListBloc<T>> extends StatelessWidget {
  final Widget label;
  final SortOption<T>? sortOption;

  const SortableTitle({
    required this.label,
    this.sortOption,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, ListState>(
      builder: (BuildContext context, ListState state) {
        return MouseStateListener(
          mouseCursor: SystemMouseCursors.click,
          onTap: () => _onSortClicked(context),
          disableSplash: true,
          childBuilder: (Set<MaterialState> states) {
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Row(
                children: <Widget>[
                  label,
                  const SizedBox(width: 8),
                  if (wantDisplaySortOption(context, states))
                    SizedBox(
                      width: 20,
                      child: SortIcon<T>(
                        sortOption: sortOption!,
                      ),
                    )
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _onSortClicked(BuildContext context) {
    if (sortOption == null) {
      return;
    }
    SortOptionBloc<T> sortOptionBloc = BlocProvider.of<SortOptionBloc<T>>(context);
    if (sortOptionBloc.state.activeSortOption.id == sortOption!.id) {
      print('sort reversed ${sortOptionBloc.state.activeSortOption.sortingStatus}');
      sortOptionBloc.add(ChangeSortOptionEvent<T>(sortOption: sortOptionBloc.state.activeSortOption.reversed()));
    } else {
      print('sort normal');
      sortOptionBloc.add(ChangeSortOptionEvent<T>(sortOption: sortOption!));
    }
  }

  bool wantDisplaySortOption(BuildContext context, Set<MaterialState> states) {
    bool notNull = sortOption != null;
    bool isHovering = states.contains(MaterialState.hovered);
    bool isActive = BlocProvider.of<SortOptionBloc<T>>(context).state.activeSortOption.id == sortOption?.id;

    return notNull && (isHovering || isActive);
  }
}
