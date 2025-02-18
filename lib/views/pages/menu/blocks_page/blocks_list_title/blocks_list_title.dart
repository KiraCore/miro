import 'package:flutter/material.dart';
import 'package:miro/shared/controllers/menu/blocks_page/blocks_list_controller.dart';
import 'package:miro/views/pages/menu/blocks_page/blocks_list_title/blocks_list_title_desktop.dart';
import 'package:miro/views/pages/menu/blocks_page/blocks_list_title/blocks_list_title_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class BlockListTile extends StatelessWidget {
  final int pageSize;
  final ValueChanged<int> pageSizeValueChanged;
  final TextEditingController searchBarTextEditingController;
  final BlocksListController blocksListController;

  const BlockListTile({
    required this.pageSize,
    required this.pageSizeValueChanged,
    required this.searchBarTextEditingController,
    required this.blocksListController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: BlockListTitleDesktop(
        pageSize: pageSize,
        pageSizeValueChanged: pageSizeValueChanged,
        searchBarTextEditingController: searchBarTextEditingController,
        blocksListController: blocksListController,
      ),
      mediumScreen: BlockListTitleMobile(
        pageSize: pageSize,
        pageSizeValueChanged: pageSizeValueChanged,
        searchBarTextEditingController: searchBarTextEditingController,
        // blocksListController: blocksListController, //todo
      ),
    );
  }
}
