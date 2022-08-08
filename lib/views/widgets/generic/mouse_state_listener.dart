import 'package:flutter/material.dart';

class MouseStateListener extends StatefulWidget {
  final Widget Function(Set<MaterialState> states) childBuilder;
  final bool disabled;
  final bool selected;
  final GestureTapCallback? onTap;

  const MouseStateListener({
    required this.childBuilder,
    this.disabled = false,
    this.selected = false,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MouseStateListener();
}

class _MouseStateListener extends State<MouseStateListener> {
  Set<MaterialState> states = <MaterialState>{};

  @override
  void initState() {
    super.initState();
    _setInitialStates();
  }

  @override
  void didUpdateWidget(covariant MouseStateListener oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setInitialStates();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.none,
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
          onHover: (bool hovered) {
            if (hovered) {
              _addState(MaterialState.hovered);
            } else {
              _removeState(MaterialState.hovered);
              _removeState(MaterialState.pressed);
            }
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
