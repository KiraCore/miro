import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/mnemonic_grid/text_field/mnemonic_text_field_cubit.dart';
import 'package:miro/views/widgets/mnemonic_grid/mnemonic_grid/mnemonic_text_field_actions/actions/accept_mnemonic_hint_intent.dart';

class AcceptMnemonicHintAction extends Action<AcceptMnemonicHintIntent> {
  final MnemonicTextFieldCubit mnemonicTextFieldCubit;

  AcceptMnemonicHintAction({
    required this.mnemonicTextFieldCubit,
  }) : super();

  @override
  void invoke(AcceptMnemonicHintIntent intent) {
    mnemonicTextFieldCubit.focusNode?.nextFocus();
    mnemonicTextFieldCubit.acceptHint();
  }
}
