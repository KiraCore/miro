import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MouseStateListener extends StatefulWidget {
  final Widget Function(Set<MaterialState> states) childBuilder;
  final bool disabled;
  final bool selected;
  final GestureTapCallback? onTap;
  final MouseCursor? cursor;

  const MouseStateListener({
    required this.childBuilder,
    this.disabled = false,
    this.selected = false,
    this.onTap,
    this.cursor,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MouseStateListener();
}

class _MouseStateListener extends State<MouseStateListener> {
  Set<MaterialState> states = <MaterialState>{};

  @override
  void initState() {
    _setInitialStates();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MouseStateListener oldWidget) {
    _setInitialStates();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.cursor ?? (widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic),
      onEnter: (_) {
        _addState(MaterialState.hovered);
      },
      onExit: (_) {
        _removeState(MaterialState.hovered);
        _removeState(MaterialState.pressed);
      },
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (TapDownDetails details) {
          _addState(MaterialState.pressed);
        },
        onTapUp: (TapUpDetails details) {
          _removeState(MaterialState.pressed);
        },
        onTapCancel: () {
          _removeState(MaterialState.pressed);
        },
        child: widget.childBuilder(states),
      ),
    );
  }

  void _setInitialStates() {
    if (widget.disabled) {
      states.add(MaterialState.disabled);
    } else {
      states.remove(MaterialState.disabled);
    }
    if (widget.selected) {
      states.add(MaterialState.selected);
    } else {
      states.remove(MaterialState.selected);
    }
  }

  void _addState(MaterialState state) {
    states.add(state);
    setState(() {});
  }

  void _removeState(MaterialState state) {
    states.remove(state);
    setState(() {});
  }
}
