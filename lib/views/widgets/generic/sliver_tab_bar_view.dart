import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverTabBarView extends StatefulWidget {
  final List<Widget> children;
  final TabController tabController;
  final bool lazyLoadBool;
  final bool maintainStateBool;

  const SliverTabBarView({
    required this.children,
    required this.tabController,
    this.lazyLoadBool = true,
    this.maintainStateBool = true,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SliverTabBarView();
}

class _SliverTabBarView extends State<SliverTabBarView> {
  late int tabIndex = widget.tabController.index;
  late List<Widget> childrenWithKeys = KeyedSubtree.ensureUniqueKeysForList(widget.children);
  late Map<int, bool> pageVisibilityMap = <int, bool>{
    ...childrenWithKeys.asMap().map<int, bool>((int index, _) => MapEntry<int, bool>(index, widget.lazyLoadBool == false)),
  };

  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(_handleTabChanged);
  }

  @override
  void dispose() {
    widget.tabController.removeListener(_handleTabChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.maintainStateBool == false) {
      return childrenWithKeys[tabIndex];
    }

    if (widget.lazyLoadBool == true) {
      pageVisibilityMap[tabIndex] = true;
    }
    List<int> visibleKeys = pageVisibilityMap.keys.where((int i) => pageVisibilityMap[i] == true).toList();

    final List<Widget> childrenVisibilityWidgets = visibleKeys.map<Widget>((int i) {
      bool visibleBool = i == tabIndex;
      return SliverVisibility(
        maintainState: true,
        maintainAnimation: true,
        visible: visibleBool,
        sliver: SliverAnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          opacity: visibleBool ? 1 : 0,
          sliver: childrenWithKeys[i],
        ),
      );
    }).toList();

    return SliverStack(
      children: childrenVisibilityWidgets,
    );
  }

  void _handleTabChanged() {
    if (mounted) {
      setState(() => tabIndex = widget.tabController.index);
    }
  }
}
