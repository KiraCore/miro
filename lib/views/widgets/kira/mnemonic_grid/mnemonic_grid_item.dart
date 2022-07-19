// ignore: implementation_imports
import 'package:bip39/src/wordlists/english.dart' as bip39;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miro/config/theme/design_colors.dart';

enum MnemonicState {
  valid,
  invalid,
  empty,
}

class MnemonicGridItem extends StatefulWidget {
  final TextEditingController textController;
  final int index;
  final String? mnemonicWord;
  final bool editable;

  const MnemonicGridItem({
    required this.textController,
    required this.index,
    required this.editable,
    this.mnemonicWord,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MnemonicGridItem();
}

class _MnemonicGridItem extends State<MnemonicGridItem> {
  MnemonicState mnemonicState = MnemonicState.empty;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.textController.addListener(_validateMnemonicWord);

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        _setMnemonicState(MnemonicState.valid);
      }
    });
  }

  @override
  void dispose() {
    widget.textController.removeListener(_validateMnemonicWord);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      enabled: widget.editable,
      controller: widget.textController,
      textAlignVertical: TextAlignVertical.center,
      maxLines: 1,
      style: const TextStyle(
        fontSize: 12,
        color: DesignColors.gray3_100,
        letterSpacing: 3,
      ),
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(8),
      ],
      validator: (_) {
        _validateMnemonicWord();
        return null;
      },
      decoration: InputDecoration(
        isDense: true,
        errorText: null,
        errorMaxLines: null,
        filled: mnemonicState == MnemonicState.invalid,
        fillColor: mnemonicState == MnemonicState.invalid ? DesignColors.red_5 : null,
        errorStyle: const TextStyle(height: 0, color: Colors.transparent),
        label: const Text('------'),
        labelStyle: const TextStyle(
          color: DesignColors.white_100,
          fontSize: 12,
          letterSpacing: 4,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: SizedBox(
          width: 20,
          child: Center(
            child: Text(
              '${widget.index + 1}',
              style: const TextStyle(
                fontSize: 12,
                color: DesignColors.gray2_100,
              ),
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: _getBorderColor(),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: DesignColors.blue1_100,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _validateMnemonicWord() {
    String _word = widget.textController.text.replaceAll(' ', '');
    if (focusNode.hasFocus) {
      _setMnemonicState(MnemonicState.valid);
      return;
    }
    if (widget.index + 1 > 12 && _word.isEmpty) {
      _setMnemonicState(MnemonicState.valid);
      return;
    }
    bool validWord = bip39.WORDLIST.contains(_word);
    if (validWord) {
      _setMnemonicState(MnemonicState.valid);
    } else {
      _setMnemonicState(MnemonicState.invalid);
    }
  }

  void _setMnemonicState(MnemonicState newMnemonicState) {
    if (newMnemonicState != mnemonicState) {
      setState(() {
        mnemonicState = newMnemonicState;
      });
    }
  }

  Color _getBorderColor() {
    if (mnemonicState == MnemonicState.invalid) {
      return DesignColors.red_100;
    }
    return Colors.transparent;
  }
}
