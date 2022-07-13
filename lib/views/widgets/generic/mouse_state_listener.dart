import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MouseStateListener extends StatefulWidget {
  final Widget Function(Set<MaterialState> states) childBuilder;
  final bool disableSplash;
  final bool disabled;
  final MouseCursor? mouseCursor;
  final ValueChanged<bool>? onHover;
  final GestureTapCallback? onTap;
  final bool selected;

  const MouseStateListener({
    required this.childBuilder,
    this.disableSplash = false,
    this.disabled = false,
    this.mouseCursor,
    this.onHover,
    this.onTap,
    this.selected = false,
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
      cursor: widget.mouseCursor ?? (widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.none),
      child: GestureDetector(
        onTapDown: (TapDownDetails details) {
          _addState(MaterialState.pressed);
        },
        onTapUp: (TapUpDetails details) {
          _removeState(MaterialState.pressed);
        },
        onTapCancel: () {
          _removeState(MaterialState.pressed);
        },
        child: InkWell(
          onTap: widget.onTap != null ? () => widget.onTap!() : null,
          splashFactory: widget.disableSplash ? NoSplash.splashFactory : null,
          splashColor: widget.disableSplash ? Colors.transparent : null,
          highlightColor: widget.disableSplash ? Colors.transparent : null,
          hoverColor: widget.disableSplash ? Colors.transparent : null,
          onHover: (bool hovered) {
            if (hovered) {
              _addState(MaterialState.hovered);
            } else {
              _removeState(MaterialState.hovered);
              _removeState(MaterialState.pressed);
            }
            widget.onHover?.call(hovered);
          },
          child: widget.childBuilder(states),
        ),
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
