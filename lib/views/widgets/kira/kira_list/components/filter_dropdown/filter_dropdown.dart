import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/specific_blocs/list/filters/events/filters_add_option_event.dart';
import 'package:miro/blocs/specific_blocs/list/filters/events/filters_remove_option_event.dart';
import 'package:miro/blocs/specific_blocs/list/filters/filters_bloc.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/pop_wrapper.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_pop_menu/list_pop_menu.dart';
import 'package:miro/views/widgets/kira/kira_list/models/filter_option_model.dart';

const double _kDropdownButtonWidth = 100;
const double _kDropdownButtonHeight = 30;

class FilterDropdown<T extends AListItem> extends StatefulWidget {
  final List<FilterOptionModel<T>> filterOptionModels;

  const FilterDropdown({
    required this.filterOptionModels,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FilterOptionWidget<T>();
}

class _FilterOptionWidget<T extends AListItem> extends State<FilterDropdown<T>> {
  PopWrapperController filterOptionsController = PopWrapperController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopWrapper(
      buttonWidth: _kDropdownButtonWidth,
      buttonHeight: _kDropdownButtonHeight,
      popWrapperController: filterOptionsController,
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
        return ListPopMenu<FilterOptionModel<T>>(
          itemToString: (FilterOptionModel<T> filterOptionModel) => filterOptionModel.title,
          listItems: widget.filterOptionModels,
          isMultiSelect: true,
          onItemSelected: _onFilterAdded,
          onItemRemoved: _onFilterRemoved,
          selectedListItems: _getSelectedFilterOptions(),
          title: 'Filter by',
        );
      },
    );
  }

  void _onFilterAdded(FilterOptionModel<T> filterModel) {
    BlocProvider.of<FiltersBloc<T>>(context).add(FiltersAddOptionEvent<T>(filterModel.filterOption));
  }

  void _onFilterRemoved(FilterOptionModel<T> filterModel) {
    BlocProvider.of<FiltersBloc<T>>(context).add(FiltersRemoveOptionEvent<T>(filterModel.filterOption));
  }

  Set<FilterOptionModel<T>> _getSelectedFilterOptions() {
    return widget.filterOptionModels.where((FilterOptionModel<T> filterOptionModel) {
      return BlocProvider.of<FiltersBloc<T>>(context).state.activeFilters.contains(filterOptionModel.filterOption);
    }).toSet();
  }
}
