import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/list/sort_option.dart';
import 'package:miro/shared/models/list/sorting_status.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';

class SortableTitle<E, T extends ListBloc<E>> extends StatelessWidget {
  final Widget label;
  final SortOption<E>? sortOption;

  const SortableTitle({
    required this.label,
    this.sortOption,
    Key? key,
  }) : super(key: key);

  bool wantDisplaySortOption(BuildContext context, Set<MaterialState> states) {
    bool notNull = sortOption != null;
    bool isHovering = states.contains(MaterialState.hovered);
    bool isActive = BlocProvider.of<T>(context).activeSortOption.name == sortOption?.name;

    return notNull && (isHovering || isActive);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, ListState>(
      builder: (BuildContext context, ListState state) {
        return MouseStateListener(
          cursor: SystemMouseCursors.click,
          childBuilder: (Set<MaterialState> states) {
            return GestureDetector(
              onTap: () => _onSortClicked(context),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: label,
                    ),
                    const SizedBox(width: 8),
                    if (wantDisplaySortOption(context, states))
                      SizedBox(
                        width: 20,
                        child: _SortableIcon<E, T>(
                          sortOption: sortOption!,
                        ),
                      )
                  ],
                ),
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
    T listBloc = BlocProvider.of<T>(context);
    if (listBloc.activeSortOption.name == sortOption!.name) {
      if (listBloc.activeSortOption.sortingStatus == SortingStatus.asc) {
        listBloc.add(SortEvent<E>(sortOption!.copyWith(sortingStatus: SortingStatus.desc)));
      } else {
        listBloc.add(SortEvent<E>(sortOption!.copyWith(sortingStatus: SortingStatus.asc)));
      }
    } else {
      listBloc.add(SortEvent<E>(sortOption!));
    }
  }
}

class _SortableIcon<E, T extends ListBloc<E>> extends StatelessWidget {
  final SortOption<E> sortOption;

  const _SortableIcon({
    required this.sortOption,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    SortOption<E> activeSortOption = BlocProvider.of<T>(context).activeSortOption;
    if (activeSortOption.name == sortOption.name) {
      iconData = activeSortOption.isAscending ? Icons.arrow_upward : Icons.arrow_downward;
    } else {
      iconData = AppIcons.updown;
    }

    return Icon(
      iconData,
      size: 15,
      color: DesignColors.gray2_100,
    );
  }
}
