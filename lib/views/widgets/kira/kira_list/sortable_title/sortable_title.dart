import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/sort_event.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/list_state.dart';
import 'package:miro/shared/models/list/sort_option.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';
import 'package:miro/views/widgets/kira/kira_list/sortable_title/sort_icon.dart';

class SortableTitle<ItemType, ListBlocType extends ListBloc<ItemType>> extends StatelessWidget {
  final Widget label;
  final SortOption<ItemType>? sortOption;

  const SortableTitle({
    required this.label,
    this.sortOption,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBlocType, ListState>(
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
                      child: SortIcon<ItemType, ListBlocType>(
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
    ListBlocType listBloc = BlocProvider.of<ListBlocType>(context);
    if (listBloc.activeSortOption.id == sortOption!.id) {
      listBloc.add(SortEvent<ItemType>(listBloc.activeSortOption.reversed()));
    } else {
      listBloc.add(SortEvent<ItemType>(sortOption!));
    }
  }

  bool wantDisplaySortOption(BuildContext context, Set<MaterialState> states) {
    bool notNull = sortOption != null;
    bool isHovering = states.contains(MaterialState.hovered);
    bool isActive = BlocProvider.of<ListBlocType>(context).activeSortOption.id == sortOption?.id;

    return notNull && (isHovering || isActive);
  }
}
