import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetMouseStateListener extends StatefulWidget {
  final Widget Function(Set<MaterialState> states) childBuilder;
  final bool disabled;
  final bool selected;
  final GestureTapCallback? onTap;

  const WidgetMouseStateListener({
    required this.childBuilder,
    this.disabled = false,
    this.selected = false,
    this.onTap,
    Key? key,
  }) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => _WidgetMouseStateListener();
}

class _WidgetMouseStateListener extends State<WidgetMouseStateListener> {
  Set<MaterialState> states = <MaterialState>{};
  
  @override
  void initState() {
    _setInitialStates();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant WidgetMouseStateListener oldWidget) {
    _setInitialStates();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap != null ? () => widget.onTap!() : null,
      onHover: (bool hovered) {
        if(hovered) {
          addState(MaterialState.hovered);
        } else {
          removeState(MaterialState.hovered);
        }
      },
      onTapDown: (TapDownDetails details) {
        addState(MaterialState.pressed);
      },
      onTapCancel: () {
        removeState(MaterialState.pressed);
      },
      child: widget.childBuilder(states),
    );
  }

  void addState(MaterialState state) {
    states.add(state);
    setState(() {});
  }

  void removeState(MaterialState state) {
    states.remove(state);
    setState(() {});
  }
  
  void _setInitialStates() {
    if( widget.disabled ) {
      states.add(MaterialState.disabled);
    } else {
      states.remove(MaterialState.disabled);
    }
    if( widget.selected ) {
      states.add(MaterialState.selected);
    } else {
      states.remove(MaterialState.selected);
    }
  }
}
