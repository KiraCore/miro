import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/mnemonic_text_field_controller.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/mnemonic_text_field_state.dart';

const double kPrefixWidth = 20;

class MnemonicTextFieldLayout extends StatelessWidget {
  final Widget editableWidget;
  final Widget hintWidget;
  final MnemonicTextFieldController mnemonicTextFieldController;
  final Widget prefixWidget;
  final double prefixWidth;

  const MnemonicTextFieldLayout({
    required this.editableWidget,
    required this.hintWidget,
    required this.mnemonicTextFieldController,
    required this.prefixWidget,
    this.prefixWidth = kPrefixWidth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Center(
              child: ValueListenableBuilder<MnemonicTextFieldState>(
                valueListenable: mnemonicTextFieldController.mnemonicTextFieldStateNotifier,
                builder: (_, MnemonicTextFieldState mnemonicTextFieldState, __) =>
                    _buildBackLayer(mnemonicTextFieldState),
              ),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.transparent, width: 1),
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: prefixWidth),
                    const SizedBox(width: 8),
                    Expanded(child: editableWidget),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackLayer(MnemonicTextFieldState mnemonicTextFieldState) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 5),
      decoration: BoxDecoration(
        color: _getBackgroundColor(mnemonicTextFieldState),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _getBorderColor(mnemonicTextFieldState),
          width: 1,
        ),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: prefixWidth,
            child: prefixWidget,
          ),
          const SizedBox(width: 8),
          Expanded(child: hintWidget),
        ],
      ),
    );
  }

  Color _getBackgroundColor(MnemonicTextFieldState mnemonicTextFieldState) {
    switch (mnemonicTextFieldState) {
      case MnemonicTextFieldState.error:
        return DesignColors.red_5;
      case MnemonicTextFieldState.focused:
        return DesignColors.blue1_5;
      default:
        return Colors.transparent;
    }
  }

  Color _getBorderColor(MnemonicTextFieldState mnemonicGridItemState) {
    switch (mnemonicGridItemState) {
      case MnemonicTextFieldState.error:
        return DesignColors.red_100;
      case MnemonicTextFieldState.focused:
        return DesignColors.blue1_100;
      default:
        return Colors.transparent;
    }
  }
}
