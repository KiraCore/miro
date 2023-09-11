import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/mnemonic_grid/text_field/mnemonic_text_field_cubit.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/wallet/mnemonic_text_field_status.dart';
import 'package:miro/views/widgets/mnemonic_grid/mnemonic_grid/mnemonic_text_field_actions/mnemonic_text_field_actions.dart';
import 'package:miro/views/widgets/mnemonic_grid/mnemonic_grid/mnemonic_text_field_layer.dart';

class MnemonicTextFieldLayersWrapper extends StatelessWidget {
  final Widget editableWidget;
  final Widget hintWidget;
  final Widget prefixWidget;
  final MnemonicTextFieldCubit mnemonicTextFieldCubit;
  final MnemonicTextFieldStatus mnemonicTextFieldStatus;

  const MnemonicTextFieldLayersWrapper({
    required this.editableWidget,
    required this.hintWidget,
    required this.prefixWidget,
    required this.mnemonicTextFieldCubit,
    required this.mnemonicTextFieldStatus,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MnemonicTextFieldActions(
      mnemonicTextFieldCubit: mnemonicTextFieldCubit,
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            MnemonicTextFieldLayer(
              backgroundColor: _backgroundColor,
              borderColor: _borderColor,
              prefixWidget: prefixWidget,
              mainWidget: hintWidget,
            ),
            MnemonicTextFieldLayer(
              backgroundColor: Colors.transparent,
              borderColor: Colors.transparent,
              mainWidget: editableWidget,
            ),
          ],
        ),
      ),
    );
  }

  Color get _backgroundColor {
    switch (mnemonicTextFieldStatus) {
      case MnemonicTextFieldStatus.focused:
        return DesignColors.greyHover1;
      case MnemonicTextFieldStatus.error:
        return DesignColors.redStatus3;
      default:
        return Colors.transparent;
    }
  }

  Color get _borderColor {
    switch (mnemonicTextFieldStatus) {
      case MnemonicTextFieldStatus.focused:
        return DesignColors.white1;
      case MnemonicTextFieldStatus.error:
        return DesignColors.redStatus1;
      default:
        return Colors.transparent;
    }
  }
}
