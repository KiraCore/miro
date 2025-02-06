import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/shared/models/blocks/block_model.dart';
import 'package:miro/views/pages/menu/blocks_page/blocks_list_item/desktop/blocks_list_item_desktop.dart';
import 'package:miro/views/pages/menu/blocks_page/blocks_list_item/mobile/blocks_list_item_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class BlocksListItemBuilder extends StatefulWidget {
  final BlockModel blockModel;
  final ScrollController scrollController;

  const BlocksListItemBuilder({
    required this.blockModel,
    required this.scrollController,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BlocksListItemBuilder();
}

class _BlocksListItemBuilder extends State<BlocksListItemBuilder> {
  final ValueNotifier<bool> expandNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> hoverNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    Widget desktopListItem = BlocksListItemDesktop(
      blockModel: widget.blockModel,
    );

    Widget mobileListItem = BlocksListItemMobile(
      blockModel: widget.blockModel,
    );

    return ResponsiveWidget(
      largeScreen: desktopListItem,
      mediumScreen: mobileListItem,
      smallScreen: mobileListItem,
    );
  }
}
