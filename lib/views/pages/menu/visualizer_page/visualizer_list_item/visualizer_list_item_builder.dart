import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/shared/models/visualizer/visualizer_node_model.dart';
import 'package:miro/views/pages/menu/visualizer_page/visualizer_list_item/desktop/visualizer_list_item_desktop.dart';
import 'package:miro/views/pages/menu/visualizer_page/visualizer_list_item/mobile/visualizer_list_item_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class VisualizerListItemBuilder extends StatefulWidget {
  final VisualizerNodeModel visualizerNodeModel;
  final ScrollController scrollController;

  const VisualizerListItemBuilder({
    required this.visualizerNodeModel,
    required this.scrollController,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VisualizerListItemBuilder();
}

class _VisualizerListItemBuilder extends State<VisualizerListItemBuilder> {
  final ValueNotifier<bool> expandNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> hoverNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    Widget desktopListItem = VisualizerListItemDesktop(
      visualizerNodeItemModel: widget.visualizerNodeModel,
    );

    Widget mobileListItem = VisualizerListItemMobile(
      visualizerNodeItemModel: widget.visualizerNodeModel,
    );

    return ResponsiveWidget(
      largeScreen: desktopListItem,
      mediumScreen: mobileListItem,
      smallScreen: mobileListItem,
    );
  }
}
