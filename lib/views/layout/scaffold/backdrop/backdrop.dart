import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef AppbarBuilder = Widget Function({required bool expandedBool});

class Backdrop extends StatefulWidget {
  final AppbarBuilder appbarBuilder;
  final Widget body;
  final Cubic animationCurve;

  const Backdrop({
    required this.appbarBuilder,
    required this.body,
    this.animationCurve = Curves.ease,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Backdrop();

  /// Provides access to the state from everywhere in the widget tree.
  static _Backdrop of(BuildContext context) {
    final _Backdrop? backdrop = context.findAncestorStateOfType<_Backdrop>();
    if (backdrop != null) {
      return backdrop;
    } else {
      throw Exception('Cannot get Backdrop state');
    }
  }
}

class _Backdrop extends State<Backdrop> with SingleTickerProviderStateMixin {
  final List<AnimationStatus> _collapsedAnimationStatusList = <AnimationStatus>[
    AnimationStatus.completed,
    AnimationStatus.forward,
  ];

  final List<AnimationStatus> _expandedAnimationStatusList = <AnimationStatus>[
    AnimationStatus.dismissed,
    AnimationStatus.reverse,
  ];

  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
    value: 1,
  );

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _isExpanded,
      onPopInvoked: (_) => _handlePopInvoked(context),
      child: Column(
        children: <Widget>[
          AnimatedBuilder(
            animation: animationController,
            builder: (_, __) => widget.appbarBuilder(expandedBool: _isExpanded),
          ),
          Expanded(child: widget.body),
        ],
      ),
    );
  }

  void invertVisibility() {
    FocusScope.of(context).unfocus();
    if (_isCollapsed) {
      expand();
    } else {
      collapse();
    }
  }

  void expand() {
    if (_isCollapsed) {
      animationController.animateBack(-1);
    }
  }

  void collapse() {
    if (_isExpanded) {
      animationController.animateTo(1);
    }
  }

  Future<void> _handlePopInvoked(BuildContext context) async {
    if (_isExpanded) {
      collapse();
    }
  }

  bool get _isCollapsed => _collapsedAnimationStatusList.contains(animationController.status);

  bool get _isExpanded => _expandedAnimationStatusList.contains(animationController.status);
}
