import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/sort_options_bloc/sort_option_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/sort_options_bloc/sort_option_event.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/utils/list/i_list_item.dart';
import 'package:miro/shared/utils/list/sort_option.dart';
import 'package:miro/views/widgets/generic/pop_wrapper.dart';
import 'package:miro/views/widgets/kira/kira_list/list_pop_menu/list_pop_menu.dart';
import 'package:miro/views/widgets/kira/kira_list/sort_dropdown/sort_dropdown_button.dart';

class SortDropdown<T extends IListItem> extends StatefulWidget {
  final List<SortOption<T>> sortOptions;

  const SortDropdown({
    required this.sortOptions,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SortOptionWidget<T>();
}

class _SortOptionWidget<T extends IListItem> extends State<SortDropdown<T>> {
  PopWrapperController sortOptionsController = PopWrapperController();
  late SortOption<T> currentSortOption;

  @override
  void initState() {
    currentSortOption = BlocProvider.of<SortOptionBloc<T>>(context).state.activeSortOption;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Text(
          'Sort by',
          style: TextStyle(
            fontSize: 14,
            color: DesignColors.gray2_100,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 110,
          height: 30,
          child: PopWrapper(
            buttonWidth: 100,
            buttonHeight: 30,
            popWrapperController: sortOptionsController,
            buttonBuilder: (AnimationController animationController) {
              return SortDropdownButton(title: currentSortOption.id);
            },
            dropdownMargin: 0,
            decoration: BoxDecoration(
              color: const Color(0xFF12143D),
              borderRadius: BorderRadius.circular(8),
            ),
            popupBuilder: () {
              return ListPopMenu<SortOption<T>>(
                itemToString: (SortOption<T> item) => item.id,
                items: widget.sortOptions,
                onItemSelected: _onPopupItemClicked,
                selectedItems: () => <SortOption<T>>{currentSortOption},
                title: 'Sort by',
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        Opacity(
          opacity: 1,
          child: IconButton(
            onPressed: () => _onChangedSortOption(currentSortOption.reversed()),
            splashRadius: 20,
            icon: const Icon(
              AppIcons.up_down,
              size: 16,
              color: DesignColors.gray2_100,
            ),
          ),
        ),
      ],
    );
  }

  void _onPopupItemClicked(SortOption<T> sortOption) {
    sortOptionsController.hideMenu();
    _onChangedSortOption(sortOption);
  }

  void _onChangedSortOption(SortOption<T> sortOption) {
    setState(() {
      currentSortOption = sortOption;
    });
    BlocProvider.of<SortOptionBloc<T>>(context).add(ChangeSortOptionEvent<T>(sortOption: currentSortOption));
  }
}
