import 'package:flutter/material.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/pop_wrapper.dart';
import 'package:miro/views/widgets/kira/kira_list/models/sort_option.dart';

class SortPopMenu<E, T extends ListBloc<E>> extends StatelessWidget {
  final PopWrapperController sortOptionsController;
  final List<SortOption<E>> sortOptions;
  final void Function(SortOption<E>) onChanged;
  final SortOption<E>? selectedOption;

  const SortPopMenu({
    required this.sortOptionsController,
    required this.sortOptions,
    required this.onChanged,
    required this.selectedOption,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      margin: EdgeInsets.zero,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          const ListTile(
            title: Text(
              'Sort by',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          ...sortOptions.map<Widget>((SortOption<E> e) {
            return ListTile(
              onTap: () => _onChangedSortOption(e),
              title: Text(
                e.name,
                style: const TextStyle(color: DesignColors.gray2_100, fontSize: 14),
              ),
              trailing: _getTrailing(e),
            );
          }).toList(),
        ],
      ),
    );
  }

  void _onChangedSortOption(SortOption<E> item) {
    onChanged(item);
  }

  Widget? _getTrailing(SortOption<E> option) {
    if (selectedOption != null) {
      if (selectedOption == option) {
        return const Icon(
          AppIcons.done,
          color: DesignColors.blue1_100,
          size: 12,
        );
      }
    }
    return null;
  }
}
