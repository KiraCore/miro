import 'package:flutter/material.dart';
import 'package:miro/views/pages/menu/blocks_page/blocks_list_title/blocks_list_title_desktop.dart';
import 'package:miro/views/pages/menu/blocks_page/blocks_list_title/blocks_list_title_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class BlockListTile extends StatelessWidget {
  final int pageSize;
  final ValueChanged<int> pageSizeValueChanged;
  final TextEditingController searchBarTextEditingController;

  const BlockListTile({
    required this.pageSize,
    required this.pageSizeValueChanged,
    required this.searchBarTextEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: BlockListTitleDesktop(
        pageSize: pageSize,
        pageSizeValueChanged: pageSizeValueChanged,
        searchBarTextEditingController: searchBarTextEditingController,
      ),
      mediumScreen: BlockListTitleMobile(
        pageSize: pageSize,
        pageSizeValueChanged: pageSizeValueChanged,
        searchBarTextEditingController: searchBarTextEditingController,
      ),
    );
  }
}
