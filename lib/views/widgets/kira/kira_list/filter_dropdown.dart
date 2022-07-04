import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/filter_options_bloc/filter_options_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/filter_options_bloc/filter_options_event.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/list/filter_model.dart';
import 'package:miro/shared/utils/list/i_list_item.dart';
import 'package:miro/views/widgets/generic/pop_wrapper.dart';
import 'package:miro/views/widgets/kira/kira_list/list_pop_menu/list_pop_menu.dart';

const double _kDropdownButtonWidth = 100;
const double _kDropdownButtonHeight = 30;

class FilterDropdown<T extends IListItem> extends StatefulWidget {
  final List<FilterModel<T>> filterOptions;

  const FilterDropdown({
    required this.filterOptions,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FilterOptionWidget<T>();
}

class _FilterOptionWidget<T extends IListItem> extends State<FilterDropdown<T>> {
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
        return ListPopMenu<FilterModel<T>>(
          itemToString: (FilterModel<T> item) => item.name,
          items: widget.filterOptions,
          onItemSelected: _onFilterAdded,
          onItemRemoved: _onFilterRemoved,
          selectedItems: () => widget.filterOptions
              .where((FilterModel<T> e) =>
                  BlocProvider.of<FilterOptionsBloc<T>>(context).state.activeFilters.contains(e.filterOption))
              .toSet(),
          title: 'Filter by',
        );
      },
    );
  }

  void _onFilterAdded(FilterModel<T> filterModel) {
    BlocProvider.of<FilterOptionsBloc<T>>(context).add(AddFilterEvent<T>(filterModel.filterOption));
  }

  void _onFilterRemoved(FilterModel<T> filterModel) {
    BlocProvider.of<FilterOptionsBloc<T>>(context).add(RemoveFilterEvent<T>(filterModel.filterOption));
  }
}
