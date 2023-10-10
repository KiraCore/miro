import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/kira/kira_context_menu/kira_context_menu_item.dart';
import 'package:miro/views/widgets/kira/kira_context_menu/kira_context_menu_item_layout.dart';

class KiraContextMenu {
  final BuildContext context;

  KiraContextMenu.of(this.context);

  Future<void> show({
    required List<KiraContextMenuItem> kiraContextMenuItems,
    required Offset position,
  }) async {
    List<PopupMenuItem<int>> popupMenuItemsList = _buildPopupMenuItems(kiraContextMenuItems);
    int? selectedMenuItemIndex = await _showContextMenu(position, popupMenuItemsList);

    if (selectedMenuItemIndex != null) {
      kiraContextMenuItems[selectedMenuItemIndex].onTap();
    }
  }

  List<PopupMenuItem<int>> _buildPopupMenuItems(List<KiraContextMenuItem> kiraContextMenuItems) {
    List<PopupMenuItem<int>> popupMenuItems = List<PopupMenuItem<int>>.empty(growable: true);
    for (int i = 0; i < kiraContextMenuItems.length; i++) {
      popupMenuItems.add(
        PopupMenuItem<int>(
          value: i,
          height: 24,
          child: KiraContextMenuItemLayout(
            iconData: kiraContextMenuItems[i].iconData,
            label: kiraContextMenuItems[i].label,
          ),
        ),
      );
    }
    return popupMenuItems;
  }

  Future<int?> _showContextMenu(Offset position, List<PopupMenuItem<int>> popupMenuItemsList) async {
    RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    return showMenu<int>(
      context: context,
      color: DesignColors.grey2,
      items: popupMenuItemsList,
      position: RelativeRect.fromSize(
        position & const Size(48.0, 24.0),
        overlay.size,
      ),
    );
  }
}
