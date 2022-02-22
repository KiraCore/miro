import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/pop_wrapper.dart';
import 'package:miro/views/widgets/kira/kira_list/models/sort_option.dart';
import 'package:miro/views/widgets/kira/kira_list/models/sorting_status.dart';
import 'package:miro/views/widgets/kira/kira_list/sort_pop_menu.dart';

class SortOptionWidget<E, T extends ListBloc<E>> extends StatefulWidget {
  final List<SortOption<E>> sortOptions;

  const SortOptionWidget({
    required this.sortOptions,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SortOptionWidget<E, T>();
}

class _SortOptionWidget<E, T extends ListBloc<E>> extends State<SortOptionWidget<E, T>> {
  PopWrapperController sortOptionsController = PopWrapperController();
  late SortOption<E> currentSortOption;

  @override
  void initState() {
    currentSortOption = BlocProvider.of<T>(context).activeSortOption;
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
              return _buildSortButton();
            },
            dropdownMargin: 0,
            decoration: BoxDecoration(
              color: const Color(0xFF12143D),
              borderRadius: BorderRadius.circular(8),
            ),
            popupBuilder: () {
              return SortPopMenu<E, T>(
                sortOptions: widget.sortOptions,
                sortOptionsController: sortOptionsController,
                selectedOption: currentSortOption,
                onChanged: _onPopupItemClicked,
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        Opacity(
          opacity: 1,
          child: IconButton(
            onPressed: () => _onChangedSortOption(currentSortOption, changeSorting: true),
            splashRadius: 20,
            icon: const Icon(
              AppIcons.updown,
              size: 16,
              color: DesignColors.gray2_100,
            ),
          ),
        ),
      ],
    );
  }

  void _onPopupItemClicked(SortOption<E> sortOption) {
    sortOptionsController.hideMenu();
    _onChangedSortOption(sortOption);
  }

  void _onChangedSortOption(SortOption<E> sortOption, {bool changeSorting = false}) {
    SortingStatus sortingStatus = sortOption.sortingStatus;
    if (changeSorting) {
      sortingStatus = currentSortOption.sortingStatus == SortingStatus.asc ? SortingStatus.desc : SortingStatus.asc;
    }
    setState(() {
      currentSortOption = sortOption.copyWith(
        sortingStatus: sortingStatus,
      );
    });
    BlocProvider.of<T>(context).add(SortEvent<E>(currentSortOption));
  }

  Widget _buildSortButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(
          color: DesignColors.gray2_100,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              currentSortOption.name,
              style: const TextStyle(
                fontSize: 13,
                color: DesignColors.gray2_100,
              ),
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.keyboard_arrow_down,
            color: DesignColors.gray2_100,
            size: 15,
          ),
        ],
      ),
    );
  }
}
