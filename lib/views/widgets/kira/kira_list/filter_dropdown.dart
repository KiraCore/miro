import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/add_filter_event.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/remove_filter_event.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/list/filter_model.dart';
import 'package:miro/views/widgets/generic/pop_wrapper.dart';
import 'package:miro/views/widgets/kira/kira_list/list_pop_menu/list_pop_menu.dart';

const double _kDropdownButtonWidth = 100;
const double _kDropdownButtonHeight = 30;

class FilterDropdown<ItemType, ListBlocType extends ListBloc<ItemType>> extends StatefulWidget {
  final List<FilterModel<ItemType>> filterOptions;

  const FilterDropdown({
    required this.filterOptions,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FilterOptionWidget<ItemType, ListBlocType>();
}

class _FilterOptionWidget<ItemType, ListBlocType extends ListBloc<ItemType>>
    extends State<FilterDropdown<ItemType, ListBlocType>> {
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
        return ListPopMenu<FilterModel<ItemType>>(
          itemToString: (FilterModel<ItemType> item) => item.name,
          items: widget.filterOptions,
          onItemSelected: _onFilterAdded,
          onItemRemoved: _onFilterRemoved,
          selectedItems: () => widget.filterOptions
              .where((FilterModel<ItemType> e) =>
                  BlocProvider.of<ListBlocType>(context).activeFilterOptions.contains(e.filterOption))
              .toSet(),
          title: 'Filter by',
        );
      },
    );
  }

  void _onFilterAdded(FilterModel<ItemType> filterModel) {
    BlocProvider.of<ListBlocType>(context).add(AddFilterEvent<ItemType>(filterModel.filterOption));
  }

  void _onFilterRemoved(FilterModel<ItemType> filterModel) {
    BlocProvider.of<ListBlocType>(context).add(RemoveFilterEvent<ItemType>(filterModel.filterOption));
  }
}
