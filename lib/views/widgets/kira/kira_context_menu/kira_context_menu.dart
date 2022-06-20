import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/kira/kira_context_menu/kira_context_menu_item.dart';
import 'package:miro/views/widgets/kira/kira_context_menu/kira_context_menu_item_layout.dart';

class KiraContextMenu {
  static Future<void> show({
    required BuildContext context,
    required List<KiraContextMenuItem> menuItems,
    required Offset position,
  }) async {
    final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
    List<PopupMenuItem<int>> popupMenuItems = List<PopupMenuItem<int>>.empty(growable: true);
    for (int i = 0; i < menuItems.length; i++) {
      popupMenuItems.add(
        PopupMenuItem<int>(
          value: i,
          height: 24,
          child: KiraContextMenuItemLayout(
            iconData: menuItems[i].iconData,
            label: menuItems[i].label,
          ),
        ),
      );
    }

    final int? selectedMenuItem = await showMenu<int>(
      context: context,
      color: DesignColors.gray2_100,
      items: popupMenuItems,
      position: RelativeRect.fromSize(
        position & const Size(48.0, 24.0),
        overlay.size,
      ),
    );

    if (selectedMenuItem != null) {
      menuItems[selectedMenuItem].onTap();
    }
  }
}
