import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/app_sizes.dart';

class Backdrop extends InheritedWidget {
  /// Holds the state of this widget.
  final _BackdropAppBar backdropState;

  const Backdrop({
    required this.backdropState,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  /// Provides access to the state from everywhere in the widget tree.
  static _BackdropAppBar of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<Backdrop>()!.backdropState;

  @override
  bool updateShouldNotify(Backdrop oldWidget) => true;
}

typedef AppbarBuilder = Widget Function(bool isCollapsed);

/// Expandable widget called by the method [Backdrop.of(context).fling()]
class BackdropAppBar extends StatefulWidget {
  final AppbarBuilder appbarBuilder;
  final Cubic animationCurve;
  final double headerHeight;

  const BackdropAppBar({
    required this.appbarBuilder,
    this.animationCurve = Curves.ease,
    this.headerHeight = AppSizes.kKiraAppBarHeight,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BackdropAppBar();
}

class _BackdropAppBar extends State<BackdropAppBar> with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  bool get isBackLayerConcealed =>
      animationController.status == AnimationStatus.completed || animationController.status == AnimationStatus.forward;

  bool get isBackLayerRevealed =>
      animationController.status == AnimationStatus.dismissed || animationController.status == AnimationStatus.reverse;

  @override
  void initState() {
    setUpAnimationController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Backdrop(
      backdropState: this,
      child: _buildBackdrop(),
    );
  }

  Widget _buildBackdrop() {
    return WillPopScope(
      onWillPop: () => _willPopCallback(context),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return widget.appbarBuilder(isBackLayerRevealed);
        },
      ),
    );
  }

  Future<bool> _willPopCallback(BuildContext context) async {
    if (isBackLayerRevealed) {
      concealBackLayer();
      return false;
    }
    return true;
  }

  void setUpAnimationController() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: 1,
    )..addListener(() => setState(() {}));
  }

  void fling() {
    FocusScope.of(context).unfocus();
    if (isBackLayerConcealed) {
      revealBackLayer();
    } else {
      concealBackLayer();
    }
  }

  void revealBackLayer() {
    if (isBackLayerConcealed) {
      animationController.animateBack(-1);
    }
  }

  void concealBackLayer() {
    if (isBackLayerRevealed) {
      animationController.animateTo(1);
    }
  }
}
