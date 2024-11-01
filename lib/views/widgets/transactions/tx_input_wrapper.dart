import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class TxInputWrapper extends StatefulWidget {
  final Widget Function(FocusNode)? builderWithFocus;
  final Widget? child;
  final bool disabled;
  final bool hasErrors;
  final double? height;
  final BoxConstraints? boxConstraints;
  final EdgeInsets padding;

  const TxInputWrapper({
    this.builderWithFocus,
    this.child,
    this.disabled = false,
    this.hasErrors = false,
    this.height,
    this.boxConstraints,
    this.padding = const EdgeInsets.all(16),
    Key? key,
  })  : assert(builderWithFocus != null || child != null, 'Either [builderWithFocus] or [child] must be provided.'),
        super(key: key);

  @override
  State<TxInputWrapper> createState() => _TxInputWrapperState();
}

class _TxInputWrapperState extends State<TxInputWrapper> {
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.builderWithFocus != null ? focusNode.requestFocus : null,
      child: Opacity(
        opacity: widget.disabled ? 0.5 : 1,
        child: Container(
          height: widget.height,
          constraints: widget.boxConstraints,
          padding: widget.padding,
          decoration: BoxDecoration(
            color: DesignColors.background,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: widget.hasErrors ? DesignColors.redStatus1 : Colors.transparent,
              width: 1,
            ),
          ),
          child: widget.builderWithFocus != null ? widget.builderWithFocus!(focusNode) : widget.child,
        ),
      ),
    );
  }
}
