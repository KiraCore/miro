import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_controller.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_pop_menu/list_pop_menu.dart';
import 'package:miro/views/widgets/kira/kira_list/sliver_paginated_list/page_size_dropdown/page_size_dropdown_button.dart';

class PageSizeDropdown extends StatefulWidget {
  final int selectedPageSize;
  final List<int> availablePageSizes;
  final ValueChanged<int> onPageSizeChanged;

  const PageSizeDropdown({
    required this.selectedPageSize,
    required this.availablePageSizes,
    required this.onPageSizeChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PageSizeDropdown();
}

class _PageSizeDropdown extends State<PageSizeDropdown> {
  final PopWrapperController popWrapperController = PopWrapperController();

  @override
  Widget build(BuildContext context) {
    return PopWrapper(
      popWrapperController: popWrapperController,
      buttonBuilder: () => PageSizeDropdownButton(
        selectedPageSize: widget.selectedPageSize,
        onTap: popWrapperController.showTooltip,
      ),
      popupBuilder: () {
        return ListPopMenu<int>(
          isMultiSelect: false,
          itemToString: (int item) => item.toString(),
          listItems: widget.availablePageSizes,
          onItemSelected: _handlePageSizeSelected,
          selectedListItems: <int>{widget.selectedPageSize},
          title: S.of(context).paginatedListPageSize,
        );
      },
    );
  }

  void _handlePageSizeSelected(int pageSize) {
    widget.onPageSizeChanged(pageSize);
    popWrapperController.hideTooltip();
  }
}
