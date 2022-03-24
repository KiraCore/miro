import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/list/filter_option.dart';
import 'package:miro/views/widgets/generic/pop_wrapper.dart';
import 'package:miro/views/widgets/kira/kira_list/list_pop_menu.dart';

const double _kDropdownButtonWidth = 100;
const double _kDropdownButtonHeight = 30;

class FilterDropdown<E, T extends ListBloc<E>> extends StatefulWidget {
  final List<FilterOption<E>> filterOptions;

  const FilterDropdown({
    required this.filterOptions,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FilterOptionWidget<E, T>();
}

class _FilterOptionWidget<E, T extends ListBloc<E>> extends State<FilterDropdown<E, T>> {
  PopWrapperController sortOptionsController = PopWrapperController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopWrapper(
      buttonWidth: _kDropdownButtonWidth,
      buttonHeight: _kDropdownButtonHeight,
      popWrapperController: sortOptionsController,
      buttonBuilder: (AnimationController animationController) {
        return const Icon(
          AppIcons.filter,
          color: DesignColors.blue1_100,
        );
      },
      dropdownMargin: 0,
      decoration: BoxDecoration(
        color: const Color(0xFF12143D),
        borderRadius: BorderRadius.circular(8),
      ),
      popupBuilder: () {
        return ListPopMenu<FilterOption<E>>(
          itemToString: (FilterOption<E> item) => item.name,
          items: widget.filterOptions,
          onItemSelected: _onFilterAdded,
          onItemRemoved: _onFilterRemoved,
          selectedItems: () => BlocProvider.of<T>(context).activeFilters,
          title: 'Filter by',
        );
      },
    );
  }

  void _onFilterAdded(FilterOption<E> filterOption) {
    BlocProvider.of<T>(context).add(AddFilterEvent<E>(filterOption));
  }

  void _onFilterRemoved(FilterOption<E> filterOption) {
    BlocProvider.of<T>(context).add(RemoveFilterEvent<E>(filterOption));
  }
}
