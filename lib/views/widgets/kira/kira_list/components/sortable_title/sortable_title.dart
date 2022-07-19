import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/a_list_bloc.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/specific_blocs/list/sort/events/sort_change_event.dart';
import 'package:miro/blocs/specific_blocs/list/sort/sort_bloc.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';
import 'package:miro/views/widgets/kira/kira_list/components/sortable_title/sort_icon.dart';
import 'package:miro/views/widgets/kira/kira_list/models/sort_option_model.dart';

class SortableTitle<T extends AListItem, B extends AListBloc<T>> extends StatelessWidget {
  final SortOptionModel<T>? sortOptionModel;

  const SortableTitle({
    required this.sortOptionModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              if (sortOptionModel != null) ...<Widget>[
                Text(sortOptionModel!.title),
                const SizedBox(width: 8),
                if (_wantDisplaySortOption(context, states))
                  SizedBox(
                    width: 20,
                    child: SortIcon<T, B>(
                      sortOption: sortOptionModel!.sortOption,
                    ),
                  ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _onSortClicked(BuildContext context) {
    if (sortOptionModel == null) {
      return;
    }
    SortBloc<T> sortOptionBloc = BlocProvider.of<SortBloc<T>>(context);
    if (sortOptionBloc.state.activeSortOption.id == sortOptionModel!.sortOption.id) {
      sortOptionBloc.add(SortChangeEvent<T>(sortOption: sortOptionBloc.state.activeSortOption.reversed()));
    } else {
      sortOptionBloc.add(SortChangeEvent<T>(sortOption: sortOptionModel!.sortOption));
    }
  }

  bool _wantDisplaySortOption(BuildContext context, Set<MaterialState> states) {
    bool notNull = sortOptionModel != null;
    bool isHovering = states.contains(MaterialState.hovered);
    bool isActive = BlocProvider.of<SortBloc<T>>(context).state.activeSortOption.id == sortOptionModel?.sortOption.id;

    return notNull && (isHovering || isActive);
  }
}
