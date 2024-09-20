import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/mnemonic_grid/grid/mnemonic_grid_cubit.dart';
import 'package:miro/blocs/widgets/mnemonic_grid/hint/mnemonic_hint_cubit.dart';
import 'package:miro/blocs/widgets/mnemonic_grid/text_field/mnemonic_text_field_state.dart';
import 'package:miro/shared/models/wallet/mnemonic/mnemonic_text_field_status.dart';
import 'package:miro/shared/utils/cryptography/bip39/bip39_extension.dart';

class MnemonicTextFieldCubit extends Cubit<MnemonicTextFieldState> {
  final TextEditingController textEditingController = TextEditingController();
  final MnemonicHintCubit mnemonicHintCubit = MnemonicHintCubit();

  final int index;
  final MnemonicGridCubit mnemonicGridCubit;

  FocusNode? focusNode;

  MnemonicTextFieldCubit({
    required this.index,
    required this.mnemonicGridCubit,
  }) : super(const MnemonicTextFieldState.empty()) {
    textEditingController.addListener(_listenTextEditingController);
  }

  @override
  Future<void> close() {
    mnemonicHintCubit.close();
    textEditingController.dispose();
    return super.close();
  }

  void acceptHint() {
    String mnemonicWord = textEditingController.text.toLowerCase();
    String hintText = Bip39Extension.findMnemonicWord(mnemonicWord);

    if (mnemonicWord.isNotEmpty && hintText.isNotEmpty) {
      textEditingController.text = hintText;
    }
    mnemonicHintCubit.clearHint(placeholderVisibleBool: mnemonicWord.isEmpty);
  }

  void changeFocus({required bool textFieldFocusedBool}) {
    String mnemonicWord = textEditingController.text;
    if (textFieldFocusedBool) {
      mnemonicHintCubit.updateHint(wordPattern: mnemonicWord);
      emit(MnemonicTextFieldState(
        mnemonicText: mnemonicWord,
        mnemonicTextFieldStatus: MnemonicTextFieldStatus.focused,
      ));
    } else {
      mnemonicHintCubit.clearHint(placeholderVisibleBool: mnemonicWord.isEmpty);
      emit(MnemonicTextFieldState(
        mnemonicText: mnemonicWord,
        mnemonicTextFieldStatus: _getMnemonicTextFieldStatus(),
      ));
      mnemonicGridCubit.validateGrid();
    }
  }

  void clear() {
    textEditingController.clear();
    mnemonicHintCubit.clearHint(placeholderVisibleBool: true);
    focusNode?.unfocus();
    emit(const MnemonicTextFieldState.empty());
  }

  void setErrorStatus() {
    emit(state.copyWith(mnemonicTextFieldStatus: MnemonicTextFieldStatus.error));
  }

  void setValue(String value) {
    textEditingController.text = value;
    focusNode?.requestFocus();
  }

  void _listenTextEditingController() {
    String mnemonicWord = textEditingController.text.toLowerCase();
    mnemonicHintCubit.updateHint(wordPattern: mnemonicWord);
    bool textPastedBool = state.mnemonicTextFieldStatus != MnemonicTextFieldStatus.focused;
    if (textPastedBool) {
      emit(MnemonicTextFieldState(
        mnemonicText: mnemonicWord,
        mnemonicTextFieldStatus: _getMnemonicTextFieldStatus(),
      ));
    } else {
      emit(state.copyWith(mnemonicText: mnemonicWord));
    }
  }

  MnemonicTextFieldStatus _getMnemonicTextFieldStatus() {
    String mnemonicWord = textEditingController.text;
    bool mnemonicWordValidBool = Bip39Extension.isMnemonicWordValid(mnemonicWord);

    if (mnemonicWord.isEmpty) {
      return MnemonicTextFieldStatus.empty;
    } else if (mnemonicWordValidBool) {
      return MnemonicTextFieldStatus.valid;
    } else {
      return MnemonicTextFieldStatus.error;
    }
  }
}
